From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] mmc: mtk-sd: check for valid optional memory resource
Date: Wed,  3 Apr 2019 21:30:50 +0200
Message-ID: <20190403193050.22180-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, matthias.bgg@gmail.com, yingjoe.chen@mediatek.com
Cc: chaotian.jing@mediatek.com, ryder.lee@mediatek.com, jjian.zhou@mediatek.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

'top_base' memory region is optional. Check that the resource is valid
before using it. This avoid getting a "invalid resource" error message
printed by the kernel.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	Fix invalid condition: check against 'res' variable instead of 'ret'.

---
 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 833ef0590af8..61bf8704491c 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	host->top_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->top_base))
-		host->top_base = NULL;
+	if (res) {
+		host->top_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(host->top_base))
+			host->top_base = NULL;
+	}
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-- 
2.20.1
