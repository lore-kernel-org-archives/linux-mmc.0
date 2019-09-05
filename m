From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 2/4] MMC: Ingenic: Add 8bit mode support.
Date: Thu,  5 Sep 2019 15:38:07 +0800
Message-ID: <1567669089-88693-3-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, paul.burton@mips.com, linus.walleij@linaro.org, paul@crapouillou.net, malat@debian.org, yuehaibing@huawei.com, ezequiel@collabora.com, robh+dt@kernel.org, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com
List-Id: linux-mmc@vger.kernel.org

Add support for 8bit mode, now supports 1bit/4bit/8bit modes.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/mmc/host/jz4740_mmc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 1b1fcb7..d6811a7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -79,6 +79,8 @@
 
 #define JZ_MMC_CMDAT_IO_ABORT BIT(11)
 #define JZ_MMC_CMDAT_BUS_WIDTH_4BIT BIT(10)
+#define JZ_MMC_CMDAT_BUS_WIDTH_8BIT (BIT(10) | BIT(9))
+#define	JZ_MMC_CMDAT_BUS_WIDTH_MASK (BIT(10) | BIT(9))
 #define JZ_MMC_CMDAT_DMA_EN BIT(8)
 #define JZ_MMC_CMDAT_INIT BIT(7)
 #define JZ_MMC_CMDAT_BUSY BIT(6)
@@ -899,11 +901,16 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
-		host->cmdat &= ~JZ_MMC_CMDAT_BUS_WIDTH_4BIT;
+		host->cmdat &= ~JZ_MMC_CMDAT_BUS_WIDTH_MASK;
 		break;
 	case MMC_BUS_WIDTH_4:
+		host->cmdat &= ~JZ_MMC_CMDAT_BUS_WIDTH_MASK;
 		host->cmdat |= JZ_MMC_CMDAT_BUS_WIDTH_4BIT;
 		break;
+	case MMC_BUS_WIDTH_8:
+		host->cmdat &= ~JZ_MMC_CMDAT_BUS_WIDTH_MASK;
+		host->cmdat |= JZ_MMC_CMDAT_BUS_WIDTH_8BIT;
+		break;
 	default:
 		break;
 	}
@@ -1034,7 +1041,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	dev_info(&pdev->dev, "Using %s, %d-bit mode\n",
 		 host->use_dma ? "DMA" : "PIO",
-		 (mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1);
+		 (mmc->caps & MMC_CAP_8_BIT_DATA) ? 8 :
+		 ((mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1));
 
 	return 0;
 
-- 
2.7.4
