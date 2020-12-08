Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F6C4361B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5484623A50
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLHB1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:27:22 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45585 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgLHB1W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 20:27:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A57105C0216;
        Mon,  7 Dec 2020 20:26:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 20:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LBXQ1AXGfTSFg
        jE0H/tOMPvUmGXy9/AxdexCKUUzZ4E=; b=eMOp6SSgVJAANMmXwdjyKxHZZGWOQ
        d0sWRG0U0gSrBBmQxkw15STZMHimOu54xMcrGm0Cmpvmt+g4VnAC60d6hNGSm1We
        8dW/7kOuXOVlhcppNmabuFGTJF1Soq/5bEpJWa8ylnfp+qIyxJoq4kZbrSNOzRNa
        tuk03W6o2RV2/hlraJDYlI1vJGHIpc4l/QTkkcwM8C3m4bY9AJ+M90Wgj4+TaFXO
        mVSwLE8kNdwj1lmwwtmhDdbyyBLqvmbQT2Wm8ZanfSIhW5f0VfrbEQlflMDBXDTn
        wfrWIGT7cuaVPcFtcJHDHrLQI8KOAAWrIPcj81d0EfXKorHR7xqpSzeEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LBXQ1AXGfTSFgjE0H/tOMPvUmGXy9/AxdexCKUUzZ4E=; b=eXI3+/kJ
        tJun9sLAZJU4FHlQZIFIgZj6ukTOe9/KxsFAYELCACk4AYvLhedhGS36EAU+hvSI
        8z+R8aV2AG3sLrefp0FXc7Vva8zVTU62zU8067uympSzGZMlG2Ff1O5rdwn94TR/
        T7VUWSX+66JCpexVO2C8p/68UFC7HE7u3EMEW3IzclkM3i7cpAlGe1BjV5GE/A3j
        jAJBAdunE5zXS488jCi5kjdC1SxBVcxZO0sApKWR8ong/+IN9y3hOga4NV5QQPjf
        RlzrzkRJ4RnT4Qy7ppB+VKYUS+Sk4sbhspjT3XbXSC6KjD4/gCaGPT2Zb/vkMFwZ
        Xx3/0JQr3gWfwA==
X-ME-Sender: <xms:S9bOX4lSYsZHuFA49MqUtvKj3NqOpbi9Brw5CBT6kM4g3OoMEdeluQ>
    <xme:S9bOX31WRvq-jxuaVcg4oobbCa-73l8s_Xgy67TxK_hu4nG14u23iwIcdpCwUgfUS
    GcDWPAlixIqEwpqiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:S9bOX2p5Q9rBDoSAW3_SHSU9-LH-FdQPXjlNHs0eKFNj_GE-h_-6XA>
    <xmx:S9bOX0laa6xucSa5IStj5QQ7jwqy87_pMg6JfWfCvzxaCGZMVRjJVA>
    <xmx:S9bOX23LYqL4BAuhwN3yQ__7OZCsUheMXGDnGC--U75iKxvXfVmVNA>
    <xmx:S9bOX_l5lhscEsuM8fIAJO72zW9gIQdNS0n_vhXuoqc4cWnvb_AymA>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B7441080057;
        Mon,  7 Dec 2020 20:26:31 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v5 2/6] mmc: sdhci-of-aspeed: Expose clock phase controls
Date:   Tue,  8 Dec 2020 11:56:11 +1030
Message-Id: <20201208012615.2717412-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Aspeed SD/eMMC controllers expose configurable clock phase
correction by inserting delays of up to 15 logic elements in length into
the bus clock path. The hardware supports independent configuration for
both bus directions on a per-slot basis.

The timing delay per element encoded in the driver was experimentally
determined by scope measurements.

The phase controls for both slots are grouped together in a single
register of the global register block of the SD/MMC controller(s), which
drives the use of a locking scheme between the SDHCIs and the global
register set.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 216 +++++++++++++++++++++++++++--
 1 file changed, 208 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4f008ba3280e..788ec7728227 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/math64.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -16,9 +17,19 @@
 
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
@@ -28,9 +39,36 @@ struct aspeed_sdc {
 	void __iomem *regs;
 };
 
