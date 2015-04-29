package manage;

import java.util.ArrayList;

public class DataManager {
	private String identifier;
	private volatile ArrayList<String> updates = new ArrayList<String>();
	
	public DataManager(String identifier) {
		this.identifier = identifier;
	}
	
	public synchronized void addUpdate(String update) {
		updates.add(update);
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		notify();
	}
	
	public synchronized String getData() {
		try {
			while(updates == null || updates.size() == 0) {
				wait();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String data = "";
		for(int i = 0; i < updates.size(); i++) {
			data += updates.get(0);
			updates.remove(0);
		}
		return data;

	}
	
	public String getIdent() {
		return identifier;
	}
	
}
