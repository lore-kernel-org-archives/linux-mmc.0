From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] mmc: meson-gx: add device reset
Date: Tue, 15 May 2018 11:57:48 +0200
Message-ID: <20180515095748.6794-3-jbrunet@baylibre.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515095748.6794-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Trigger the reset line of the mmc controller while probing, if available.
The reset should be optional for now, at least until all related DT nodes
have the reset property.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4f972b879fe6..9bca359f7936 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/pinctrl/consumer.h>
@@ -1184,6 +1185,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	ret = device_reset_optional(&pdev->dev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "device reset failed: %d\n", ret);
+
+		return ret;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->regs)) {
-- 
2.14.3
