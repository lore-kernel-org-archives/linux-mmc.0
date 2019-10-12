From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 5/6 v2] MMC: JZ4740: Add support for the X1000.
Date: Sat, 12 Oct 2019 13:13:19 +0800
Message-ID: <1570857203-49192-6-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com, malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
List-Id: linux-mmc@vger.kernel.org

Add support for probing mmc driver on the X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/mmc/host/jz4740_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index f4c4890..44a04fe 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -109,6 +109,7 @@ enum jz4740_mmc_version {
 	JZ_MMC_JZ4725B,
 	JZ_MMC_JZ4760,
 	JZ_MMC_JZ4780,
+	JZ_MMC_X1000,
 };
 
 enum jz4740_mmc_state {
@@ -938,6 +939,7 @@ static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
 	{ .compatible = "ingenic,jz4760-mmc", .data = (void *) JZ_MMC_JZ4760 },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
+	{ .compatible = "ingenic,x1000-mmc", .data = (void *) JZ_MMC_X1000 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_mmc_of_match);
@@ -1039,7 +1041,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		dev_err(&pdev->dev, "Failed to add mmc host: %d\n", ret);
 		goto err_release_dma;
 	}
-	dev_info(&pdev->dev, "JZ SD/MMC card driver registered\n");
+	dev_info(&pdev->dev, "Ingenic SD/MMC card driver registered\n");
 
 	dev_info(&pdev->dev, "Using %s, %d-bit mode\n",
 		 host->use_dma ? "DMA" : "PIO",
-- 
2.7.4
