Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F1ECAAA1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Oct 2022 09:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJ1J0H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJ1JZc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2022 05:25:32 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3581AF33
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 02:25:16 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EA921A0DC7;
        Fri, 28 Oct 2022 11:25:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FEF81A0DC5;
        Fri, 28 Oct 2022 11:25:15 +0200 (CEST)
Received: from local (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BD4B180327D;
        Fri, 28 Oct 2022 17:25:13 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, sherry.sun@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before execute tuning
Date:   Fri, 28 Oct 2022 17:04:29 +0800
Message-Id: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For standard tuning method on usdhc, the previous tuning result can
impact current tuning result, let current tuning can't set the correct
delay cell. And from the logic, this is also reasonable for manual
tuning method. So reset the tuning logic before execute tuning.
To avoid compile issue, this patch also move the esdhc_reset_tuning()
upper.

Find this issue when support SDIO WiFi in band wakeup feature. After
system resume back, will do re-tuning, but then meet data CRC error.

Do not meet this issue on SD/eMMC, because we already call
esdhc_reset_tuning() when config the legency ios, and SD/eMMC need
to re-init when system resume back, but SDIO device don't do re-init
if it has MMC_PM_KEEP_POWER pm_flags.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 82 ++++++++++++++++--------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b073e79dcd99..4559599d897d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1012,6 +1012,44 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 			SDHCI_HOST_CONTROL);
 }
 
+static void esdhc_reset_tuning(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 ctrl;
+	int ret;
+
+	/* Reset the tuning circuit */
+	if (esdhc_is_usdhc(imx_data)) {
+		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
+			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
+			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
+				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
+			if (ret == -ETIMEDOUT)
+				dev_warn(mmc_dev(host->mmc),
+				 "Warning! clear execute tuning bit failed\n");
+			/*
+			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
+			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
+			 * will finally make sure the normal data transfer logic correct.
+			 */
+			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
+			ctrl |= SDHCI_INT_DATA_AVAIL;
+			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
+		}
+	}
+}
+
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1023,6 +1061,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->timing == MMC_TIMING_UHS_DDR50)
 		return 0;
 
+	/*
+	 * Reset tuning circuit logic. If not, the previous tuning result
+	 * will impact current tuning, make current tuning can't set the
+	 * correct delay cell.
+	 */
+	esdhc_reset_tuning(host);
 	return sdhci_execute_tuning(mmc, opcode);
 }
 
@@ -1196,44 +1240,6 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
 }
 
-static void esdhc_reset_tuning(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
-	int ret;
-
-	/* Reset the tuning circuit */
-	if (esdhc_is_usdhc(imx_data)) {
-		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
-			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
-			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
-			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
-		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
-			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
-			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
-				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
-			if (ret == -ETIMEDOUT)
-				dev_warn(mmc_dev(host->mmc),
-				 "Warning! clear execute tuning bit failed\n");
-			/*
-			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
-			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
-			 * will finally make sure the normal data transfer logic correct.
-			 */
-			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
-			ctrl |= SDHCI_INT_DATA_AVAIL;
-			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
-		}
-	}
-}
-
 static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	u32 m;
-- 
2.34.1

