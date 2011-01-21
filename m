From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add ops to force delay in operations due to silicon
 issues
Date: Fri, 21 Jan 2011 11:30:30 -0800
Message-ID: <84845C3D-FBE0-4F4B-AA9C-4EAD9DA316C9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46207 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754882Ab1AUTcS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:32:18 -0500
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
index 6486009..ff9d5f0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -922,6 +922,14 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
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
index a8c43c9..91749dc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -225,6 +225,7 @@ struct sdhci_ops {
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
+	void	(*platform_specific_delay)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


