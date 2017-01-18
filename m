From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Wed, 18 Jan 2017 12:25:00 -0500
Message-ID: <20170118172502.13876-2-chris.brandt@renesas.com>
References: <20170118172502.13876-1-chris.brandt@renesas.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:15666 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752568AbdARRcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2017 12:32:16 -0500
In-Reply-To: <20170118172502.13876-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>

Some controllers have 2 clock sources instead of 1, so they both need
to be turned on/off.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
* changed clk2 to clk_cd
* disable clk if clk_cd enable fails
* changed clock name from "carddetect" to "cd"
---
 drivers/mmc/host/sh_mobile_sdhi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 59db14b..a3f995e 100644
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
@@ -255,6 +262,8 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 
 	clk_disable_unprepare(priv->clk);
+	if (priv->clk_cd)
+		clk_disable_unprepare(priv->clk_cd);
 }
 
 static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
@@ -572,6 +581,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	priv->clk_cd = devm_clk_get(&pdev->dev, "cd");
+	if (IS_ERR(priv->clk_cd))
+		priv->clk_cd = NULL;
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
-- 
2.10.1