+struct aspeed_sdhci_tap_param {
+	bool valid;
+
+#define ASPEED_SDHCI_TAP_PARAM_INVERT_CLK	BIT(4)
+	u8 in;
+	u8 out;
+};
+
+struct aspeed_sdhci_tap_desc {
+	u32 tap_mask;
+	u32 enable_mask;
+	u8 enable_value;
+};
+
+struct aspeed_sdhci_phase_desc {
+	struct aspeed_sdhci_tap_desc in;
+	struct aspeed_sdhci_tap_desc out;
+};
+
+struct aspeed_sdhci_pdata {
+	const struct aspeed_sdhci_phase_desc *phase_desc;
+	size_t nr_phase_descs;
+};
+
 struct aspeed_sdhci {
+	const struct aspeed_sdhci_pdata *pdata;
 	struct aspeed_sdc *parent;
 	u32 width_mask;
+	mmc_clk_phase_map_t phase_map;
+	const struct aspeed_sdhci_phase_desc *phase_desc;
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -50,10 +88,118 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 	spin_unlock(&sdc->lock);
 }
 
+static u32
+aspeed_sdc_set_phase_tap(const struct aspeed_sdhci_tap_desc *desc,
+			 u8 tap, bool enable, u32 reg)
+{
+	reg &= ~(desc->enable_mask | desc->tap_mask);
+	if (enable) {
+		reg |= tap << __ffs(desc->tap_mask);
+		reg |= desc->enable_value << __ffs(desc->enable_mask);
+	}
+
+	return reg;
+}
+
+static void
+aspeed_sdc_set_phase_taps(struct aspeed_sdc *sdc,
+			  const struct aspeed_sdhci_phase_desc *desc,
+			  const struct aspeed_sdhci_tap_param *taps)
+{
+	u32 reg;
+
+	spin_lock(&sdc->lock);
+	reg = readl(sdc->regs + ASPEED_SDC_PHASE);
+
+	reg = aspeed_sdc_set_phase_tap(&desc->in, taps->in, taps->valid, reg);
+	reg = aspeed_sdc_set_phase_tap(&desc->out, taps->out, taps->valid, reg);
+
+	writel(reg, sdc->regs + ASPEED_SDC_PHASE);
+	spin_unlock(&sdc->lock);
+}
+
+#define PICOSECONDS_PER_SECOND		1000000000000ULL
+#define ASPEED_SDHCI_NR_TAPS		15
+/* Measured value with *handwave* environmentals and static loading */
+#define ASPEED_SDHCI_MAX_TAP_DELAY_PS	1253
+static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
+				     int phase_deg)
+{
+	u64 phase_period_ps;
+	u64 prop_delay_ps;
+	u64 clk_period_ps;
+	unsigned int tap;
+	u8 inverted;
+
+	phase_deg %= 360;
+
+	if (phase_deg >= 180) {
+		inverted = ASPEED_SDHCI_TAP_PARAM_INVERT_CLK;
+		phase_deg -= 180;
+		dev_dbg(dev,
+			"Inverting clock to reduce phase correction from %d to %d degrees\n",
+			phase_deg + 180, phase_deg);
+	} else {
+		inverted = 0;
+	}
+
+	prop_delay_ps = ASPEED_SDHCI_MAX_TAP_DELAY_PS / ASPEED_SDHCI_NR_TAPS;
+	clk_period_ps = div_u64(PICOSECONDS_PER_SECOND, (u64)rate_hz);
+	phase_period_ps = div_u64((u64)phase_deg * clk_period_ps, 360ULL);
+
+	tap = div_u64(phase_period_ps, prop_delay_ps);
+	if (tap > ASPEED_SDHCI_NR_TAPS) {
+		dev_warn(dev,
+			 "Requested out of range phase tap %d for %d degrees of phase compensation at %luHz, clamping to tap %d\n",
+			 tap, phase_deg, rate_hz, ASPEED_SDHCI_NR_TAPS);
+		tap = ASPEED_SDHCI_NR_TAPS;
+	}
+
+	return inverted | tap;
+}
+
+static void
+aspeed_sdhci_phases_to_taps(struct device *dev, unsigned long rate,
+			    const struct mmc_clk_phase *phases,
+			    struct aspeed_sdhci_tap_param *taps)
+{
+	taps->valid = phases->valid;
+
+	if (!phases->valid)
+		return;
+
+	taps->in = aspeed_sdhci_phase_to_tap(dev, rate, phases->in_deg);
+	taps->out = aspeed_sdhci_phase_to_tap(dev, rate, phases->out_deg);
+}
+
+static void
+aspeed_sdhci_configure_phase(struct sdhci_host *host, unsigned long rate)
+{
+	struct aspeed_sdhci_tap_param _taps = {0}, *taps = &_taps;
+	struct mmc_clk_phase *params;
+	struct aspeed_sdhci *sdhci;
+	struct device *dev;
+
+	dev = host->mmc->parent;
+	sdhci = sdhci_pltfm_priv(sdhci_priv(host));
+
+	if (!sdhci->phase_desc)
+		return;
+
+	params = &sdhci->phase_map[host->timing];
+	aspeed_sdhci_phases_to_taps(dev, rate, params, taps);
+	aspeed_sdc_set_phase_taps(sdhci->parent, sdhci->phase_desc, taps);
+	dev_dbg(dev,
+		"Using taps [%d, %d] for [%d, %d] degrees of phase correction at %luHz (%d)\n",
+		taps->in & ASPEED_SDHCI_NR_TAPS,
+		taps->out & ASPEED_SDHCI_NR_TAPS,
+		params->in_deg, params->out_deg, rate, host->timing);
+}
+
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
-	unsigned long parent;
+	unsigned long parent, bus;
 	int div;
 	u16 clk;
 
