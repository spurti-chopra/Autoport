package com.autoport.testcases;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.FluentWait;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.autoport.pageobjects.BuildServersTab;
import com.autoport.pageobjects.HomePage;
import com.autoport.utilities.CommonFunctions;

public class BS_UseCase_4 {
	
	WebDriver driver;
	FluentWait<WebDriver> wait;
	CommonFunctions functions;
	HomePage homePage;
	BuildServersTab buildServerTab;
	
	 @Parameters({"browser"})
	 @BeforeTest
	  public void beforeTest(String browser) throws Exception {
		 //String browser = "firefox";
		 functions = new CommonFunctions();
		 functions.launchBrowser(browser);	
		 
		 driver = functions.driver;
		 homePage = functions.homePage;
		 buildServerTab = functions.buildServerTab;
		 
		 functions.openAutoport();
		 functions.goTo_ListInstallSingleSoftwarSection();	
	  }
	 @Test (priority=0, dataProvider = "buildServers")
	  public void BS_Update_Package_On_Servers(String buildServer, String packagename) throws Exception{
		  
		  buildServerTab.enterPackageToSearch(packagename); 
		  
		  buildServerTab.selectBuildServer(buildServer);
		  
		  buildServerTab.clickListBtn();
		  
		  buildServerTab.verifyInstallRemoveButtons("disabled");
		  
		  String packegeselected =  buildServerTab.selectRandomPackageToInstall();
		  
		  buildServerTab.verifyInstallRemoveButtons("enabled");
		  
		  buildServerTab.clickInstallUpdateBtn();
		  
		  
	  }
	 
	 @DataProvider(name = "buildServers")
	  
	  public static Object[][] listBuildServers() { 
	 
		  return new Object[][] {{"ppcle-ubuntu" ,"python-bson"},{"x86-ubuntu" ,"python-bson"}};	 
	  }	

}