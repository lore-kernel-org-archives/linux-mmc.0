From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add quirk for controllers that don't support write
 only detect
Date: Sun, 19 Sep 2010 14:46:40 -0700
Message-ID: <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
 <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
 <4BA72971.1070804@nokia.com>
 <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:36012 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0ISVqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Sep 2010 17:46:43 -0400
In-Reply-To: <4BB052F6.5080808@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>



Some board designs for embedded systems  do not always bring up the SD Host Write Protect Signal.  
This patch defines a new quirk that when enabled enables write access.

>From 032242c62e0fe22eb6f5a4e0311eaab67ef54cbe Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Sep 2010 14:34:02 -0700
Subject: [PATCH] sdhci: add quirk for controllers that don't support write only detect
 Signed-off-by: Philip Rakity <prakity@marvell.com>

---
 drivers/mmc/host/sdhci.c |    2 ++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..e2b1f32 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1213,6 +1213,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		present = 0;
+	else if (host->quirks & SDHCI_NO_SUPPORT_FOR_WRITE_PROTECT)
+		present = SDHCI_WRITE_PROTECT;
 	else
 		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d316bc7..290b5a8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -247,6 +247,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* Controller does not have write protect signal		*/
+#define SDHCI_NO_SUPPORT_FOR_WRITE_PROTECT		(1<<30)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.0.4
 