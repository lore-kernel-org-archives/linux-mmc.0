From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] mmc: logging copyrights is useless
Date: Wed, 15 Mar 2017 14:11:55 +0100
Message-ID: <20170315131155.15113-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, pierre@ossman.eu
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Logging copyrights does not add any useful information in logs.
This patch remove such logging

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/mmc/host/sdhci.c | 1 -
 drivers/mmc/host/wbsd.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a7..a966ffd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3748,7 +3748,6 @@ static int __init sdhci_drv_init(void)
 {
 	pr_info(DRIVER_NAME
 		": Secure Digital Host Controller Interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
 
 	return 0;
 }
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index bd04e8b..9036429 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1947,7 +1947,6 @@ static int __init wbsd_drv_init(void)
 
 	pr_info(DRIVER_NAME
 		": Winbond W83L51xD SD/MMC card interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
 
 #ifdef CONFIG_PNP
 
-- 
2.10.2
