From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v5 7/13] mmc: sunxi: Add more debug informations
Date: Fri, 27 Jan 2017 22:38:39 +0100
Message-ID: <b73d3b355cd937d572d2ca3292b4dfb2bea217e4.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add a bit more debug messages that can be helpful when debugging the clock
setup.

Also fill the actual_clock field in struct mmc_host to report properly the
current frequency in debugfs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/mmc/host/sunxi-mmc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f0f6922bca8a..6ffcd2838272 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -661,6 +661,9 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	unsigned long expire = jiffies + msecs_to_jiffies(750);
 	u32 rval;
 
+	dev_dbg(mmc_dev(host->mmc), "%sabling the clock\n",
+		oclk_en ? "en" : "dis");
+
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON | SDXC_MASK_DATA0);
 
@@ -737,6 +740,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 			index = SDXC_CLK_50M_DDR;
 		}
 	} else {
+		dev_dbg(mmc_dev(host->mmc), "Invalid clock... returning\n");
 		return -EINVAL;
 	}
 
@@ -749,6 +753,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
+	struct mmc_host *mmc = host->mmc;
 	long rate;
 	u32 rval, clock = ios->clock;
 	int ret;
@@ -757,6 +762,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
+	/* Our clock is gated now */
+	mmc->actual_clock = 0;
+
 	if (!ios->clock)
 		return 0;
 
@@ -767,17 +775,17 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
-		dev_err(mmc_dev(host->mmc), "error rounding clk to %d: %ld\n",
+		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",
 			clock, rate);
 		return rate;
 	}
-	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
+	dev_dbg(mmc_dev(mmc), "setting clk to %d, rounded %ld\n",
 		clock, rate);
 
 	/* setting clock rate */
 	ret = clk_set_rate(host->clk_mmc, rate);
 	if (ret) {
-		dev_err(mmc_dev(host->mmc), "error setting clk to %ld: %d\n",
+		dev_err(mmc_dev(mmc), "error setting clk to %ld: %d\n",
 			rate, ret);
 		return ret;
 	}
@@ -812,7 +820,14 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	 * least on the A64).
 	 */
 
-	return sunxi_mmc_oclk_onoff(host, 1);
+	ret = sunxi_mmc_oclk_onoff(host, 1);
+	if (ret)
+		return ret;
+
+	/* And we just enabled our clock back */
+	mmc->actual_clock = rate;
+
+	return 0;
 }
 
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.8.11
