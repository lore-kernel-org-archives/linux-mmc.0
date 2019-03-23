From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 09/24] mmc: mtk-sd: check for valid optional memory resource
Date: Sat, 23 Mar 2019 22:15:57 +0100
Message-ID: <20190323211612.860-10-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

'top_base' memory region is optional. Check that the resource is valid
before using it. This avoid getting a "invalid resource" error message
printed by the kernel.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 833ef0590af8..573aa127d00b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	host->top_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->top_base))
-		host->top_base = NULL;
+	if (ret) {
+		host->top_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(host->top_base))
+			host->top_base = NULL;
+	}
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-- 
2.20.1
