Hi there!

Our project is quite convoluted and may be difficult to initialise. Please immediately email gulliverjohnson@gmail.com
if you run into any issues when trying to set everything up. I've discussed with Dean that these alternative measures will
be appropriate should you need to run the system in your marking.

First of all, if you want to look at any of the Java code, be aware that they are MAVEN projects, and you should import
them as such. Once they're imported, you may also need to add in the orange-java-api.jar to the build path.

We're assuming that you won't be setting up the databases yourselves and installing all of the dependencies.

We have included the database schemas if you'd like to look into this, though.

We've also developed the databases locally on our own VM on the CS dept.

Here's the process you'll need to take to get the main system up and running.

NOTE: This is assuming you're on a Linux environment on the CS servers in the department.

1. Unpack everything into a convenient folder and examine it as necessary - you won't actually need most of it for now.
2. SSH into our server like this:

	ssh ganslowj@victokoh.cs.ucl.ac.uk/

with password 'markme123'

3. Navigate to /opt/
4. sudo java -jar data-receiver_1.05.jar
   This will start the server software running. Run it in the background if you can, to save opening terminal windows.
   Note: You'll get three standard warning messages followed by nothing. That's fine; it's just waiting for input.

5. Open up a new terminal, SSH in, navigate to /var/, and run:

   sudo java -jar analytics_2.3.jar

   This will initialise the analytics software for the parking app at http://victokoh.cs.ucl.ac.uk/parking
   It will check every 10 seconds for new readings.

6. Open up a new terminal AGAIN and run

   sudo java -jar sensor_sim_20min.jar "efgh5678" "1-11"

   This will run the 20-minute-average simulator for sensors 1-11 belonging to user with ID efgh5678. They're the parking bays
   around gordon square on http://victokoh.cs.ucl.ac.uk/parking, with bay_id = 1 - 11.
   This will take a minute or two to start doing anything, also, so I'd say once these are all running, leave them for a few
   minutes before you can start seeing them do anything.