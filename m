From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci-pic32: remove owner assignment
Date: Fri,  8 Apr 2016 14:22:37 +0900
Message-ID: <1460092958-16591-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

A platform_driver does not need to set an owner, it will be populated
by the driver core.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pic32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 059df70..72c13b6 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -243,7 +243,6 @@ MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
 static struct platform_driver pic32_sdhci_driver = {
 	.driver = {
 		.name	= "pic32-sdhci",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
 	},
 	.probe		= pic32_sdhci_probe,
-- 
1.9.1
