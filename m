Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7F1D278D;
	Thu, 22 Aug 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361898; cv=pass; b=bOTIP00Vg9RtWV906OPZSVaA/Bbg7XvwbQYhmOJjk79OBCyX3lR3ZuZm2yoEJEvXdO1b8l3TtgHPmtgv7QbLQ+hRGoV3aKxgQipvBEQQslr5jgtIVG6JVoCFDPX8SXJia6HgQQeAwElZdE6vcPmjCqyDK3KCbrbuGyD3FX8nfZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361898; c=relaxed/simple;
	bh=zVTT7hS1BFwNpLoYhke/D3D2hjaA6JZjMoe9Hw23Zog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT7Pln5nAdWrD3JEK/d1VxjFdWwMB1a2NQXW+7+X6Wm9LgAs5Cpeovn4iNyQRHBiBoifPexmOvhR9i/Dzb4ZTPGNRqdF1U575EtSkaDDQ8AOCMamX8swiCMK7yR+YlYnlRmITe1iKE1ntEN5fFu+SUkZOwIzMqqFD8jyaH/h9+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=PGR0EcSK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="PGR0EcSK"
ARC-Seal: i=1; a=rsa-sha256; t=1724361876; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FbD1jRP2lvK7yuhkPZwBvZaI/g2PJkXBYBfW9RY9SjpUjiDSRE3pCyxG7KWe2LmDVddL2ITDIghb6aoG6idGppwuN3mpuHttco9Qpv1Rv7QyXpw9jObmHejB4Avj8O77XoVNiGf+hI07/k0f5Jzw1oWSOrmd+O4Icif/aJKIrVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724361876; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7YL5pWtXUp+PHdd3Kfu/uwF045nPBW8u8rSyR+5Ufm4=; 
	b=bakPksguc+oW/3RVSPrvxhP3N+ZFYjGJlX86Iub89DpShq33wDCDf2hBM0XL2vr1vYVjOQUTCRMWUZWGm6Xupu1bi7Ju8NuJSM9vyCQU/GGfK7w0jCDgzYMvxE2r9icF3MEZO935VIVOO+0Nt8Af0yvZupm1RNA+KSIjSYWajhM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724361876;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7YL5pWtXUp+PHdd3Kfu/uwF045nPBW8u8rSyR+5Ufm4=;
	b=PGR0EcSKha34QXovj2e5Hguizkwl9uGTugPOm+BwTmun8q+IjegLnqS6RDyF3GxC
	gV5PKutb3vM17D9Gf4ocNZhTR5toolbkHD16k1tpTs6hAqrYA+1pOdz8+bqnbzElzry
	nqvSSPWB28yVXTZ+G54vteH7rwWv8Rj9isYa4NIU=
Received: by mx.zohomail.com with SMTPS id 1724361876093426.5821241995659;
	Thu, 22 Aug 2024 14:24:36 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 2/4] mmc: dw_mmc-rockchip: Add internal phase support
Date: Thu, 22 Aug 2024 17:15:32 -0400
Message-ID: <20240822212418.982927-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822212418.982927-1-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Shawn Lin <shawn.lin@rock-chips.com>

Some Rockchip devices put the phase settings into the dw_mmc controller.

When the feature is present, the ciu-drive and ciu-sample clocks are
not used and the phase configuration is done directly through the mmc
controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 171 +++++++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index b07190ba4b7a..2748f9bf2691 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -15,7 +15,17 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define RK3288_CLKGEN_DIV	2
+#define RK3288_CLKGEN_DIV		2
+#define SDMMC_TIMING_CON0		0x130
+#define SDMMC_TIMING_CON1		0x134
+#define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
+#define ROCKCHIP_MMC_DEGREE_MASK	0x3
+#define ROCKCHIP_MMC_DEGREE_OFFSET	1
+#define ROCKCHIP_MMC_DELAYNUM_OFFSET	2
+#define ROCKCHIP_MMC_DELAYNUM_MASK	(0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
+#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC	60
+#define HIWORD_UPDATE(val, mask, shift) \
+		((val) << (shift) | (mask) << ((shift) + 16))
 
 static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
 
@@ -24,8 +34,143 @@ struct dw_mci_rockchip_priv_data {
 	struct clk		*sample_clk;
 	int			default_sample_phase;
 	int			num_phases;
+	int			internal_phase;
 };
 
