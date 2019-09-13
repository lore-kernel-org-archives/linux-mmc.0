From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: tmio: Fixup runtime PM management during remove
Date: Fri, 13 Sep 2019 11:41:18 +0200
Message-ID: <20190913094118.21243-1-ulf.hansson@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Simon Horman <horms+renesas@verge.net.au>, Niklas Soderlund <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Accessing the device when it may be runtime suspended is a bug, which is
the case in tmio_mmc_host_remove(). Let's fix the behaviour.

Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 32f9679ec42e..9b6e1001e77c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1274,12 +1274,11 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	struct platform_device *pdev = host->pdev;
 	struct mmc_host *mmc = host->mmc;
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ)
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 
-	if (!host->native_hotplug)
-		pm_runtime_get_sync(&pdev->dev);
-
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
 	mmc_remove_host(mmc);
@@ -1288,6 +1287,8 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	tmio_mmc_release_dma(host);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (host->native_hotplug)
+		pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.17.1
