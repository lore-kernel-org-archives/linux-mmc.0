From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v6 01/14] clk: apn806: Add eMMC clock to system controller driver
Date: Tue, 14 Feb 2017 18:01:41 +0100
Message-ID: <83800a641e82cd7dc653cd7b7728f4bb432407a2.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52356 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdBNRCO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 12:02:14 -0500
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda

From: Konstantin Porotchkin <kostap@marvell.com>

Add fixed clock of 400MHz to system controller driver.  This clock is
used as SD/eMMC clock source.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Reviewed-by: Omri Itach <omrii@marvell.com>
Reviewed-by: Hanna Hawa <hannah@marvell.com>
[fixed up conflicts, added error handling --rmk]
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  3 ++-
 drivers/clk/mvebu/ap806-system-controller.c   | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index a749ba2edec4..5019c8f4acd0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -235,7 +235,8 @@
 				#clock-cells = <1>;
 				clock-output-names = "ap-cpu-cluster-0",
 						     "ap-cpu-cluster-1",
-						     "ap-fixed", "ap-mss";
+						     "ap-fixed", "ap-mss",
+						     "ap-emmc";
 				reg = <0x6f4000 0x1000>;
 			};
 		};
diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 8181b919f062..0a785076b0c6 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -23,7 +23,7 @@
 #define AP806_SAR_REG			0x400
 #define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
 
-#define AP806_CLK_NUM			4
+#define AP806_CLK_NUM			5
 
 static struct clk *ap806_clks[AP806_CLK_NUM];
 
@@ -117,6 +117,17 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 		goto fail3;
 	}
 
+	/* eMMC Clock is fixed clock divided by 3 */
+	of_property_read_string_index(np, "clock-output-names",
+				      4, &name);
+	ap806_clks[4] = clk_register_fixed_factor(NULL, name, fixedclk_name,
+						  0, 1, 3);
+	if (IS_ERR(ap806_clks[4])) {
+		ret = PTR_ERR(ap806_clks[4]);
+		goto fail4;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	if (ret)
 		goto fail_clk_add;
@@ -124,6 +135,8 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	return 0;
 
 fail_clk_add:
+	clk_unregister_fixed_factor(ap806_clks[4]);
+fail4:
 	clk_unregister_fixed_factor(ap806_clks[3]);
 fail3:
 	clk_unregister_fixed_rate(ap806_clks[2]);
-- 
git-series 0.9.1
