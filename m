From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 08/11] mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
Date: Sun,  8 Sep 2019 12:12:33 +0200
Message-ID: <20190908101236.2802-9-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
behaviour. Some problems have been taken care of so far, but more issues
remains.

For example, calling the ->ack_sdio_irq() callback to let host drivers
re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
which may not be the case during system suspend/resume. This may lead to
that a host driver re-signals the same SDIO IRQ over and over again,
causing a storm of IRQs and gives a ping-pong effect towards the
sdio_irq_work().

Moreover, calling the ->enable_sdio_irq() callback at system resume to
re-enable already enabled SDIO IRQs for the host, causes the runtime PM
count for some host drivers to become in-balanced. This then leads to the
host to remain runtime resumed, no matter if it's needed or not.

To fix these problems, let's check if process_sdio_pending_irqs() actually
consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
->ack_sdio_irq() callback.

Additionally, there should be no need to re-enable SDIO IRQs as the host
driver already knows if they were enabled at system suspend, thus also
whether it needs to re-enable them at system resume. For this reason, drop
the call to ->enable_sdio_irq() during system resume.

In regards to these changes there is yet another issue, which is when there
is an SDIO IRQ being signaled by the host driver, but after the SDIO card
has been system suspended. Currently these IRQs are just thrown away, while
we should at least make sure to try to consume them when the SDIO card has
been system resumed. Fix this by queueing a sdio_irq_work() after we system
resumed the SDIO card.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Queue a sdio_irq_work() rather using sdio_signal_irq().

---
 drivers/mmc/core/sdio.c     | 2 +-
 drivers/mmc/core/sdio_irq.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c557f1519b77..26cabd53ddc5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			host->ops->enable_sdio_irq(host, 1);
+			queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
 	}
 
 out:
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index d7965b53a6d2..900871073bd7 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,7 +115,8 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		host->ops->ack_sdio_irq(host);
+		if (!host->sdio_irq_pending)
+			host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
-- 
2.17.1
