From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: host: fix typo after MMC_DEBUG move
Date: Tue,  5 Sep 2017 20:27:50 +0200
Message-ID: <20170905182750.4343-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

MMC_DEBUG was moved and one letter got strangely capitalized.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

based on mmc/next

 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 02179ed2a40d7a..8c15637178ff3c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -5,7 +5,7 @@
 comment "MMC/SD/SDIO Host Controller Drivers"
 
 config MMC_DEBUG
-	bool "MMC host drivers debugginG"
+	bool "MMC host drivers debugging"
 	depends on MMC != n
 	help
 	  This is an option for use by developers; most people should
-- 
2.11.0
