From: "Paul Parsons" <lost.distance@yahoo.com>
Subject: [PATCH] mmc: tmio: Fix tmio MMC_POWER_UP
Date: Wed, 20 Apr 2011 18:41:04 +0000
Message-ID: <E1QCcKn-0002iC-AM@outmx05.plus.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:19233 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485Ab1DTSuu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 14:50:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ian@mnementh.co.uk

Fix tmio MMC_POWER_UP invocation which had been broken in linux-2.6.39-rc1. In tmio_mmc_set_ios() an affirmative test for ios->clock == 0 executes the MMC_POWER_OFF block regardless of ios->power_mode. Because mmc_power_up() invokes MMC_POWER_UP before setting ios->clock, tmio_mmc_set_ios() turns the MMC power off instead of on.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.39-rc4/drivers/mmc/host/tmio_mmc_pio.c	2011-04-20 19:13:27.144322768 +0100
+++ linux-2.6.39-rc4/drivers/mmc/host/tmio_mmc_pio.c	2011-04-20 19:11:49.135616453 +0100
@@ -728,7 +728,7 @@ static void tmio_mmc_set_ios(struct mmc_
 		tmio_mmc_set_clock(host, ios->clock);
 
 	/* Power sequence - OFF -> UP -> ON */
-	if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
+	if (ios->power_mode == MMC_POWER_OFF) {
 		/* power down SD bus */
 		if (ios->power_mode == MMC_POWER_OFF && host->set_pwr)
 			host->set_pwr(host->pdev, 0);

