From: NeilBrown <neilb@suse.de>
Subject: [PATCH 4/4] mmc: omap_hsmmc: switch to 1-bit before stopping clocks.
Date: Tue, 24 Feb 2015 13:42:24 +1100
Message-ID: <20150224024223.22719.5177.stgit@notabene.brown>
References: <20150224024023.22719.32436.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224024023.22719.32436.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Make use of the new mmc_sdio_want_no_clocks() call to avoid stopping
clocks while SD Card interrupts are enabled and we aren't in
1-bit mode.

Also stop clocks immediately in omap_hsmmc_disable_fclk() if
1-bit mode has been entered for this purpose.

With this, I can use my libertas wifi with a 4-bit bus, with
interrupts and runtime power-management enabled, and get around
14Mb/sec throughput (which is the best I've seen).

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/omap_hsmmc.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f84cfb01716d..14fce3b92633 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1791,9 +1791,12 @@ static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
-
+	if (atomic_read(&mmc->sdio_narrowed) == 2)
+		pm_runtime_put_sync(host->dev);
+	else {
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
+	}
 	return 0;
 }
 
@@ -2311,6 +2314,10 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 	spin_lock_irqsave(&host->irq_lock, flags);
 	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
 	    (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
+		if (mmc_sdio_want_no_clocks(host->mmc) == 0) {
+			ret = -EBUSY;
+			goto abort;
+		}
 		/* disable sdio irq handling to prevent race */
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