+/*
+ * Each fine delay is between 44ps-77ps. Assume each fine delay is 60ps to
+ * simplify calculations. So 45degs could be anywhere between 33deg and 57.8deg.
+ */
+static int rockchip_mmc_get_internal_phase(struct dw_mci *host, bool sample)
+{
+	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u32 raw_value;
+	u16 degrees;
+	u32 delay_num = 0;
+
+	/* Constant signal, no measurable phase shift */
+	if (!rate)
+		return 0;
+
+	if (sample)
+		raw_value = mci_readl(host, TIMING_CON1);
+	else
+		raw_value = mci_readl(host, TIMING_CON0);
+
+	raw_value >>= ROCKCHIP_MMC_DEGREE_OFFSET;
+	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
+
+	if (raw_value & ROCKCHIP_MMC_DELAY_SEL) {
+		/* degrees/delaynum * 1000000 */
+		unsigned long factor = (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
+					36 * (rate / 10000);
+
+		delay_num = (raw_value & ROCKCHIP_MMC_DELAYNUM_MASK);
+		delay_num >>= ROCKCHIP_MMC_DELAYNUM_OFFSET;
+		degrees += DIV_ROUND_CLOSEST(delay_num * factor, 1000000);
+	}
+
+	return degrees % 360;
+}
+
+static int rockchip_mmc_get_phase(struct dw_mci *host, bool sample)
+{
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
+	struct clk *clock = sample ? priv->sample_clk : priv->drv_clk;
+
+	if (priv->internal_phase)
+		return rockchip_mmc_get_internal_phase(host, sample);
+	else
+		return clk_get_phase(clock);
+}
+
+static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sample, int degrees)
+{
+	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u8 nineties, remainder;
+	u8 delay_num;
+	u32 raw_value;
+	u32 delay;
+
+	/*
+	 * The below calculation is based on the output clock from
+	 * MMC host to the card, which expects the phase clock inherits
+	 * the clock rate from its parent, namely the output clock
+	 * provider of MMC host. However, things may go wrong if
+	 * (1) It is orphan.
+	 * (2) It is assigned to the wrong parent.
+	 *
+	 * This check help debug the case (1), which seems to be the
+	 * most likely problem we often face and which makes it difficult
+	 * for people to debug unstable mmc tuning results.
+	 */
+	if (!rate) {
+		dev_err(host->dev, "%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
+	nineties = degrees / 90;
+	remainder = (degrees % 90);
+
+	/*
+	 * Due to the inexact nature of the "fine" delay, we might
+	 * actually go non-monotonic.  We don't go _too_ monotonic
+	 * though, so we should be OK.  Here are options of how we may
+	 * work:
+	 *
+	 * Ideally we end up with:
+	 *   1.0, 2.0, ..., 69.0, 70.0, ...,  89.0, 90.0
+	 *
+	 * On one extreme (if delay is actually 44ps):
+	 *   .73, 1.5, ..., 50.6, 51.3, ...,  65.3, 90.0
+	 * The other (if delay is actually 77ps):
+	 *   1.3, 2.6, ..., 88.6. 89.8, ..., 114.0, 90
+	 *
+	 * It's possible we might make a delay that is up to 25
+	 * degrees off from what we think we're making.  That's OK
+	 * though because we should be REALLY far from any bad range.
+	 */
+
+	/*
+	 * Convert to delay; do a little extra work to make sure we
+	 * don't overflow 32-bit / 64-bit numbers.
+	 */
+	delay = 10000000; /* PSECS_PER_SEC / 10000 / 10 */
+	delay *= remainder;
+	delay = DIV_ROUND_CLOSEST(delay,
+			(rate / 1000) * 36 *
+				(ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10));
+
+	delay_num = (u8) min_t(u32, delay, 255);
+
+	raw_value = delay_num ? ROCKCHIP_MMC_DELAY_SEL : 0;
+	raw_value |= delay_num << ROCKCHIP_MMC_DELAYNUM_OFFSET;
+	raw_value |= nineties;
+
+	if (sample)
+		mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+	else
+		mci_writel(host, TIMING_CON0, HIWORD_UPDATE(raw_value, 0x07ff, 1));
+
+	dev_dbg(host->dev, "set %s_phase(%d) delay_nums=%u actual_degrees=%d\n",
+		sample ? "sample" : "drv", degrees, delay_num,
+		rockchip_mmc_get_phase(host, sample)
+	);
+
+	return 0;
+}
+
+static int rockchip_mmc_set_phase(struct dw_mci *host, bool sample, int degrees)
+{
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
+	struct clk *clock = sample ? priv->sample_clk : priv->drv_clk;
+
+	if (priv->internal_phase)
+		return rockchip_mmc_set_internal_phase(host, sample, degrees);
+	else
+		return clk_set_phase(clock, degrees);
+}
+
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
@@ -64,7 +209,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 	/* Make sure we use phases which we can enumerate with */
 	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
-		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+		rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
 
 	/*
 	 * Set the drive phase offset based on speed mode to achieve hold times.
@@ -127,7 +272,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			break;
 		}
 
-		clk_set_phase(priv->drv_clk, phase);
+		rockchip_mmc_set_phase(host, false, phase);
 	}
 }
 
@@ -151,6 +296,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	int longest_range_len = -1;
 	int longest_range = -1;
 	int middle_phase;
+	int phase;
 
 	if (IS_ERR(priv->sample_clk)) {
 		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
@@ -164,8 +310,10 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 
 	/* Try each phase and extract good ranges */
 	for (i = 0; i < priv->num_phases; ) {
-		clk_set_phase(priv->sample_clk,
-			      TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
+		rockchip_mmc_set_phase(host, true,
+				       TUNING_ITERATION_TO_PHASE(
+						i,
+						priv->num_phases));
 
 		v = !mmc_send_tuning(mmc, opcode, NULL);
 
@@ -211,7 +359,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	}
 
 	if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
-		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
+		rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
+
 		dev_info(host->dev, "All phases work, using default phase %d.",
 			 priv->default_sample_phase);
 		goto free;
@@ -248,12 +397,10 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 
 	middle_phase = ranges[longest_range].start + longest_range_len / 2;
 	middle_phase %= priv->num_phases;
-	dev_info(host->dev, "Successfully tuned phase to %d\n",
-		 TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases));
+	phase = TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases);
+	dev_info(host->dev, "Successfully tuned phase to %d\n", phase);
 
-	clk_set_phase(priv->sample_clk,
-		      TUNING_ITERATION_TO_PHASE(middle_phase,
-						priv->num_phases));
+	rockchip_mmc_set_phase(host, true, phase);
 
 free:
 	kfree(ranges);
@@ -287,6 +434,8 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 
 	host->priv = priv;
 
+	priv->internal_phase = false;
+
 	return 0;
 }
 
-- 
2.46.0

