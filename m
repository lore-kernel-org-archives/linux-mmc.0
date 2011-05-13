From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 1/4] sdhci add hooks for UHS setting by platform specific code
Date: Fri, 13 May 2011 11:17:15 +0530
Message-ID: <1305265638-1572-2-git-send-email-arindam.nath@amd.com>
References: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45648 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab1EMFsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 01:48:18 -0400
Received: by pwi15 with SMTP id 15so1037551pwi.19
        for <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 22:48:17 -0700 (PDT)
In-Reply-To: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, zhangfei.gao@gmail.com, Arindam Nath <arindam.nath@amd.com>

From: Philip Rakity <prakity@marvell.com>

Allow platform specific code to set UHS registers if
implementation requires speciial platform specific handling

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   33 ++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fa33016..cc63f5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1346,27 +1346,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
index 8ea11b7..7e28eec 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -270,6 +270,8 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.1

