From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Control drive strength in software
Date: Mon, 4 Feb 2013 14:08:28 +0100
Message-ID: <510FB2CC.20201@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:48646 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab3BDNK4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Feb 2013 08:10:56 -0500
Received: from ONYX.xi-lite.lan (unknown [193.34.35.244])
	by co202.xi-lite.net (Postfix) with ESMTPS id 50982260359
	for <linux-mmc@vger.kernel.org>; Mon,  4 Feb 2013 14:26:12 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I'm working on a SDHCI driver for linux kernel 3.4.

  The IP that I have to control does not control the Driver Strength. 
Driver Type B is always selected. On the other hand, I can control the 
drive strength of the pads in software.

I would like to use the interface select_drive_strength of the 
mmc_host_ops. Is it a good idea?

If so, I have an other issue.

This function doesn't have an mmc_host as parameter. It is an issue for 
me since the drive strength parameters can be board specific.
A solution would be to add this parameter:

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 5674504..cb6d117 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -134,7 +134,7 @@ struct mmc_host_ops {
         /* The tuning command opcode value is different for SD and eMMC 
cards */
         int     (*execute_tuning)(struct mmc_host *host, u32 opcode);
         void    (*enable_preset_value)(struct mmc_host *host, bool enable);
-       int     (*select_drive_strength)(unsigned int max_dtr, int 
host_drv, int card_drv);
+       int     (*select_drive_strength)(struct mmc_host *host, unsigned 
int max_dtr, int host_drv, int card_drv);
         void    (*hw_reset)(struct mmc_host *host);
  };

Is this solution a good idea?

Also, the drive strength configuration might be different according to 
the mode (not only UHS). So, I would like to control the drive strength 
for the default speed and the high speed. Would it be relevant to add 
this a call to this function in mmc_sd_switch_hs or in mmc_sd_init_card?

Thanks,

Jeremie Samuel
