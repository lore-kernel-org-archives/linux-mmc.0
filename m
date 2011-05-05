From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v4 14/15] sdhci add hooks for UHS setting by platform specific code
Date: Thu,  5 May 2011 12:19:10 +0530
Message-ID: <1304578151-1775-15-git-send-email-arindam.nath@amd.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43777 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEGx2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 02:53:28 -0400
Received: by pzk9 with SMTP id 9so838201pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2011 23:53:28 -0700 (PDT)
In-Reply-To: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Allow platform specific code to set UHS registers if
implementation requires speciial platform specific handling

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   33 ++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3c04547..c46561c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1347,27 +1347,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
index fb74dc6..55e6f9a 100644
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

