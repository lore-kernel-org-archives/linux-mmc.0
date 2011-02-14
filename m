From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add ops to force delay in operations due to silicon
 issues
Date: Sun, 13 Feb 2011 23:21:05 -0800
Message-ID: <A35BF947-843D-429B-AC9D-17072F175D43@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36800 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHXY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:23:24 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


PXA168 controller needs at least 8 clocks before it can start the
next transaction.  When the bus speed is slow the CPU can get back
to the controller before the 8 clocks causing SD CRC errors.

Add a new host->op to call into platform specific code to delay
the operation until the time has expired

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8bd3e37..fb084c4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -925,6 +925,14 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
+	/*
+	 * we cannot talk to controller for 8 bus cycles according to sdio spec
+	 * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+	 * which is quite a LONG TIME on a fast cpu -- so delay if needed
+	 */
+	if (host->ops->platform_specific_delay)
+		host->ops->platform_specific_delay(host);
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index abb1170..d2fe13b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -245,6 +245,7 @@ struct sdhci_ops {
 	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 	unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
 				unsigned int ddr);
+	void	(*platform_specific_delay)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


