Return-Path: <SRS0=NsbL=AF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EC1C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Jun 2020 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFC92082F
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Jun 2020 08:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbgFXIP4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:15:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39730 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388048AbgFXIP4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Jun 2020 04:15:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AD5D200F85;
        Wed, 24 Jun 2020 10:15:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D11A200F8C;
        Wed, 24 Jun 2020 10:15:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F95E402CA;
        Wed, 24 Jun 2020 16:15:43 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: dump internal IC debug status during error
Date:   Wed, 24 Jun 2020 16:03:50 +0800
Message-Id: <1592985830-13038-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

USDHC of i.MX has internal IC debug register, which record the IC
logical status. So dump these logical status in error condition,
this can help analyzing issue.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1d7f84b23a22..a76b4513fbec 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -38,6 +38,16 @@
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
 #define  ESDHC_VENDOR_SPEC_VSELECT	(1 << 1)
 #define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
+#define ESDHC_DEBUG_SEL_AND_STATUS_REG		0xc2
+#define ESDHC_DEBUG_SEL_REG			0xc3
+#define ESDHC_DEBUG_SEL_MASK			0xf
+#define ESDHC_DEBUG_SEL_CMD_STATE		1
+#define ESDHC_DEBUG_SEL_DATA_STATE		2
+#define ESDHC_DEBUG_SEL_TRANS_STATE		3
+#define ESDHC_DEBUG_SEL_DMA_STATE		4
+#define ESDHC_DEBUG_SEL_ADMA_STATE		5
+#define ESDHC_DEBUG_SEL_FIFO_STATE		6
+#define ESDHC_DEBUG_SEL_ASYNC_FIFO_STATE	7
 #define ESDHC_WTMK_LVL			0x44
 #define  ESDHC_WTMK_DEFAULT_VAL		0x10401040
 #define  ESDHC_WTMK_LVL_RD_WML_MASK	0x000000FF
@@ -348,6 +358,34 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
 }
 
+#define DRIVER_NAME "sdhci-esdhc-imx"
+#define ESDHC_IMX_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+static void esdhc_dump_debug_regs(struct sdhci_host *host)
+{
+	int i;
+	char *debug_status[7] = {
+				 "cmd debug status",
+				 "data debug status",
+				 "trans debug status",
+				 "dma debug status",
+				 "adma debug status",
+				 "fifo debug status",
+				 "async fifo debug status"
+	};
+
+	ESDHC_IMX_DUMP("========= ESDHC IMX DEBUG STATUS DUMP =========\n");
+	for (i = 0; i < 7; i++) {
+		esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK,
+			ESDHC_DEBUG_SEL_CMD_STATE + i, ESDHC_DEBUG_SEL_REG);
+		ESDHC_IMX_DUMP("%s:  0x%04x\n", debug_status[i],
+			readw(host->ioaddr + ESDHC_DEBUG_SEL_AND_STATUS_REG));
+	}
+
+	esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK, 0, ESDHC_DEBUG_SEL_REG);
+
+}
+
 static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 {
 	u32 present_state;
@@ -1237,6 +1275,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,
 	.irq = esdhc_cqhci_irq,
+	.dump_vendor_regs = esdhc_dump_debug_regs,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
2.17.1

