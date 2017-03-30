From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 02/13] clk: apn806: Turn the eMMC clock as optional for dts
 backwards compatible
Date: Thu, 30 Mar 2017 17:22:54 +0200
Message-ID: <b94b2164859fa487a38bcb00e95dd26cc20aef77.1490886907.git-series.gregory.clement@free-electrons.com>
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
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@baylibre.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Wilson
List-Id: linux-mmc@vger.kernel.org

First version of the binding didn't have the eMMC clock. This patch
allows to not registering the eMMC clock if it is not present in the
device tree. Then the device tree can be backwards compatible.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 901d89c4ab4a..103fe18a3c29 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -136,13 +136,19 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	/* eMMC Clock is fixed clock divided by 3 */
-	of_property_read_string_index(np, "clock-output-names",
-				      4, &name);
-	ap806_clks[4] = clk_register_fixed_factor(NULL, name, fixedclk_name,
-						  0, 1, 3);
-	if (IS_ERR(ap806_clks[4])) {
-		ret = PTR_ERR(ap806_clks[4]);
-		goto fail4;
+	if (of_property_read_string_index(np, "clock-output-names",
+					  4, &name)) {
+		ap806_clk_data.clk_num--;
+		dev_warn(&pdev->dev,
+			 "eMMC clock mising: update the device tree!\n");
+	} else {
+		ap806_clks[4] = clk_register_fixed_factor(NULL, name,
+							  fixedclk_name,
+							  0, 1, 3);
+		if (IS_ERR(ap806_clks[4])) {
+			ret = PTR_ERR(ap806_clks[4]);
+			goto fail4;
+		}
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
-- 
git-series 0.9.1
