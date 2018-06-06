From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
Date: Wed,  6 Jun 2018 18:43:32 +0000
Message-ID: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

This patch fix the following build failure on m68k:
ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..77d6ba090436 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
2.16.4
