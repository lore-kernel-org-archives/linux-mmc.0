From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH] (broken) implementation of A64 MMC delay calibration
Date: Tue, 16 Feb 2016 14:16:19 +0000
Message-ID: <1455632179-8102-1-git-send-email-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBQO6RS3AKGQE2RVEPGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

as people were asking for it, here is my first attempt on proper
Allwinner A64 MMC support.
Former Allwinner MMC implementations used a special MMC clock, where
two clocks could be phase-offset-ed to match the timing requirements.
Those clocks have vanished, instead the phase seems to be now created
internally in the MMC blob using some new registers. Also there is an
auto-calibration feature with should help us to get the right values.

This patch is a naive implementation by just looking at the manual.
Unfortunately it does not work: The first calibration loop seems to
work, but returns all 1's as the result, which sounds suspicious.
The second calibration loop hangs (which reminds me of adding a
timeout):
[ 4.187144] sunxi_mmc: starting sample delay calibration
[ 4.192306] calibrate 0x144: register reads as 0x2000
[ 4.201770] calibrate 0x144: tried 16 times, reg=0x7f00
[ 4.206976] sunxi-mmc: delay for register 0x144: 63
[ 4.211665] calibrate 0x144: writing: 0x7fbf
[ 4.216353] sunxi_mmc: starting data strobe delay calibration
[ 4.221865] calibrate 0x148: register reads as 0x2000
(hang)

I didn't have time (and courage) yet to take a closer look at the BSP
kernel, but it seems like they don't use this feature for some reason?

Also my knowledge of MMC is very limited, so I might be missing
something obvious. Do we need to setup this other register
(SMHC Drive Delay Control Register at 0x0140) as well or are the
default settings good enough?

I am posting this so that other people can have a look or use it as
a base for own experiments.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>

---
 drivers/mmc/host/sunxi-mmc.c | 103 +++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8372a41..0c81a4d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -71,6 +71,8 @@
 #define SDXC_REG_IDIE	(0x8C) /* SMC IDMAC Interrupt Enable Register */
 #define SDXC_REG_CHDA	(0x90)
 #define SDXC_REG_CBDA	(0x94)
+#define SDXC_REG_SAMP_DL_REG	0x144	/* SMC sample delay control */
+#define SDXC_REG_DS_DL_REG	0x148	/* SMC data strobe delay control */
 
 #define mmc_readl(host, reg) \
 	readl((host)->reg_base + SDXC_##reg)
@@ -217,6 +219,13 @@
 #define SDXC_CLK_50M_DDR	3
 #define SDXC_CLK_50M_DDR_8BIT	4
 
+#define SDXC_CAL_START		BIT(15)
+#define SDXC_CAL_DONE		BIT(14)
+#define SDXC_CAL_DL_SHIFT	8
+#define SDXC_CAL_DL_SW_EN	BIT(7)
+#define SDXC_CAL_DL_SW_SHIFT	0
+#define SDXC_CAL_DL_MASK	0x3f
+
 struct sunxi_mmc_clk_delay {
 	u32 output;
 	u32 sample;
@@ -261,6 +270,9 @@ struct sunxi_mmc_host {
 
 	/* vqmmc */
 	bool		vqmmc_enabled;
+
+	/* does the IP block support autocalibration? */
+	bool		can_calibrate;
 };
 
 static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
@@ -653,10 +665,62 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	return 0;
 }
 
+static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host,
+			       struct mmc_ios *ios, int reg_off)
+{
+	u32 reg = readl(host->reg_base + reg_off);
+	u32 delay;
+
+	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
+	reg &= ~SDXC_CAL_DL_SW_EN;
+
+	writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
+
+	while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE))
+		cpu_relax();
+
+	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
+
+	reg &= ~SDXC_CAL_START;
+	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
+
+	writel(reg, host->reg_base + reg_off);
+
+	return 0;
+}
+
+static int sunxi_mmc_determine_delays(struct sunxi_mmc_host *host,
+				      struct mmc_ios *ios, int rate)
+{
+	int index;
+
+	if (rate <= 400000) {
+		index = SDXC_CLK_400K;
+	} else if (rate <= 25000000) {
+		index = SDXC_CLK_25M;
+	} else if (rate <= 52000000) {
+		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
+		    ios->timing != MMC_TIMING_MMC_DDR52) {
+			index = SDXC_CLK_50M;
+		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			index = SDXC_CLK_50M_DDR_8BIT;
+		} else {
+			index = SDXC_CLK_50M_DDR;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	clk_set_phase(host->clk_sample, host->clk_delays[index].sample);
+	clk_set_phase(host->clk_output, host->clk_delays[index].output);
+
+	return 0;
+}
+
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
-	u32 rate, oclk_dly, rval, sclk_dly;
+	u32 rate, rval;
 	u32 clock = ios->clock;
 	int ret;
 
@@ -692,32 +756,20 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
-	/* determine delays */
-	if (rate <= 400000) {
-		oclk_dly = host->clk_delays[SDXC_CLK_400K].output;
-		sclk_dly = host->clk_delays[SDXC_CLK_400K].sample;
-	} else if (rate <= 25000000) {
-		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
-		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
-	} else if (rate <= 52000000) {
-		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
-		    ios->timing != MMC_TIMING_MMC_DDR52) {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
-		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
-		} else {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
-		}
+	if (host->can_calibrate) {
+		ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_SAMP_DL_REG);
+		if (ret)
+			return ret;
+
+		ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_DS_DL_REG);
+		if (ret)
+			return ret;
 	} else {
-		return -EINVAL;
+		ret = sunxi_mmc_determine_delays(host, ios, rate);
+		if (ret)
+			return ret;
 	}
 
-	clk_set_phase(host->clk_sample, sclk_dly);
-	clk_set_phase(host->clk_output, oclk_dly);
-
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
 
@@ -990,6 +1042,9 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	else
 		host->clk_delays = sunxi_mmc_clk_delays;
 
+	if (of_device_is_compatible(np, "allwinner,sun50i-a64-mmc"))
+		host->can_calibrate = true;
+
 	ret = mmc_regulator_get_supply(host->mmc);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-- 
2.6.4
