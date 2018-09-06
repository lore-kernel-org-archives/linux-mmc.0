From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] mmc: sunxi: Clarify new timing mode usage and implementation
Date: Thu,  6 Sep 2018 23:31:07 +0800
Message-ID: <20180906153107.20225-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Newer sunxi mmc controller variants support what they call the "new
timing mode". Support for this was implemented in two ways, according
to the hardware that was seen at the time.

The first type retained the old timing mode, and both the clock and mmc
controllers had switches to select which mode was used. Both switches
had to be set to the same setting. This variant was denoted with the
.has_timings_switch field in the sunxi_mmc_cfg structure. This hardware
is only seen on the A83T.

The second type did away with the old timing mode. The clock controller
no longer had the mode selection or clock delay setting bits. In some
cases the mmc controller retained its mode selection bit, but this
always needed to be set to the new mode, or instabilities would occur.
In a few cases, such as the A64 and H6 eMMC controller, the mode
selection bit is gone, but the controller still behaves like the new
timing mode, requiring the module clock to be double the card clock
in DDR transfer modes. This variant is denoted with the
.needs_new_timings field.

This patch adds more comments explaining the two fields, as well as
the possibly nonexistent mode switch in the mmc controller.

The .has_timings_switch is renamed to .ccu_has_timings_switch to clarify
its meaning.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 568349e1fbc2..5f8d3ea0a0f8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -258,11 +258,16 @@ struct sunxi_mmc_cfg {
 	/* Does DATA0 needs to be masked while the clock is updated */
 	bool mask_data0;
 
-	/* hardware only supports new timing mode */
+	/*
+	 * hardware only supports new timing mode, either due to lack of
+	 * a mode switch in the clock controller, or the mmc controller
+	 * is permanently configured in the new timing mode, without the
+	 * NTSR mode switch.
+	 */
 	bool needs_new_timings;
 
-	/* hardware can switch between old and new timing modes */
-	bool has_timings_switch;
+	/* clock hardware can switch between old and new timing modes */
+	bool ccu_has_timings_switch;
 };
 
 struct sunxi_mmc_host {
@@ -787,7 +792,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		clock <<= 1;
 	}
 
-	if (host->use_new_timings && host->cfg->has_timings_switch) {
+	if (host->use_new_timings && host->cfg->ccu_has_timings_switch) {
 		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
 		if (ret) {
 			dev_err(mmc_dev(mmc),
@@ -822,6 +827,12 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	/* update card clock rate to account for internal divider */
 	rate /= div;
 
+	/*
+	 * Configure the controller to use the new timing mode if needed.
+	 * On controllers that only support the new timing mode, such as
+	 * the eMMC controller on the A64, this register does not exist,
+	 * and any writes to it are ignored.
+	 */
 	if (host->use_new_timings) {
 		/* Don't touch the delay bits */
 		rval = mmc_readl(host, REG_SD_NTSR);
@@ -1145,7 +1156,7 @@ static const struct sunxi_mmc_cfg sun8i_a83t_emmc_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = sunxi_mmc_clk_delays,
 	.can_calibrate = false,
-	.has_timings_switch = true,
+	.ccu_has_timings_switch = true,
 };
 
 static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
@@ -1351,7 +1362,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		goto error_free_host;
 	}
 
-	if (host->cfg->has_timings_switch) {
+	if (host->cfg->ccu_has_timings_switch) {
 		/*
 		 * Supports both old and new timing modes.
 		 * Try setting the clk to new timing mode.
-- 
2.19.0.rc1
