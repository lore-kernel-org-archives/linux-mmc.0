From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add hooks for UHS setting by platform specific code
Date: Fri, 22 Apr 2011 13:25:09 -0700
Message-ID: <44463C08-1383-4B9D-8149-0641F6A62987@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33053 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755120Ab1DVU0O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:26:14 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


Allow platform specific code to set UHS registers if
implementation requires speciial platform specific handling

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   33 ++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 20e6bea..d814f46 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1396,27 +1396,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sdhci_set_clock(host, clock);
 		}
 
-		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-		/* Select Bus Speed Mode for host */
-		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-		if (ios->timing == MMC_TIMING_UHS_SDR12)
-			ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-		else if (ios->timing == MMC_TIMING_UHS_SDR25)
-			ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
-		else if (ios->timing == MMC_TIMING_UHS_SDR50)
-			ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-		else if (ios->timing == MMC_TIMING_UHS_SDR104)
-			ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
-		else if (ios->timing == MMC_TIMING_UHS_DDR50)
-			ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
 
 		/* Reset SD Clock Enable */
 		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 		clk &= ~SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		if (host->ops->set_uhs_signaling)
+			host->ops->set_uhs_signaling(host, ios->timing);
+		else {
+			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			/* Select Bus Speed Mode for host */
+			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+			if (ios->timing == MMC_TIMING_UHS_SDR12)
+				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+			else if (ios->timing == MMC_TIMING_UHS_SDR25)
+				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+			else if (ios->timing == MMC_TIMING_UHS_SDR50)
+				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+			else if (ios->timing == MMC_TIMING_UHS_SDR104)
+				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+			else if (ios->timing == MMC_TIMING_UHS_DDR50)
+				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		}
 
 		/* Re-enable SD Clock */
 		clock = host->clock;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e891170..70e9edd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -272,6 +272,8 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	int 	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


