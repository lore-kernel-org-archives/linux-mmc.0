From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 5/13] mmc: sunxi: Mask DATA0 when updating the clock
Date: Mon, 16 Jan 2017 17:56:55 +0100
Message-ID: <c36c2e2289ff3268d4a57b265f23725d882a23ed.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

The A64 MMC controllers need DATA0 to be masked while updating the clock,
otherwise any subsequent command will result in a timeout.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 51d6388a194e..6bbe61397b7c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -101,6 +101,7 @@
 	(SDXC_SOFT_RESET | SDXC_FIFO_RESET | SDXC_DMA_RESET)
 
 /* clock control bits */
+#define SDXC_MASK_DATA0			BIT(31)
 #define SDXC_CARD_CLOCK_ON		BIT(16)
 #define SDXC_LOW_POWER_ON		BIT(17)
 
@@ -254,6 +255,9 @@ struct sunxi_mmc_cfg {
 	/* does the IP block support autocalibration? */
 	bool can_calibrate;
 
+	/* Does DATA0 needs to be masked while the clock is updated */
+	bool mask_data0;
+
 	bool needs_new_timings;
 };
 
@@ -657,10 +661,12 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	u32 rval;
 
 	rval = mmc_readl(host, REG_CLKCR);
-	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
+	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON | SDXC_MASK_DATA0);
 
 	if (oclk_en)
 		rval |= SDXC_CARD_CLOCK_ON;
+	if (host->cfg->mask_data0)
+		rval |= SDXC_MASK_DATA0;
 
 	mmc_writel(host, REG_CLKCR, rval);
 
@@ -680,6 +686,11 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 		return -EIO;
 	}
 
+	if (host->cfg->mask_data0) {
+		rval = mmc_readl(host, REG_CLKCR);
+		mmc_writel(host, REG_CLKCR, rval & ~SDXC_MASK_DATA0);
+	}
+
 	return 0;
 }
 
@@ -1081,6 +1092,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.mask_data0 = true,
 	.needs_new_timings = true,
 };
 
-- 
git-series 0.8.11
