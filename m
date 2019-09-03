From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date: Tue,  3 Sep 2019 16:22:05 +0200
Message-ID: <20190903142207.5825-10-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c1ebc26846db..2a9be044448a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2161,8 +2161,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1
