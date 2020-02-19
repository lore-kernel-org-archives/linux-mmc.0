Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC4C34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6522464E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSIb5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:31:57 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50172 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSIbz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85F671A04FF;
        Wed, 19 Feb 2020 09:31:53 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B8861A054B;
        Wed, 19 Feb 2020 09:31:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D99DB402AB;
        Wed, 19 Feb 2020 16:31:42 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 12/14] mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
Date:   Wed, 19 Feb 2020 16:25:55 +0800
Message-Id: <1582100757-20683-7-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Currently, when use standard tuning, driver default disable DMA just before
send tuning command. But on i.MX8 usdhc, this is not enough. Need also clear
DMA_SEL. If not, once the DMA_SEL select AMDA2 before, even dma already disabled,
when send tuning command, usdhc will still prefetch the ADMA script from wrong
DMA address, then we will see IOMMU report some error which show lack of TLB
mapping.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 106097cbd0d4..786305309eb0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -639,10 +639,24 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			 * For DMA access restore the levels to default value.
 			 */
 			m = readl(host->ioaddr + ESDHC_WTMK_LVL);
-			if (val & SDHCI_TRNS_DMA)
+			if (val & SDHCI_TRNS_DMA) {
 				wml = ESDHC_WTMK_LVL_WML_VAL_DEF;
-			else
+			} else {
+				u8 ctrl;
 				wml = ESDHC_WTMK_LVL_WML_VAL_MAX;
+
+				/*
+				 * Since already disable DMA mode, so also need
+				 * to clear the DMASEL. Otherwise, for standard
+				 * tuning, when send tuning command, usdhc will
+				 * still prefetch the ADMA script from wrong
+				 * DMA address, then we will see IOMMU report
+				 * some error which show lack of TLB mapping.
+				 */
+				ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+				ctrl &= ~SDHCI_CTRL_DMA_MASK;
+				sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+			}
 			m &= ~(ESDHC_WTMK_LVL_RD_WML_MASK |
 			       ESDHC_WTMK_LVL_WR_WML_MASK);
 			m |= (wml << ESDHC_WTMK_LVL_RD_WML_SHIFT) |
-- 
2.17.1

