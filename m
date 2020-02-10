Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913CBC3B184
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6917821739
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJIzg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:55:36 -0500
Received: from inva021.nxp.com ([92.121.34.21]:53418 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgBJIzf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Feb 2020 03:55:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A312A21B034;
        Mon, 10 Feb 2020 09:55:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3003A21B035;
        Mon, 10 Feb 2020 09:55:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B45BC40314;
        Mon, 10 Feb 2020 16:55:21 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v3 13/14] mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
Date:   Mon, 10 Feb 2020 16:49:56 +0800
Message-Id: <1581324597-31031-8-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
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
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index dedc067cd0dd..44837e3014e8 100644
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

