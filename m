From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 01/13] clk: apn806: Add eMMC clock to system controller
 driver
Date: Thu, 30 Mar 2017 17:22:53 +0200
Message-ID: <2230c827fee236e0fd03bca01f4d0546d20f0f9b.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@baylibre.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stephen Boyd <sboyd@codeaurora.>
List-Id: linux-mmc@vger.kernel.org

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
index f17702107ac5..901d89c4ab4a 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -23,7 +23,7 @@
 #define AP806_SAR_REG			0x400
 #define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
 
-#define AP806_CLK_NUM			4
+#define AP806_CLK_NUM			5
 
 static struct clk *ap806_clks[AP806_CLK_NUM];
 
@@ -135,6 +135,17 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
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
@@ -142,6 +153,8 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	return 0;
 
 fail_clk_add:
+	clk_unregister_fixed_factor(ap806_clks[4]);
+fail4:
 	clk_unregister_fixed_factor(ap806_clks[3]);
 fail3:
 	clk_unregister_fixed_rate(ap806_clks[2]);
-- 
git-series 0.9.1
