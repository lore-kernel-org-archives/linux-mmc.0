Return-Path: <SRS0=ANdn=CT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C10C43461
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410D42145D
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 10:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mL8RVif4";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apAmQtO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgIJK47 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:56:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50435 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730547AbgIJKzA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 06:55:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B70615C10CE;
        Thu, 10 Sep 2020 06:54:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 06:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=b39hUoDApUyJA
        sbeVSdyaxD9TS5GPbpLnEK8vl0nBW0=; b=mL8RVif4AlcH7g62bVChFe9+3EHaU
        hfOR3CuxTrbpgVHX8RdVchbQ2i68oD+038UHyJ8fgFPehxpzmg8rUCUUGkI3/uAw
        kk7AosWdq80dwo4wYk5TUt3tJkOhG7Kz8piQky+prycD6uoap/2QTwc53ujk5RaU
        SQjtAV5Cel4gT1apqujstWcZzqjwSkRcEqICjK7U9VeHx3rKvupwFckXVmK41U3U
        Q8ncF+ArqlN3QfbqGhuVOi6jPJElNVuUQjrZM2jXUSggQL8SrRzBfdpMrQurwsbQ
        KsUK9Mb7y8V/4dm9Y9+6xA94zXfJqkk3/rW8ATwa5ytI0uBjKS0Fsj9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=b39hUoDApUyJAsbeVSdyaxD9TS5GPbpLnEK8vl0nBW0=; b=apAmQtO0
        iDUFkxg6MPUCP3N7fSNcfLzF0zR7fAbNkCkMOIgY0fRPOKO0PUsfHkkPkF3Eg69W
        Tr8rYK28OiAYTHYVJDDlXdhL+c+1gEULoqcKnARc/wnEHI7VuKXsPbQn8zOTxlW7
        F9RtXYCRJ/UOG7BL5D07zfVXGLIX26cQgPH2hABGt7gb8NB6wFbygky8D98uf4WQ
        3SAbWNE5NsbJ7OSvqGyEmZIKP9Urr880UD6MErXnLymb8vKNn1zuI1WHv2x7URjF
        R/VRXFPmKknHYCvhk3DU5Fpz3/bmE3Aoq/OAXKjlURBSkqmQGfQdR7eREmfyu+0s
        lOVjQ5Z1oepqYg==
X-ME-Sender: <xms:AgZaX2a5ehp4C-hZwaSE26qT5ZCbwYqfJjMxpCZswTRrzPYdFAudiw>
    <xme:AgZaX5aw0C4AvR4b4UFlCe8OMsAvYE9nNC-p8SnqqUEk8c2KfMnQfFBiJePRq-EhJ
    bLWy11AFqpToHlDlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedugedrvddruddtledrkeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvg
    ifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:AgZaXw9MKkO97H91DPaw6GFGyPg66ejXcd3q3JCTpLStBqxk0vJ4Nw>
    <xmx:AgZaX4pID_6OB7y_d51blKh4DAgQBrOnQT8izNYf3GipU8CgRcWRkA>
    <xmx:AgZaXxqjKa9YJLp0C0TIPR2EC3DCOUPsYE7QqCPvqfRbAsrIOS9QJg>
    <xmx:AgZaXydEQZxRsFr7NntisqS8WnlooxJinwoHZWD9-BGmznLlbp_Sug>
Received: from localhost.localdomain (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D38D306467D;
        Thu, 10 Sep 2020 06:54:55 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
Date:   Thu, 10 Sep 2020 20:24:39 +0930
Message-Id: <20200910105440.3087723-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910105440.3087723-1-andrew@aj.id.au>
References: <20200910105440.3087723-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Allow sample phase adjustment to deal with layout or tolerance issues.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4f008ba3280e..641accbfcde4 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -16,9 +16,18 @@
 
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
 
 struct aspeed_sdc {
 	struct clk *clk;
@@ -28,9 +37,21 @@ struct aspeed_sdc {
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
@@ -50,6 +71,25 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 	spin_unlock(&sdc->lock);
 }
 
+static void
+aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
+			   const struct aspeed_sdhci_phase_desc *phase,
+			   uint8_t value, bool enable)
+{
+	u32 reg;
+
+	spin_lock(&sdc->lock);
+	reg = readl(sdc->regs + ASPEED_SDC_PHASE);
+	reg &= ~phase->enable_mask;
+	if (enable) {
+		reg &= ~phase->value_mask;
+		reg |= value << __ffs(phase->value_mask);
+		reg |= phase->enable_value << __ffs(phase->enable_mask);
+	}
+	writel(reg, sdc->regs + ASPEED_SDC_PHASE);
+	spin_unlock(&sdc->lock);
+}
+
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_sdhci_configure_of(struct platform_device *pdev,
+				     struct aspeed_sdhci *sdhci)
+{
+	u32 iphase, ophase;
+	struct device_node *np;
+	struct device *dev;
+	int ret;
+
+	if (!sdhci->phase)
+		return 0;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
+	if (ret < 0) {
+		aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
+					   false);
+		dev_dbg(dev, "Input phase configuration disabled");
+	} else if (iphase >= (1 << 5)) {
+		dev_err(dev,
+			"Input phase value exceeds field range (5 bits): %u",
+			iphase);
+		return -ERANGE;
+	} else {
+		aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in,
+					   iphase, true);
+		dev_info(dev, "Input phase relationship: %u", iphase);
+	}
+
+	ret = of_property_read_u32(np, "aspeed,output-phase", &ophase);
+	if (ret < 0) {
+		aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out, 0,
+					   false);
+		dev_dbg(dev, "Output phase configuration disabled");
+	} else if (ophase >= (1 << 5)) {
+		dev_err(dev,
+			"Output phase value exceeds field range (5 bits): %u",
+			iphase);
+		return -ERANGE;
+	} else {
+		aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out,
+					   ophase, true);
+		dev_info(dev, "Output phase relationship: %u", ophase);
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
@@ -181,7 +271,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
-	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
+	dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
+	phase = of_device_get_match_data(&pdev->dev);
+	if (phase)
+		dev->phase = &phase[slot];
 
 	sdhci_get_of_property(pdev);
 
@@ -195,6 +288,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	ret = aspeed_sdhci_configure_of(pdev, dev);
+	if (ret)
+		goto err_sdhci_add;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
@@ -230,10 +327,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
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

