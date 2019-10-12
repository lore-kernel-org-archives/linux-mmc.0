From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 3/6 v2] MMC: JZ4740: Add support for the JZ4760.
Date: Sat, 12 Oct 2019 13:13:17 +0800
Message-ID: <1570857203-49192-4-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com, malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
List-Id: linux-mmc@vger.kernel.org

Add support for probing mmc driver on the JZ4760 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 69c4a8b..f4c4890 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -107,6 +107,7 @@
 enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
 	JZ_MMC_JZ4725B,
+	JZ_MMC_JZ4760,
 	JZ_MMC_JZ4780,
 };
 
@@ -935,6 +936,7 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
 	{ .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
+	{ .compatible = "ingenic,jz4760-mmc", .data = (void *) JZ_MMC_JZ4760 },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{},
 };
-- 
2.7.4
