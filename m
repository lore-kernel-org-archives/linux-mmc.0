From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 4/4] MMC: Ingenic: Add support for JZ4760 and support for LPM.
Date: Thu,  5 Sep 2019 15:38:09 +0800
Message-ID: <1567669089-88693-5-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, paul.burton@mips.com, linus.walleij@linaro.org, paul@crapouillou.net, malat@debian.org, yuehaibing@huawei.com, ezequiel@collabora.com, robh+dt@kernel.org, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com
List-Id: linux-mmc@vger.kernel.org

1.add support for probing mmc driver on the JZ4760 Soc from Ingenic.
2.add support for Low Power Mode of Ingenic's MMC/SD Controller.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/mmc/host/jz4740_mmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index d6811a7..1e61f1b 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -43,6 +43,7 @@
 #define JZ_REG_MMC_RES		0x34
 #define JZ_REG_MMC_RXFIFO	0x38
 #define JZ_REG_MMC_TXFIFO	0x3C
+#define JZ_REG_MMC_LPM		0x40
 #define JZ_REG_MMC_DMAC		0x44
 
 #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
@@ -102,11 +103,15 @@
 #define JZ_MMC_DMAC_DMA_SEL BIT(1)
 #define JZ_MMC_DMAC_DMA_EN BIT(0)
 
+#define	JZ_MMC_LPM_DRV_RISING BIT(31)
+#define	JZ_MMC_LPM_LOW_POWER_MODE_EN BIT(0)
+
 #define JZ_MMC_CLK_RATE 24000000
 
 enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
 	JZ_MMC_JZ4725B,
+	JZ_MMC_JZ4760,
 	JZ_MMC_JZ4780,
 };
 
@@ -858,6 +863,16 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
 	}
 
 	writew(div, host->base + JZ_REG_MMC_CLKRT);
+
+	if (host->version >= JZ_MMC_JZ4760) {
+		if (real_rate > 25000000)
+			writel(JZ_MMC_LPM_DRV_RISING |
+				   JZ_MMC_LPM_LOW_POWER_MODE_EN,
+				   host->base + JZ_REG_MMC_LPM);
+	} else if (host->version >= JZ_MMC_JZ4725B)
+		writel(JZ_MMC_LPM_LOW_POWER_MODE_EN,
+			   host->base + JZ_REG_MMC_LPM);
+
 	return real_rate;
 }
 
@@ -935,6 +950,7 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
 	{ .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
+	{ .compatible = "ingenic,jz4760-mmc", .data = (void *) JZ_MMC_JZ4760 },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{},
 };
-- 
2.7.4
