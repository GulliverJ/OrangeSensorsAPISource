-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: orangeparking
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bay_analysis`
--

DROP TABLE IF EXISTS `bay_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bay_analysis` (
  `bay_id` int(11) NOT NULL,
  `ave_daily_availability` time DEFAULT NULL,
  `days_counted` int(11) DEFAULT NULL,
  PRIMARY KEY (`bay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bay_data`
--

DROP TABLE IF EXISTS `bay_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bay_data` (
  `bay_id` int(11) NOT NULL,
  `occupied` tinyint(4) DEFAULT NULL,
  `state_timespan` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bay_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `bay_data_view`
--

DROP TABLE IF EXISTS `bay_data_view`;
/*!50001 DROP VIEW IF EXISTS `bay_data_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `bay_data_view` (
 `bay_id` tinyint NOT NULL,
  `occupied` tinyint NOT NULL,
  `timespan` tinyint NOT NULL,
  `legally_occupied` tinyint NOT NULL,
  `state_time` tinyint NOT NULL,
  `time_remaining` tinyint NOT NULL,
  `restricted` tinyint NOT NULL,
  `max_stay` tinyint NOT NULL,
  `nearest_unoccupied_bay` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bays`
--

DROP TABLE IF EXISTS `bays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bays` (
  `bay_id` int(11) NOT NULL AUTO_INCREMENT,
  `global_id` int(11) NOT NULL,
  `lat` float(9,6) NOT NULL,
  `lng` float(9,6) NOT NULL,
  `restriction_id` int(11) DEFAULT '4',
  PRIMARY KEY (`bay_id`),
  UNIQUE KEY `global_id` (`global_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restrictions`
--

DROP TABLE IF EXISTS `restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `includes_weekend` tinyint(4) DEFAULT NULL,
  `max_stay` time DEFAULT NULL,
  `hourly_charge` float(4,2) DEFAULT NULL,
  PRIMARY KEY (`restriction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `bay_data_view`
--

/*!50001 DROP TABLE IF EXISTS `bay_data_view`*/;
/*!50001 DROP VIEW IF EXISTS `bay_data_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bay_data_view` AS select `bays`.`bay_id` AS `bay_id`,`bay_data`.`occupied` AS `occupied`,`bay_data`.`state_timespan` AS `timespan`,(case when (`bay_data`.`occupied` = '1') then ((cast(now() as time) < `restrictions`.`start`) or (cast(now() as time) > `restrictions`.`end`) or ifnull((timestampdiff(SECOND,`bay_data`.`state_timespan`,now()) < time_to_sec(`restrictions`.`max_stay`)),1)) else NULL end) AS `legally_occupied`,timestampdiff(SECOND,`bay_data`.`state_timespan`,now()) AS `state_time`,(case when (`bay_data`.`occupied` = '1') then (time_to_sec(`restrictions`.`max_stay`) - timestampdiff(SECOND,`bay_data`.`state_timespan`,now())) else NULL end) AS `time_remaining`,((cast(now() as time) > `restrictions`.`start`) and (cast(now() as time) < `restrictions`.`end`)) AS `restricted`,time_to_sec(`restrictions`.`max_stay`) AS `max_stay`,`nearest_bay`(`bays`.`bay_id`) AS `nearest_unoccupied_bay` from ((`bay_data` join `bays` on((`bay_data`.`bay_id` = `bays`.`bay_id`))) join `restrictions` on((`bays`.`restriction_id` = `restrictions`.`restriction_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-27  4:06:54