@@ -69,13 +215,17 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		clock = host->max_clk;
 
 	for (div = 2; div < 256; div *= 2) {
-		if ((parent / div) <= clock)
+		bus = parent / div;
+		if (bus <= clock)
 			break;
 	}
+
 	div >>= 1;
 
 	clk = div << SDHCI_DIVIDER_SHIFT;
 
+	aspeed_sdhci_configure_phase(host, bus);
+
 	sdhci_enable_clk(host, clk);
 }
 
@@ -157,6 +307,7 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
+	const struct aspeed_sdhci_pdata *aspeed_pdata;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
@@ -164,12 +315,15 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	int slot;
 	int ret;
 
+	aspeed_pdata = of_device_get_match_data(&pdev->dev);
+
 	host = sdhci_pltfm_init(pdev, &aspeed_sdhci_pdata, sizeof(*dev));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
 	dev = sdhci_pltfm_priv(pltfm_host);
+	dev->pdata = aspeed_pdata;
 	dev->parent = dev_get_drvdata(pdev->dev.parent);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -180,8 +334,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	else if (slot >= 2)
 		return -EINVAL;
 
-	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
-	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
+	if (dev->pdata && slot < dev->pdata->nr_phase_descs) {
+		dev->phase_desc = &dev->pdata->phase_desc[slot];
+	} else {
+		dev_info(&pdev->dev,
+			 "Phase control not supported for slot %d\n", slot);
+		dev->phase_desc = NULL;
+	}
+
+	dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
+
+	dev_info(&pdev->dev, "Configured for slot %d\n", slot);
 
 	sdhci_get_of_property(pdev);
 
@@ -199,6 +362,9 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sdhci_add;
 
+	if (dev->phase_desc)
+		mmc_of_parse_clk_phase(host->mmc, dev->phase_map);
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_sdhci_add;
@@ -230,10 +396,44 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
+	/* SDHCI/Slot 0 */
+	[0] = {
+		.in = {
+			.tap_mask = ASPEED_SDC_S0_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.tap_mask = ASPEED_SDC_S0_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+	/* SDHCI/Slot 1 */
+	[1] = {
+		.in = {
+			.tap_mask = ASPEED_SDC_S1_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.tap_mask = ASPEED_SDC_S1_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+};
+
+static const struct aspeed_sdhci_pdata ast2600_sdhci_pdata = {
+	.phase_desc = ast2600_sdhci_phase,
+	.nr_phase_descs = ARRAY_SIZE(ast2600_sdhci_phase),
+};
+
 static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sdhci", },
 	{ .compatible = "aspeed,ast2500-sdhci", },
-	{ .compatible = "aspeed,ast2600-sdhci", },
+	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
 
-- 
2.27.0

