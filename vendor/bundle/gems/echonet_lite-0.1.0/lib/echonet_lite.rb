# -*- coding: utf-8 -*-
require "echonet_lite/version"
require "socket"
require "ipaddr"

module EL
  def self.pattern(seoj,deoj,esv,epc,edt)
    if esv == 0x62
      msg = [
        0x10,
        0x81,
        0x36,0x10,
        seoj[0],seoj[1],seoj[2],
        deoj[0],deoj[1],seoj[2],
        esv,
        0x01,
        epc,	0x00
      ].pack("C*")
    elsif edt.is_a?Array
      msg = [
        0x10,
        0x81,
        0x36,0x10,
        seoj[0],seoj[1],seoj[2],
        deoj[0],deoj[1], deoj[2],
        esv,
        0x01,
        epc,	0x01
      ]
      msg += edt
      msg = msg.pack("C*")
    else
      msg = [
        0x10,
        0x81,
        0x36,0x10,
        seoj[0],seoj[1],seoj[2],
        deoj[0],deoj[1],seoj[2],
        esv,
        0x01,
        epc,	0x01 , edt
      ].pack("C*")
    end
    return msg
  end
  def self.udp_send(ip,msg)
    if ip != "224.0.23.0"
      udp_socket = UDPSocket.new()
      udp_socket.connect(ip,3610)
      udp_socket.send(msg,0)
      udp_socket.close
    else
      udp_s = UDPSocket.open()
      saddr_s = Socket.pack_sockaddr_in(3610, "224.0.23.0")
      mif_s= IPAddr.new("0.0.0.0").hton
      udp_s.setsockopt(Socket::IPPROTO_IP, Socket::IP_MULTICAST_IF, mif_s)
      udp_s.send(msg, 0, saddr_s)
      udp_s.close
    end
  end
  def self.SETI
    return 0x60
  end
  def self.SETC
    return 0x61
  end
  def self.GSET
    return 0x62
  end
  def self.sendOPC1(ip,seoj,deoj,esv,epc,edt=nil)
    def self.Hexadecimal_str(msg_str)
      msg_str = msg_str.scan(/.{1,#{2}}/)
      count = 0
      msg_str.each {|str|
        msg_str[count] = str.hex
        count+=1
      }
      msg_num = msg_str
      if msg_num.length == 1
        return msg_num[0]
      else
        return msg_num
      end
    end

    if seoj.is_a? String
      seoj = Hexadecimal_str(seoj)
    end
    if deoj.is_a? String
      deoj = Hexadecimal_str(deoj)
    end
    if esv.is_a? String
      esv = Hexadecimal_str(esv)
    end
    if epc.is_a? String
      epc = Hexadecimal_str(epc)
    end
    if edt.is_a? String
      edt = Hexadecimal_str(edt)
    end

    msg = pattern(seoj,deoj,esv,epc,edt)
    udp_send(ip,msg)
  end
  def self.sendString(ip,sendmsg)
    msg = [sendmsg].pack("H*")
    udp_send(ip,msg)
  end
  def self.search
    search_msg=[
      0x10,0x81,
      0x36,0x10,
      0x05,0xff,0x01,
      0x0e,0xf0,0x01,
      0x62,0x01,
      0xd6,0x00
    ].pack("C*")
    udp_send("224.0.23.0",search_msg)

  end
  def self.ReceivePrint
    udps = UDPSocket.open()
    udps.bind("0.0.0.0", 3610)
    mreq = IPAddr.new("224.0.23.0").hton + IPAddr.new("0.0.0.0").hton
    udps.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, mreq)

    udpsReceive = Thread.start {
      loop{
        packet,adder = udps.recvfrom(65535)
        p msg=packet.unpack("H*")
        p ipaddress = adder
      }
    }
  end
  def self.Receive(function)
    udps = UDPSocket.open()
    udps.bind("0.0.0.0", 3610)
    mreq = IPAddr.new("224.0.23.0").hton + IPAddr.new("0.0.0.0").hton
    udps.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, mreq)

    udpsReceive = Thread.start {
      loop{
        packet,adder = udps.recvfrom(65535)
        msg=packet.unpack("H*")
        function(msg,adder)
      }
    }
  end
end
