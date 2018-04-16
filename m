From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 3/7] mmc: sunxi: Move bus width configuration to a function
Date: Mon, 16 Apr 2018 16:23:01 +0200
Message-ID: <c595021d9453e69b53aaafe01e9fb4546dc7d719.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

In order to improve readibility and reusability, let's move the bus width
setup to a small function called by our .set_ios hook.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9fdaea37aa74..c0bb75e17a44 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -855,6 +855,22 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	return 0;
 }
 
+static void sunxi_mmc_set_bus_width(struct sunxi_mmc_host *host,
+				   unsigned char width)
+{
+	switch (width) {
+	case MMC_BUS_WIDTH_1:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
+		break;
+	case MMC_BUS_WIDTH_4:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
+		break;
+	case MMC_BUS_WIDTH_8:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
+		break;
+	}
+}
+
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -903,18 +919,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	/* set bus width */
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_1:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
-		break;
-	case MMC_BUS_WIDTH_4:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
-		break;
-	case MMC_BUS_WIDTH_8:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
-		break;
-	}
+	sunxi_mmc_set_bus_width(host, ios->bus_width);
 
 	/* set ddr mode */
 	rval = mmc_readl(host, REG_GCTRL);
-- 
git-series 0.9.1
