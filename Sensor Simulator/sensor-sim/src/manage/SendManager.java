package manage;


public class SendManager implements Runnable {

	DataManager manager;
	String identifier;
	private static boolean kill = false;
	
	public SendManager(DataManager manager) {
		this.manager = manager;
		this.identifier = manager.getIdent();
	}
	
	public void run() {
		while(!kill) {
			String raw = manager.getData();
			String data = identifier + ";" + raw;
			(new Thread(new DataSender(data))).start();
		}
	}
	
	public void kill() {
		kill = true;
	}
	
}
