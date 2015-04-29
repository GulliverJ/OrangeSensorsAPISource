package main;

import generate.Sensor;

import manage.DataManager;
import manage.SendManager;

public class ParkingSim {

	private static int start;
	private static int end;
	
	public static void main(String[] args) {
		DataManager manager = new DataManager(args[0]);
		(new Thread(new SendManager(manager))).start();
		readRange(args[1]);
		
		for(int i = start; i <= end; i++) {
			(new Thread(new Sensor(manager, i))).start();
		}
		
	}
	
	public static void readRange(String range) {
		String st = range.substring(0, range.indexOf('-'));
		String en = range.substring(range.indexOf('-') + 1, range.length());
		start = Integer.parseInt(st);
		end = Integer.parseInt(en);
	}
	
}
