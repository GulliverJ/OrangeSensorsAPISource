package generate;

import java.util.Random;

import manage.DataManager;


public class Sensor implements Runnable {
	
	private DataManager manager;
	private int id;
	private boolean kill = false;
	
	public Sensor(DataManager manager, int id) {
		this.manager = manager;
		this.id = id;
	}
	
	public void run() {
		
		Random rand = new Random();
		
		// Every minute that passes, the probability gets closed to 1/1 up to a
		// limit of 5 hours.
		// Intelligence - if the time is after 8pm, cars have a chance of staying til the following 8am. Say, 1 in 3 will stay overnight. So we can expect at least 3 bays to be in use overnight.
		// Intelligence - at night, time between changes increases (between 12pm and 6am)
		// For now, everything has the same prob and limited stay up to 5 hours. 5 hours is 300 minutes.
		// LATER: have the simulator read input; can set through terminal whether it's occupied or not, and it will change.
		// controlledsensor - for demo and testing purposes
		
		int initialWait = rand.nextInt(5);								//45
		try {
			Thread.sleep(60000*initialWait);					
		} catch (InterruptedException e) {
			return;
		}
		
		int freeFor;
		int occupiedFor;
		
		while(!kill) {
			freeFor = Math.abs((int) rand.nextGaussian()*10+20);			//*10+30
			occupiedFor = Math.abs((int) rand.nextGaussian()*10+20);		//*75+115
			if(freeFor < 2) {
				freeFor = 2;
			}
			
			if(occupiedFor < 2) {
				occupiedFor = 2;
			}
			
			try {
				manager.addUpdate(generateReadingWhen(true));
				Thread.sleep(60000 * occupiedFor);
			} catch (InterruptedException e) {
				System.out.println("Interrupted occupied");
			}
			
			try {
				manager.addUpdate(generateReadingWhen(false));
				Thread.sleep(60000 * freeFor);
			} catch (InterruptedException e) {
				System.out.println("Interrupted free");
			}
		}
		
	}
	
	private String generateReadingWhen(boolean free) {
		String result = "" + id + ":";
		Random rand = new Random();
		int reading;
		if(free) {
			reading = rand.nextInt(10) + 20;
		} else {
			reading = rand.nextInt(30) + 70;
		}
		result += Integer.toString(reading) + ";";
		return result;
	}
}
