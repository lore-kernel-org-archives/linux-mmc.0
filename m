From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
Date: Tue,  3 Sep 2019 16:22:02 +0200
Message-ID: <20190903142207.5825-7-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
the ->ack_sdio_irq() is already mandatory, which was not the case for those
host drivers that called sdio_run_irqs() directly.

As there are no longer any drivers calling sdio_run_irqs(), let's clarify
the code by dropping the unnecessary check and explicitly state that the
callback is mandatory in the header file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 include/linux/mmc/host.h    | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0962a4357d54..d7965b53a6d2 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		if (host->ops->ack_sdio_irq)
-			host->ops->ack_sdio_irq(host);
+		host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0a565c7ff1..ecdc1b0b1313 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -128,6 +128,7 @@ struct mmc_host_ops {
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
 	void	(*ack_sdio_irq)(struct mmc_host *host);
 
 	/* optional callback for HC quirks */
-- 
2.17.1
