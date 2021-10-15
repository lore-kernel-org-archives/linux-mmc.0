Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904FAC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Oct 2021 02:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3C0610D1
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Oct 2021 02:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJOC1p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:27:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35004 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhJOC1o (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 22:27:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 209351A09DF;
        Fri, 15 Oct 2021 04:25:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DD2A81A09DD;
        Fri, 15 Oct 2021 04:25:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 88823183AD0B;
        Fri, 15 Oct 2021 10:25:36 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset standard tuning circuit
Date:   Fri, 15 Oct 2021 10:00:36 +0800
Message-Id: <1634263236-6111-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

To reset standard tuning circuit completely, after clear ESDHC_MIX_CTRL_EXE_TUNE,
also need to clear bit buffer_read_ready, this operation will finally clear the
USDHC IP internal logic flag execute_tuning_with_clr_buf, make sure the following
normal data transfer will not be impacted by standard tuning logic used before.

Find this issue when do quick SD card insert/remove stress test. During standard
tuning prodedure, if remove SD card, USDHC standard tuning logic can't clear the
internal flag execute_tuning_with_clr_buf. Next time when insert SD card, all
data related commands can't get any data related interrupts, include data transfer
complete interrupt, data timeout interrupt, data CRC interrupt, data end bit interrupt.
Always trigger software timeout issue. Even reset the USDHC through bits in register
SYS_CTRL (0x2C, bit28 reset tuning, bit26 reset data, bit 25 reset command, bit 24
reset all) can't recover this. From the user's point of view, USDHC stuck, SD can't
be recognized any more.

Fixes: d9370424c948 ("mmc: sdhci-esdhc-imx: reset tuning circuit when power on mmc card")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f18d169bc8ff..e658f0174242 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1187,6 +1187,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 ctrl;
+	int ret;
 
 	/* Reset the tuning circuit */
 	if (esdhc_is_usdhc(imx_data)) {
@@ -1199,7 +1200,22 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
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
 		}
 	}
 }
-- 
2.17.1

