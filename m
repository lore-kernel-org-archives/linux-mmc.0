From: Pierre Tardy <tardyp@gmail.com>
Subject: [RFC,PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue,  1 Mar 2011 19:15:33 +0100
Message-ID: <b01ca43311e25bf24c6e60e9f6d6d7b91ae3a130.1298820826.git.tardyp@gmail.com>
References: <cover.1298820825.git.tardyp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1298820825.git.tardyp@gmail.com>
In-Reply-To: <cover.1298820825.git.tardyp@gmail.com>
References: <cover.1298820825.git.tardyp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org
Cc: Pierre Tardy <tardyp@gmail.com>
List-Id: linux-mmc@vger.kernel.org

When sdhci is runtime_suspended, it can still receive a wake-up
because of card insertion.
The wake-up will then be signaled by an interrupt which cannot be serviced
immediatly, as the device is powered off, and register are not accessibles.

We cannot call pm_runtime_get_sync() in irq context as on some architecture (e.g. intel_mid),
runtime_resume can lead to too much latency, due to e.g. PLL warm-up and such aggressive
power gating.

We temporarly disable the interrupt, and trigger a runtime_resume of the device
The interrupt will be re-enabled when resume is finished.

Signed-off-by: Pierre Tardy <tardyp@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c |    8 +-------
 drivers/mmc/host/sdhci.c     |   30 +++++++++++++++++++++++++++++-
 include/linux/mmc/sdhci.h    |    2 ++
 scripts/checkpatch.pl        |    6 +++---
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 1b5e70b..fc3d2e1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1166,13 +1166,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 	}
 
 	pci_save_state(pdev);
-	if (pm_flags & MMC_PM_KEEP_POWER) {
-		if (pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			pci_enable_wake(pdev, PCI_D3hot, 1);
-	} else {
-		pci_enable_wake(pdev, PCI_D3hot, 0);
-		pci_disable_device(pdev);
-	}
+	pci_enable_wake(pdev, PCI_D3hot, 1);
 	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 735c3f7..85a1956 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1599,6 +1599,21 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	u32 intmask;
 	int cardint = 0;
 
+	/* we might come from a sd insertion or sdio irq wake.. */
+	if (pm_runtime_suspended()) {
+		host->waking_up = 1;
+		/* Note that we disable temporarly the interrupt until we do the
+		 * resume. If we don't then we'll get constantly interrupted
+		 * until we actually resume.
+		 *
+		 * as the irq is shared, this might not be very friendly to our
+		 * irq sharers but the pm_runtime workqueue should really be
+		 * called soon.
+		 */
+		disable_irq_nosync(irq);
+		pm_runtime_get(host->mmc->parent);
+		return IRQ_NONE;
+	}
 	spin_lock(&host->lock);
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
@@ -1747,7 +1762,12 @@ EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
 int sdhci_runtime_suspend(struct sdhci_host *host)
 {
-	/* nothing to do yet */
+	u8 val;
+	/* make sure we wake up on sdcard insert/remove enabled */
+	val = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE;
+	if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+		val |= SDHCI_WAKE_ON_INT;
+	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 	return 0;
 }
 
@@ -1768,6 +1788,14 @@ int sdhci_runtime_resume(struct sdhci_host *host)
 	sdhci_set_ios(host->mmc, &host->mmc->ios);
 	mmiowb();
 
+	if (host->waking_up) {
+		host->waking_up = 0;
+		/* Re-enable the irq now we are perfectly resumed.
+		 * Any yet unhandled interrupt (i.e. the wake) will retrigger
+		 * irq
+		 */
+		irq_enable(host->irq);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_resume);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index a38d040..6a3c6af 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -146,6 +146,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
 
+	bool                    waking_up;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3c7fc0..17aeda3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1325,8 +1325,8 @@ sub process {
 		$prefix = "$filename:$realline: " if ($emacs && $file);
 		$prefix = "$filename:$linenr: " if ($emacs && !$file);
 
-		$here = "#$linenr: " if (!$file);
-		$here = "#$realline: " if ($file);
+		$here = "" if (!$file);
+		$here = "" if ($file);
 
 		# extract the filename as it passes
 		if ($line =~ /^diff --git.*?(\S+)$/) {
@@ -1349,7 +1349,7 @@ sub process {
 			next;
 		}
 
-		$here .= "FILE: $realfile:$realline:" if ($realcnt != 0);
+		$here .= "$realfile:$realline:" if ($realcnt != 0);
 
 		my $hereline = "$here\n$rawline\n";
 		my $herecurr = "$here\n$rawline\n";
-- 
1.7.1
