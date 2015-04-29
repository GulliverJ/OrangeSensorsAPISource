package manage;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.awt.Toolkit;

public class DataSender implements Runnable {
	private String data;
	
	public DataSender(String data) {
		this.data = data;
	}
	
	public void run() {
		Toolkit.getDefaultToolkit().beep();
		System.out.println("Sending Data: " + data);
		
		String rawAddress = "128.16.80.125";
		byte[] buf = new byte[256];
		DatagramSocket socket;
		InetAddress address;
		
		try {
			socket = new DatagramSocket();
			address = InetAddress.getByName(rawAddress);
			buf = data.getBytes("UTF-8");
		} catch (Exception e) {
			System.out.println("Failed on socket initialisation");
			return;
		}
		
		DatagramPacket packet = new DatagramPacket(buf, buf.length, address, 2014);
		
		try {
			socket.send(packet);
		} catch (IOException e) {
			System.out.println("IO Exception; couldn't send packet!");
		}

		socket.close();
	}
	
}
