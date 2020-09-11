Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD011C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896EB214F1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="hofk5gxq";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiO0OuYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKHpn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:45:43 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38647 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbgIKHph (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2020 03:45:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EDF37C42;
        Fri, 11 Sep 2020 03:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Sep 2020 03:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pDChSN39tqRkN
        QAM7YiAOJfg0uxG4cS03G6jTG8UuWU=; b=hofk5gxqzfZMlnCwbiwg9B5CtDrOB
        O3J8C7PDvsiFJkapAEDjWH0k1GPZbntdJEnsvwQTuXaViPqPf4tZgmDUpHuRStph
        4nEg0+fYQN+IEsoiqoSJYZ6qfT+A6TnhoKwlXPUV+gD8i8se5y4r8HHMwnzczjAW
        vmIo54g6YiWUHF2/kobha3fTKS7VCEdjBzEWQC+R9kv88HiTE/t4l8NRY6ZKeDPZ
        F3d8kdDgovxJaytYUTyU//KGp9+amQZR0Hj306c5OZIID9SY9qF6bbvwJ9Y7/3Kj
        VxZCEU+ujVlMFJqk7+1kgK7DJZxf/up7CpLjuO1vZ6WVBGljQq3jtRauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pDChSN39tqRkNQAM7YiAOJfg0uxG4cS03G6jTG8UuWU=; b=KiO0OuYo
        FBnrYLzuXzpCvor9RRcZ48NfDlhmukO9i1lnix/H88i0onTcUc6hf7SD1eYajrwE
        5a3K7hwQgGdG6iXLFR6+aOpAIgmjZQGQYTKgaxZkIhhkiFEy0+qlZzzUV9eMDM2a
        9cRbbgHXwXiq6PQUTY9YZa0rfy2ZqykUM7r/YltDmShXtbGOmMqV6XYfIRbbYCJk
        YliPdukwkG9Fva3x4ENd+v7i6qOnPXoOj4F4kdpxKw41zZcXOK6acqvZM7bN91tf
        yXF+o+lnlPktULL9rI7evF9NJ5Wpc/U+JR802nB3I358HlIexa0av9h/X7CcADvj
        XbBg0wJ2Xt1BtQ==
X-ME-Sender: <xms:HytbX5uPoP5pWEqnyw2_6DtuVow6PU78Cc_NnWIWOthADEQUWpl9yA>
    <xme:HytbXyeDPMBVVyAts2tEg6J8WnShhviP5WM0AbdPAhggEQvRNHug7Yhd1vcQAcdy2
    iWZwQQlahQINu5wew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfies
    rghjrdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgle
    etteejffelffdvudduveeiffegteelvefhteenucfkphepudegrddvrddutdelrdekheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:HytbX8w57eha_xrzg8YodIcT7KVnsfeLtIRqQQt_eHU42_uJfCIGaQ>
    <xmx:HytbXwNQ4sMOLPMwx_5WqLDkMGmxP7jIcSLPvrG42Y3xwexQI2t66A>
    <xmx:HytbX5-HRlScUrGDWyKykwOa2jla0mq83epAvlFYR-U-tQSgFd22KQ>
    <xmx:HytbX1Y_AHGYsMQtHn_4-Oz-C8RhsdMAOJRq6u5UQCTJq5uqBSGZGw>
Received: from mistburn.lan (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id D38BC3064682;
        Fri, 11 Sep 2020 03:45:32 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Fri, 11 Sep 2020 17:14:51 +0930
Message-Id: <20200911074452.3148259-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911074452.3148259-1-andrew@aj.id.au>
References: <20200911074452.3148259-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Aspeed SD/eMMC controllers feature up to two SDHCIs alongside a
a set of "global" configuration registers. The global configuration
registers house controller-specific settings that aren't exposed by the
SDHCI, one example being a register for phase tuning.

The phase tuning feature is new in the AST2600 design. It's exposed as a
single register in the global register set and controls both the input
and output phase adjustment for each slot. As the settings are
slot-specific, the values to program are extracted from properties in
the SDHCI devicetree nodes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Rework devicetree parsing to minimise state disruption
* Switch some log statements from dev_info() to dev_dbg()
---
 drivers/mmc/host/sdhci-of-aspeed.c | 126 +++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4f008ba3280e..c61eb42e1ebb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -16,9 +16,19 @@
 
 #include "sdhci-pltfm.h"
 
-#define ASPEED_SDC_INFO		0x00
-#define   ASPEED_SDC_S1MMC8	BIT(25)
-#define   ASPEED_SDC_S0MMC8	BIT(24)
+#define ASPEED_SDC_INFO			0x00
+#define   ASPEED_SDC_S1_MMC8		BIT(25)
+#define   ASPEED_SDC_S0_MMC8		BIT(24)
+#define ASPEED_SDC_PHASE		0xf4
+#define   ASPEED_SDC_S1_PHASE_IN	GENMASK(25, 21)
+#define   ASPEED_SDC_S0_PHASE_IN	GENMASK(20, 16)
+#define   ASPEED_SDC_S1_PHASE_OUT	GENMASK(15, 11)
+#define   ASPEED_SDC_S1_PHASE_IN_EN	BIT(10)
+#define   ASPEED_SDC_S1_PHASE_OUT_EN	GENMASK(9, 8)
+#define   ASPEED_SDC_S0_PHASE_OUT	GENMASK(7, 3)
+#define   ASPEED_SDC_S0_PHASE_IN_EN	BIT(2)
+#define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
+#define   ASPEED_SDC_PHASE_MAX		31
 
 struct aspeed_sdc {
 	struct clk *clk;
@@ -28,9 +38,21 @@ struct aspeed_sdc {
 	void __iomem *regs;
 };
 
+struct aspeed_sdhci_phase_desc {
+	u32 value_mask;
+	u32 enable_mask;
+	u8 enable_value;
+};
+
+struct aspeed_sdhci_phase {
+	struct aspeed_sdhci_phase_desc in;
+	struct aspeed_sdhci_phase_desc out;
+};
+
 struct aspeed_sdhci {
 	struct aspeed_sdc *parent;
 	u32 width_mask;
+	const struct aspeed_sdhci_phase *phase;
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -50,6 +72,22 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 	spin_unlock(&sdc->lock);
 }
 
+static void
+aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
+			   const struct aspeed_sdhci_phase_desc *phase,
+			   uint8_t value)
+{
+	u32 reg;
+
+	spin_lock(&sdc->lock);
+	reg = readl(sdc->regs + ASPEED_SDC_PHASE);
+	reg &= ~(phase->enable_mask | phase->value_mask);
+	reg |= value << __ffs(phase->value_mask);
+	reg |= phase->enable_value << __ffs(phase->enable_mask);
+	writel(reg, sdc->regs + ASPEED_SDC_PHASE);
+	spin_unlock(&sdc->lock);
+}
+
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -155,8 +193,49 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_sdhci_configure_of(struct platform_device *pdev,
+				     struct aspeed_sdhci *sdhci)
+{
+	struct device_node *np;
+	struct device *dev;
+	u32 phase;
+
+	if (!sdhci->phase)
+		return 0;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	if (!of_property_read_u32(np, "aspeed,input-phase", &phase)) {
+		if (phase <= ASPEED_SDC_PHASE_MAX) {
+			aspeed_sdc_configure_phase(sdhci->parent,
+						   &sdhci->phase->in,
+						   phase);
+			dev_dbg(dev, "Input phase adjustment: %u", phase);
+		} else {
+			dev_err(dev, "Invalid input phase value: %u", phase);
+			return -EINVAL;
+		}
+	}
+
+	if (!of_property_read_u32(np, "aspeed,output-phase", &phase)) {
+		if (phase <= ASPEED_SDC_PHASE_MAX) {
+			aspeed_sdc_configure_phase(sdhci->parent,
+						   &sdhci->phase->out,
+						   phase);
+			dev_dbg(dev, "Output phase adjustment: %u", phase);
+		} else {
+			dev_err(dev, "Invalid output phase value: %u", phase);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
+	const struct aspeed_sdhci_phase *phase;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
@@ -181,7 +260,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
-	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
+	dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
+	phase = of_device_get_match_data(&pdev->dev);
+	if (phase)
+		dev->phase = &phase[slot];
 
 	sdhci_get_of_property(pdev);
 
@@ -195,6 +277,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	ret = aspeed_sdhci_configure_of(pdev, dev);
+	if (ret)
+		goto err_sdhci_add;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
@@ -230,10 +316,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_phase ast2600_sdhci_phase[] = {
+	/* SDHCI/Slot 0 */
+	[0] = {
+		.in = {
+			.value_mask = ASPEED_SDC_S0_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.value_mask = ASPEED_SDC_S0_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+	/* SDHCI/Slot 1 */
+	[1] = {
+		.in = {
+			.value_mask = ASPEED_SDC_S1_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.value_mask = ASPEED_SDC_S1_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+};
+
+/* If supported, phase adjustment fields are stored in the data pointer */
 static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sdhci", },
 	{ .compatible = "aspeed,ast2500-sdhci", },
-	{ .compatible = "aspeed,ast2600-sdhci", },
+	{ .compatible = "aspeed,ast2600-sdhci", .data = ast2600_sdhci_phase },
 	{ }
 };
 
-- 
2.25.1

