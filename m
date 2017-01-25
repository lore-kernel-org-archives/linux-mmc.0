From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v6 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Wed, 25 Jan 2017 15:28:08 -0500
Message-ID: <20170125202810.16876-2-chris.brandt@renesas.com>
References: <20170125202810.16876-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170125202810.16876-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Some controllers have 2 clock sources instead of 1. The 2nd clock
is for the internal card detect logic and must be enabled/disabled
along with the main core clock for proper operation.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v5:
* call clk_disable_unprepare even if clk_cd is NULL
v4:
* add technical explanation within probe routine
v3:
* add more clarification to the commit log
v2:
* changed clk2 to clk_cd
* disable clk if clk_cd enable fails
* changed clock name from "carddetect" to "cd"
---
 drivers/mmc/host/sh_mobile_sdhi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 59db14b..d964a0d 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -143,6 +143,7 @@ MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
 
 struct sh_mobile_sdhi {
 	struct clk *clk;
+	struct clk *clk_cd;
 	struct tmio_mmc_data mmc_data;
 	struct tmio_mmc_dma dma_priv;
 	struct pinctrl *pinctrl;
@@ -190,6 +191,12 @@ static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(priv->clk_cd);
+	if (ret < 0) {
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
 	/*
 	 * The clock driver may not know what maximum frequency
 	 * actually works, so it should be set with the max-frequency
@@ -255,6 +262,7 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 
 	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_cd);
 }
 
 static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
@@ -572,6 +580,21 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	/*
+	 * Some controllers provide a 2nd clock just to run the internal card
+	 * detection logic. Unfortunately, the existing driver architecture does
+	 * not support a separation of clocks for runtime PM usage. When
+	 * native hotplug is used, the tmio driver assumes that the core
+	 * must continue to run for card detect to stay active, so we cannot
+	 * disable it.
+	 * Additionally, it is prohibited to supply a clock to the core but not
+	 * to the card detect circuit. That leaves us with if separate clocks
+	 * are presented, we must treat them both as virtually 1 clock.
+	 */
+	priv->clk_cd = devm_clk_get(&pdev->dev, "cd");
+	if (IS_ERR(priv->clk_cd))
+		priv->clk_cd = NULL;
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
-- 
2.10.1
