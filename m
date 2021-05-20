Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B078C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85E961440
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhETKR6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 06:17:58 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:26417 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhETKPc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 06:15:32 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14KA1DkN077454;
        Thu, 20 May 2021 18:01:13 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from slee-VirtualBox.localdomain (192.168.100.253) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 18:13:52 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v4 3/3] mmc: sdhci-of-aspeed: Configure the SDHCIs as specified by the devicetree.
Date:   Thu, 20 May 2021 18:13:45 +0800
Message-ID: <20210520101346.16772-4-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520101346.16772-1-steven_lee@aspeedtech.com>
References: <20210520101346.16772-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14KA1DkN077454
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The hardware provides capability configuration registers for each SDHCI
in the global configuration space for the SD controller. Writes to the
global capability registers are mirrored to the capability registers in
the associated SDHCI. Configuration of the capabilities must be written
through the mirror registers prior to initialisation of the SDHCI.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d001c51074a0..65b5685f6c15 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -31,6 +31,11 @@
 #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
 #define   ASPEED_SDC_PHASE_MAX		31
 
+/* SDIO{10,20} */
+#define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
+/* SDIO{14,24} */
+#define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
+
 struct aspeed_sdc {
 	struct clk *clk;
 	struct resource *res;
@@ -72,6 +77,37 @@ struct aspeed_sdhci {
 	const struct aspeed_sdhci_phase_desc *phase_desc;
 };
 
+/*
+ * The function sets the mirror register for updating
+ * capbilities of the current slot.
+ *
+ *   slot | capability  | caps_reg | mirror_reg
+ *   -----|-------------|----------|------------
+ *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
+ *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
+ *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
+ *     1  | CAP2_SDR104 | SDIO244  |   SDIO24
+ */
+static void aspeed_sdc_set_slot_capability(struct sdhci_host *host, struct aspeed_sdc *sdc,
+					   int capability, bool enable, u8 slot)
+{
+	u32 mirror_reg_offset;
+	u32 cap_val;
+	u8 cap_reg;
+
+	if (slot > 1)
+		return;
+
+	cap_reg = capability / 32;
+	cap_val = sdhci_readl(host, 0x40 + (cap_reg * 4));
+	if (enable)
+		cap_val |= BIT(capability % 32);
+	else
+		cap_val &= ~BIT(capability % 32);
+	mirror_reg_offset = ((slot + 1) * 0x10) + (cap_reg * 4);
+	writel(cap_val, sdc->regs + mirror_reg_offset);
+}
+
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 					   struct aspeed_sdhci *sdhci,
 					   bool bus8)
@@ -328,6 +364,7 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	const struct aspeed_sdhci_pdata *aspeed_pdata;
+	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
@@ -372,6 +409,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
+	    of_property_read_bool(np, "sd-uhs-sdr104")) {
+		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP1_1_8V,
+					       true, slot);
+	}
+
+	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
+		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR104,
+					       true, slot);
+	}
+
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk))
 		return PTR_ERR(pltfm_host->clk);
-- 
2.17.1

