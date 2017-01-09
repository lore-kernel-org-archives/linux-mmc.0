From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 3/6] mmc: sunxi: Add EMMC (MMC2) controller compatible
Date: Mon,  9 Jan 2017 17:46:52 +0100
Message-ID: <252556e96270e41e80cfe5bf248883c9b85cdeb7.1483980339.git-series.maxime.ripard@free-electrons.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
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

The MMC2 controller on the A64 is kind of a special beast.

While the general controller design is the same than the other MMC
controllers in the SoC, it also has a bunch of features and changes that
prevent it to be driven in the same way.

It has for example a different bus width limit, a different maximum
frequency, and, for some reason, the maximum buffer size of a DMA
descriptor.

Add a new compatible specifically for this controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 7 +++++++
 1 file changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9a860bcac154..bdcc87c9d8b8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1081,12 +1081,19 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.needs_new_timings = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
git-series 0.8.11
