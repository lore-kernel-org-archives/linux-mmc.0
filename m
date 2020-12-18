Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC99C2D0E4
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE323A79
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgLRDyx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:54:53 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50569 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgLRDyx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:54:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EC145C00F7;
        Thu, 17 Dec 2020 22:54:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=724ecEhRDXWgZ
        Zicro86oSLISUtE1mGbQqChDaE7fZo=; b=gT1zKlWZJ59VVo3ZH2+P+VaPrBxt7
        6DpWjriPJInpk9n6lzLmZsH1vk2AcuR50Uu2kX36gshlakBnaggaU2sNyV/h/pCY
        LO8f53BTMRTRopyjWqC6lqTS7pdPt6th4L7pdHWuARVxK+eFhmYD4PQ1zk6rdgWp
        fvKOL0smPajBvHYQaJhDsElL6PgGSP4k6X8JeDvEj0C18Z3ch0R8YgT4DuqLr+Iz
        x7zxciaFSC/IclRAtKLUtK+20zAREmvFonRhNgLmIiF6FWB+Dczf3HWwxq/wpOB8
        mF2qLPiJRjyPAjm55fMQAbHx2PlqR0wDQARWpltYhFRpo4iNZ3d9YXCjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=724ecEhRDXWgZZicro86oSLISUtE1mGbQqChDaE7fZo=; b=az2WPMsu
        EhEL+R+IjaasLlAdSFBtN1NDTzOo1fx2ihnbKQyv07jhfIXsutZLKNKfaFLS9mKw
        +r/LQJWpKeL0RL7qODDFYRcWlSIerFvQ3bAWW/LIQ/KFTmeANVNHkai7cbMuZJgt
        63R9ZT+wAYL8tzGmVDGRR4KFyKlV0/k8Ue4pc3iTpSiNn7nZHAI7Pai1Y7v7p+39
        eoIhdyrD89BRIfdyTQQgOFY3INbSAru+HuTyFFlL/ZjsvqZDbJaqvfVfS24qRlO0
        FuPCdwGd7Hiqd1pUQw5x15MGA/nlh0V/K4I5DiZK/VkmF41ST3agB965dBUrwApc
        eOZrHXe1VNW2yg==
X-ME-Sender: <xms:3ifcX4LNGWW-JKvy2wd0BHNTm1SBedP1-QHelcH3G3gtbZD2LML2dg>
    <xme:3ifcX0AfXGHSWR3Fq6RCF0pjYGG8RaB_L8gZej_-KtkCOxtkBMwxz0PtICzcGVRsA
    o5xkIcl2mn8ERlJug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppeduvddtrddvtddrjeejrddvuddu
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:3ifcX1vpF1fk4UlpkSJ4LCy4HFArNC9_qTJU2S9n-7u5MBwj66j-XQ>
    <xmx:3ifcX6SI61c5N9HrWMBI3qJxiQULm5GikBtgD4jWyENyIorNImpImg>
    <xmx:3ifcX0K_jQMVEdpzSp6rsu-tfWHsk3Ssn7aCJkrOHqqdGiaYunWzHQ>
    <xmx:3ifcX_ONaaJ6fNoVJ2N-quFjvhIEd-qIIzi27Jdg4Vhq-mYKuAMJow>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14E08108005F;
        Thu, 17 Dec 2020 22:54:00 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 2/6] mmc: sdhci-of-aspeed: Expose clock phase controls
Date:   Fri, 18 Dec 2020 14:23:34 +1030
Message-Id: <20201218035338.1130849-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
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
index 4f008ba3280e..b1a14e7dda82 100644
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
+	struct mmc_clk_phase_map phase_map;
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
+	params = &sdhci->phase_map.phase[host->timing];
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
+		mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
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

