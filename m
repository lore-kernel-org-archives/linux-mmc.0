From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 11/11] mmc: sdhci: Convert to use sdio_irq_claimed()
Date: Sun,  8 Sep 2019 12:12:36 +0200
Message-ID: <20190908101236.2802-12-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Instead of keeping track of whether SDIO IRQs have been enabled via an
internal sdhci status flag, avoid the open-coding and convert into using
sdio_irq_claimed().

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 7 +------
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4c4285387b47..4b297f397326 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2144,11 +2144,6 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		pm_runtime_get_noresume(host->mmc->parent);
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (enable)
-		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
-	else
-		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
-
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -3382,7 +3377,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 	host->runtime_suspended = false;
 
 	/* Enable SDIO IRQ */
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
+	if (sdio_irq_claimed(mmc))
 		sdhci_enable_sdio_irq_nolock(host, true);
 
 	/* Enable Card Detection */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8effaac61c3a..a29c4cd2d92e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -512,7 +512,6 @@ struct sdhci_host {
 #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
-#define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
 #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
-- 
2.17.1
