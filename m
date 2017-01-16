From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 7/13] mmc: sunxi: Add more debug messages
Date: Mon, 16 Jan 2017 17:56:57 +0100
Message-ID: <102ea884b296dae38ab28369ce14aa7a7998dc80.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

Add a bit more debug messages that can be helpful when debugging the clock
setup.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f0f6922bca8a..40ed287ceb1c 100644
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
 
@@ -753,6 +757,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	u32 rval, clock = ios->clock;
 	int ret;
 
+	dev_dbg(mmc_dev(host->mmc), "setting clk to %u (requested %u)\n",
+		clock, ios->clock);
+
 	ret = sunxi_mmc_oclk_onoff(host, 0);
 	if (ret)
 		return ret;
@@ -771,8 +778,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 			clock, rate);
 		return rate;
 	}
-	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
-		clock, rate);
+	dev_dbg(mmc_dev(host->mmc), "Rounded clk to %ld\n", rate);
 
 	/* setting clock rate */
 	ret = clk_set_rate(host->clk_mmc, rate);
-- 
git-series 0.8.11
