From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/5] drivers: mmc: sunxi: fix A64 calibration routine
Date: Mon,  2 Jan 2017 23:03:42 +0000
Message-ID: <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBYVYVPBQKGQEEDQHJIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1483398226-29321-1-git-send-email-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The calibration facility in the A64 MMC block seems to have been
misunderstood: the result value is not the value to program into the
delay bits, but is the number of delay cells that result in a full clock
cycle delay. So this value has to be scaled by the desired phase, which
we still have to know and program.
Change the calibration routine to take a phase parameter and scale the
calibration value accordingly.
Also introduce sun50i-a64 delay parameters to store the required phase.
Looking at the BSP kernel the sample delay for anything below HS200 is
0, so we go with that value.
Once the driver supports HS200 and faster modes, we can enter confirmed
working values in there.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b1d1303..1e156e8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -681,15 +681,13 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	return 0;
 }
 
-static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
+static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off,
+			       int degrees)
 {
 	u32 reg = readl(host->reg_base + reg_off);
 	u32 delay;
 	unsigned long timeout;
 
-	if (!host->cfg->can_calibrate)
-		return 0;
-
 	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
 	reg &= ~SDXC_CAL_DL_SW_EN;
 
@@ -711,6 +709,7 @@ static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
 	}
 
 	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
+	delay = degrees * delay / 360;
 
 	reg &= ~SDXC_CAL_START;
 	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
@@ -748,6 +747,11 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 		return -EINVAL;
 	}
 
+	if (host->cfg->can_calibrate)
+		return sunxi_mmc_calibrate(host, SDXC_REG_SAMP_DL_REG,
+					   host->cfg->clk_delays[index].sample);
+	/* TODO: calibrate data strobe delay once HS-400 is supported. */
+
 	clk_set_phase(host->clk_sample, host->cfg->clk_delays[index].sample);
 	clk_set_phase(host->clk_output, host->cfg->clk_delays[index].output);
 
@@ -802,12 +806,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
-	ret = sunxi_mmc_calibrate(host, SDXC_REG_SAMP_DL_REG);
-	if (ret)
-		return ret;
-
-	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
-
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
 
@@ -1061,6 +1059,14 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  72, .sample =  72 },
 };
 
+static const struct sunxi_mmc_clk_delay sun50i_mmc_clk_delays[] = {
+	[SDXC_CLK_400K]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_25M]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M_DDR]	= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output = 90, .sample = 0 },
+};
+
 static const struct sunxi_mmc_cfg sun4i_a10_cfg = {
 	.idma_des_size_bits = 13,
 	.clk_delays = NULL,
@@ -1087,7 +1093,7 @@ static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 
 static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
-	.clk_delays = NULL,
+	.clk_delays = sun50i_mmc_clk_delays,
 	.can_calibrate = true,
 };
 
@@ -1134,7 +1140,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return PTR_ERR(host->clk_mmc);
 	}
 
-	if (host->cfg->clk_delays) {
+	if (host->cfg->clk_delays && !host->cfg->can_calibrate) {
 		host->clk_output = devm_clk_get(&pdev->dev, "output");
 		if (IS_ERR(host->clk_output)) {
 			dev_err(&pdev->dev, "Could not get output clock\n");
-- 
2.8.2
