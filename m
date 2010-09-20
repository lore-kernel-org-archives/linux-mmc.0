From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: add quirk for controllers that don't support
	write only detect
Date: Mon, 20 Sep 2010 09:00:30 -0700
Message-ID: <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
 <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
 <4BA72971.1070804@nokia.com>
 <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:44383 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0ITQAd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 12:00:33 -0400
In-Reply-To: <20100920061459.GA9353@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


There are a couple of other items that I wanted to fix which I can submit patches for separately or can incorporate into your structure or we can work together.  Advise.

a) There needs to be a distinction between PRESENT STATE broken and a SD card that IS present (as in mounted on the board).  There is no need to poll for the later case.  The current quirk makes no distinction between these two cases.

b) Some eMMC chips require 74 clocks to start working.  The current code assumes turning on the clock (in the core/ directory) does this.  This is not always the case.  I modified the set_ios function to fix this.

snippet below (WILL not patch into 2.6.36 tree since I have other code) -- just so you get the idea --

--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -383,7 +383,7 @@ struct sdhci_ops {
 	void		(*platform_set_8_bit)(struct sdhci_host *host);
 	void		(*platform_clear_8_bit)(struct sdhci_host *host);
 	void		(*platform_specific_sdhci_enable_dummy_cmd) (struct sdhci_host *host, int dummycmd);
-	void		(*platform_specific_init_clocks)(struct sdhci_host *host);
+	void		(*platform_generate_initial_74_clocks)(struct sdhci_host *host, u8 power_mode);
 };


--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1279,8 +1279,11 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
-	else
+	else {
 		sdhci_set_power(host, ios->vdd);
+		if (host->ops->platform_generate_initial_74_clocks)
+			host->ops->platform_generate_initial_74_clocks(host, ios->power_mode);
+	}

In my adaption layer 
+void generate_init_clocks(struct sdhci_host *host, u8 power_mode)
+{
+	if (slot->power_mode == MMC_POWER_UP 
+	&& power_mode == MMC_POWER_ON) {
		/* slot has old state */
+		/* now do chip/board specific activity */
+	}
+	slot->power_mode = power_mode;
+}


Philip

On Sep 19, 2010, at 11:14 PM, Wolfram Sang wrote:

> On Sun, Sep 19, 2010 at 02:46:40PM -0700, Philip Rakity wrote:
>> 
>> 
>> Some board designs for embedded systems  do not always bring up the SD Host Write Protect Signal.  
>> This patch defines a new quirk that when enabled enables write access.
> 
> I am preparing a patch series which will also make get_ro an overloadable
> function. Then, board specific things could be handled there.
> 
> Regards,
> 
>   Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

