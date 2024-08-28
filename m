Received: from a7-39.smtp-out.eu-west-1.amazonses.com (a7-39.smtp-out.eu-west-1.amazonses.com [54.240.7.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459D1A2C0A;
	Wed, 28 Aug 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858698; cv=none; b=fjBimEvNtiAGwsO7vPGe+OpVpFFZ6ZH9WTq5IeSA49jL1UdwwI1EvMlLrSDe4G0kd7Gf811n8XtR4WKoyIGHP1gCEXnV9zYu7S/CPkzvvVKnSBOCrczi3WqHA95rAmgs4uLmGkyjIAuz7CXUqU1I0VO1X0FV7WxZsL7fC+YnIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858698; c=relaxed/simple;
	bh=VBKcoWyT8YYWnPjrQu1LBgSPTrF1fo1M2c2Lycm5hfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcVApqCYpFL6E0M8CINb9bFRNKPfmp7K7zMXkaQIxWOdcRv+UDtLbzVF7A1Wk2sc1D9uWvbMLCYClricznawOx1AxDHcQQOvnEU2RMyQV2MRH7XDpQAY0epXkEUV8AJ/0Fi9Aeml8gVseZrC2nr5kepaWNy5B8/PMR29ifjTTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ih88V/tv; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=H5tOJfjJ; arc=none smtp.client-ip=54.240.7.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ih88V/tv";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="H5tOJfjJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724858695;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VBKcoWyT8YYWnPjrQu1LBgSPTrF1fo1M2c2Lycm5hfU=;
	b=ih88V/tvc0GDy1Dc6T5hnThywlcv4TX4uoYGWaUMrKfPkZFWRTJe4XTFrb95q0mu
	vzyAlosvlGk2snsfumXiCpBSdrYobUHf7YvJZ3BW5PKHqQsKY/PEknerSsKXV0er84n
	1CUQbfSAlQnKf0BEIcR0p6eUj/z7EPtjyKM7CeHCSkfzOQljH2tIavvWgsBepfEijhP
	11/jFcuAw0y8n+WThZz/HUXf5SjOjLGz9Sbe0PBLcFv6LC/cv2cZs+yoSvH2Ok9vpph
	fOKYekToSSaXApXHNlqIUPYN+aLP83aIZgS5xHqP/GoznJLXCsUanQlGTWJ1PhwaZqH
	udrVatBIEg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724858695;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=VBKcoWyT8YYWnPjrQu1LBgSPTrF1fo1M2c2Lycm5hfU=;
	b=H5tOJfjJ2ukRXNR9tNtlaYKDmZqHb0WGT88dysZOfhxqi3AmmiQjf7Z167wC48gu
	YnDbosO5yDkUOTDOT33/z4nBDNVog39l2CBkSKhZxMdqGrvFiyxjuZvETmjhubYD/Sv
	yLhae4rx47UseAWOPG0vi27tcK5az6r477On9+FQ=
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 2/3] mmc: dw_mmc-rockchip: Add internal phase support
Date: Wed, 28 Aug 2024 15:24:55 +0000
Message-ID: <010201919996fdae-8a9f843e-00a8-4131-98bf-a9da4ed04bfd-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828152446.42896-1-detlev.casanova@collabora.com>
References: <20240828152446.42896-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.39

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
index b07190ba4b7a..75e9ac4bcd08 100644
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
+	bool			internal_phase;
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

