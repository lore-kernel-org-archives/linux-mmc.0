From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v4 4/13] mmc: sunxi: Enable the new timings for the A64 MMC controllers
Date: Thu, 26 Jan 2017 10:05:57 +0100
Message-ID: <d6dfbf595cb99709877e7e57595125ce0b783ff6.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

The A64 MMC controllers need to set a "new timings" bit when a new rate is
set.

The actual meaning of that bit is not clear yet, but not setting it leads
to some corner-case issues, like the CMD53 failing, which is used to
implement SDIO packet aggregation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++++++
 1 file changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b9c8a62bc212..51d6388a194e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -253,6 +253,8 @@ struct sunxi_mmc_cfg {
 
 	/* does the IP block support autocalibration? */
 	bool can_calibrate;
+
+	bool needs_new_timings;
 };
 
 struct sunxi_mmc_host {
@@ -779,6 +781,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
+	if (host->cfg->needs_new_timings)
+		mmc_writel(host, REG_SD_NTSR, SDXC_2X_TIMING_MODE);
+
 	ret = sunxi_mmc_clk_set_phase(host, ios, rate);
 	if (ret)
 		return ret;
@@ -1076,6 +1081,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.needs_new_timings = true,
 };
 
 static const struct of_device_id sunxi_mmc_of_match[] = {
-- 
git-series 0.8.11
