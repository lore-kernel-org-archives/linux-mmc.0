From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mmc: mediatek: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:33:47 +0800
Message-ID: <e391bcb1abbe5f7ff46973a5713fd7e067b7e9ff.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

The usage of of_device_get_match_data() reduce the code size a bit.

Also, the only way to call msdc_drv_probe() is to match an entry in
msdc_of_ids[], so of_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6457a7d..67e9b57 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
@@ -1808,7 +1809,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct msdc_host *host;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	int ret;
 
 	if (!pdev->dev.of_node) {
@@ -1816,9 +1816,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	of_id = of_match_node(msdc_of_ids, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
 	/* Allocate MMC host for this device */
 	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
 	if (!mmc)
@@ -1887,7 +1884,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
-	host->dev_comp = of_id->data;
+	host->dev_comp = of_device_get_match_data(&pdev->dev);
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
-- 
1.9.1
