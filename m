From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v4 5/13] mmc: sunxi: Mask DATA0 when updating the clock
Date: Thu, 26 Jan 2017 10:05:58 +0100
Message-ID: <bbba06b3db0c50e6d90a96a2e8b7faf1c545ea77.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

The A64 MMC controllers need DATA0 to be masked while updating the clock,
otherwise any subsequent command will result in a timeout.

It's not really clear at this point what DATA0 is exactly, but this
behaviour is present in Allwinner's tree, and has been suggested by
Allwinner engineers as fixes for the timeout.

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
