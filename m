Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5BEC6379D
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C2C20756
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="lLCiRLFk";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESkz/puM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKWGan (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:30:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38043 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKWGan (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 01:30:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D0015C00E1;
        Mon, 23 Nov 2020 01:30:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Nov 2020 01:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ASX+pLTEANHTe
        F4tH6LDgjnOF8KYtpqCcmEbnKid1SY=; b=lLCiRLFk3S0/tg5QVJctEeqUDBKSA
        JgGrI7zs/PWmPON7yla2JQOuioMCwU7wEiJcfctgrac5BFVgYwRmrBPhh81eo2J9
        XOPQYdwHWBRcyUXrG7rzPUt4IWzlGdgJqnJhyUElzo6QFA7eO3DA/muSY25HD+GA
        MHD7owS6h7D02eIPaL1Vzg7p0ITKc7/2aXLvtV3lnKoNWJpK1c5sC8C9hYm1/QzJ
        e5zax0Nrves0L2+g1clzpVJTYlV0B3saqpadt0RVEJt+Ayy9StcPDvlx8Ni8sSM9
        yV+I7UAPRvaS66zOmVzgGY6GP/5HoSapuviXNVtbbSGYGzfISTnJidmoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ASX+pLTEANHTeF4tH6LDgjnOF8KYtpqCcmEbnKid1SY=; b=ESkz/puM
        CA11/hqs8fubdErByh3JRxREXDLW2TzUrvM63+fygrIFDmoFQOHfFwyYCTzrMutD
        imi+a/CvGvNRJymrprWdl5ghreul1RnCg8PZ2LEthiJwCD9lpijiWP3e8NDuUz2D
        P5zUOcth7KcgYPlFX+LJGLpsQrWLZrGnMbzt+3xQR5evVo/xzf18DST47Umk9BiF
        oK22vy23yuh3fSCdnE8bIRJTqnV/gw4A14Xe3XEo+Wj15TiXbm2Nxkz3rFtqWrU/
        q0TkSBt3RZEbVx3WpDs/sC2aXBtUIb94pd7dm9Uu1K8x/nqeazdea2nhciUv4rZj
        pJroJ2uI+X3r6A==
X-ME-Sender: <xms:EVe7XzqNpPjq2DjLEvA7etK3BtGdSz2UpPWeaf0ldtqPe-XbakHYPw>
    <xme:EVe7X9pZYHqWdqVIZpetumJZZ_S8G_w4G6sDUbe-3FtzHD_jWHkqy52cI_j92qAyW
    NIZPrN_OTp8jbafDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeghedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:EVe7XwN2GIS-UphsCVsYyIeRRLis2TLte4qrm3g8cu2vAtrnDEX9ew>
    <xmx:EVe7X25dGOIiZ30lTUpqiQRbFfWl3HWfvj71qchq8xdO5tZCYrVOCg>
    <xmx:EVe7Xy5g_Oko10u1WOu0h-QBiNXQ7VYor57YY_3H1kzcogHbcEYImA>
    <xmx:EVe7X5YOXDwvf6ysJF1RvcpKpfNSssLW5rSpWcCLPmIpw_V6SV3jug>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 028563064AA6;
        Mon, 23 Nov 2020 01:30:36 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     robh+dt@kernel.org, joel@jms.id.au, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: [PATCH v3 1/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Mon, 23 Nov 2020 17:00:02 +1030
Message-Id: <20201123063004.337345-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123063004.337345-1-andrew@aj.id.au>
References: <20201123063004.337345-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/mmc/host/sdhci-of-aspeed.c | 275 ++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4f008ba3280e..9fda2e7c1d78 100644
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
@@ -28,9 +39,42 @@ struct aspeed_sdc {
 	void __iomem *regs;
 };
 
+struct aspeed_sdhci_tap_param {
+	bool set;
+
+#define ASPEED_SDHCI_TAP_PARAM_INVERT_CLK	BIT(4)
+	u8 in;
+	u8 out;
+};
+
+struct aspeed_sdhci_phase_tap_desc {
+	u32 tap_mask;
+	u32 enable_mask;
+	u8 enable_value;
+};
+
+struct aspeed_sdhci_phase_desc {
+	struct aspeed_sdhci_phase_tap_desc in;
+	struct aspeed_sdhci_phase_tap_desc out;
+};
+
+struct aspeed_sdhci_phase_param {
+	bool set;
+	u8 in_deg;
+	u8 out_deg;
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
+	const struct aspeed_sdhci_phase_desc *phase_desc;
+	struct aspeed_sdhci_phase_param phase_param[MMC_TIMING_MMC_HS200 + 1];
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -50,10 +94,119 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 	spin_unlock(&sdc->lock);
 }
 
+static u32
+aspeed_sdc_set_phase_tap(const struct aspeed_sdhci_phase_tap_desc *desc,
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
+	reg = aspeed_sdc_set_phase_tap(&desc->in, taps->in, taps->set, reg);
+	reg = aspeed_sdc_set_phase_tap(&desc->out, taps->out, taps->set, reg);
+
+	writel(reg, sdc->regs + ASPEED_SDC_PHASE);
+	spin_unlock(&sdc->lock);
+}
+
+#define PICOSECONDS_PER_SECOND		1000000000000ULL
+#define ASPEED_SDHCI_NR_TAPS		15
+/* Measured value with *handwave* environmentals and static loading */
+#define ASPEED_SDHCI_MAX_TAP_DELAY_PS	1253
+static int aspeed_sdhci_phase_to_tap(struct sdhci_host *host,
+				     unsigned long rate_hz, int phase_deg)
+{
+	u64 phase_period_ps;
+	struct device *dev;
+	u64 prop_delay_ps;
+	u64 clk_period_ps;
+	unsigned int taps;
+	u8 inverted;
+
+	dev = host->mmc->parent;
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
+	taps = div_u64(phase_period_ps, prop_delay_ps);
+	if (taps > ASPEED_SDHCI_NR_TAPS) {
+		dev_warn(dev,
+			 "Requested out of range phase tap %d for %d degrees of phase compensation at %luHz, clamping to tap %d\n",
+			 taps, phase_deg, rate_hz, ASPEED_SDHCI_NR_TAPS);
+		taps = ASPEED_SDHCI_NR_TAPS;
+	}
+
+	return inverted | taps;
+}
+
+static void
+aspeed_sdhci_phases_to_taps(struct sdhci_host *host, unsigned long rate,
+			    const struct aspeed_sdhci_phase_param *phases,
+			    struct aspeed_sdhci_tap_param *taps)
+{
+	taps->set = phases->set;
+
+	if (!phases->set)
+		return;
+
+	taps->in = aspeed_sdhci_phase_to_tap(host, rate, phases->in_deg);
+	taps->out = aspeed_sdhci_phase_to_tap(host, rate, phases->out_deg);
+}
+
+static void
+aspeed_sdhci_configure_phase(struct sdhci_host *host, unsigned long rate)
+{
+	struct aspeed_sdhci_tap_param _taps = {0}, *taps = &_taps;
+	struct aspeed_sdhci_phase_param *phases;
+	struct aspeed_sdhci *sdhci;
+
+	sdhci = sdhci_pltfm_priv(sdhci_priv(host));
+
+	if (!sdhci->phase_desc)
+		return;
+
+	phases = &sdhci->phase_param[host->timing];
+	aspeed_sdhci_phases_to_taps(host, rate, phases, taps);
+	aspeed_sdc_set_phase_taps(sdhci->parent, sdhci->phase_desc, taps);
+	dev_dbg(host->mmc->parent,
+		"Using taps [%d, %d] for [%d, %d] degrees of phase correction at %luHz (%d)\n",
+		taps->in & ASPEED_SDHCI_NR_TAPS,
+		taps->out & ASPEED_SDHCI_NR_TAPS,
+		phases->in_deg, phases->out_deg, rate, host->timing);
+}
+
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
-	unsigned long parent;
+	unsigned long parent, bus;
 	int div;
 	u16 clk;
 
@@ -69,13 +222,17 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
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
 
@@ -155,8 +312,60 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static void
+aspeed_sdhci_of_parse_phase(struct device_node *np, const char *prop,
+			    struct aspeed_sdhci_phase_param *phase)
+{
+	int degrees[2] = {0};
+	int rc;
+
+	rc = of_property_read_variable_u32_array(np, prop, degrees, 2, 0);
+	phase->set = rc == 2;
+	if (phase->set) {
+		phase->in_deg = degrees[0];
+		phase->out_deg = degrees[1];
+	}
+}
+
+static int aspeed_sdhci_of_parse(struct platform_device *pdev,
+				 struct aspeed_sdhci *sdhci)
+{
+	struct device_node *np;
+	struct device *dev;
+
+	if (!sdhci->phase_desc)
+		return 0;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-legacy",
+				    &sdhci->phase_param[MMC_TIMING_LEGACY]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs",
+				    &sdhci->phase_param[MMC_TIMING_MMC_HS]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-sd-hs",
+				    &sdhci->phase_param[MMC_TIMING_SD_HS]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr12",
+				    &sdhci->phase_param[MMC_TIMING_UHS_SDR12]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr25",
+				    &sdhci->phase_param[MMC_TIMING_UHS_SDR25]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr50",
+				    &sdhci->phase_param[MMC_TIMING_UHS_SDR50]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr104",
+				    &sdhci->phase_param[MMC_TIMING_UHS_SDR104]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-ddr50",
+				    &sdhci->phase_param[MMC_TIMING_UHS_DDR50]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-ddr52",
+				    &sdhci->phase_param[MMC_TIMING_MMC_DDR52]);
+	aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs200",
+				    &sdhci->phase_param[MMC_TIMING_MMC_HS200]);
+
+	return 0;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
+	const struct aspeed_sdhci_pdata *aspeed_pdata;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
@@ -164,12 +373,15 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
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
@@ -180,8 +392,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
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
 
@@ -195,6 +416,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	ret = aspeed_sdhci_of_parse(pdev, dev);
+	if (ret)
+		goto err_sdhci_add;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
@@ -230,10 +455,44 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
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

