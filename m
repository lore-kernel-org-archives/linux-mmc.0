From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date: Sun,  8 Sep 2019 12:12:34 +0200
Message-ID: <20190908101236.2802-10-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..efa6cda8c991 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2163,8 +2163,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1
