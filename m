From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 08/15] mmc: sdhci: add standard hw auto retuning support
Date: Tue, 12 Jul 2016 15:46:17 +0800
Message-ID: <1468309584-3591-9-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

If HW supports SDHCI_TUNING_MODE_3 which is auto retuning, we won't
retune during runtime suspend and resume, instead we use Re-tuning
Request signaled via SDHCI_INT_RETUNE interrupt to do retuning and
hw auto retuning during data transfer to guarantee the signal sample
window correction.

This can avoid a mass of repeatedly retuning during small file system
data access and improve the performance.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 15 ++++++++++++---
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7894652b9929..31c14b0ff8e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -229,6 +229,10 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 		    SDHCI_INT_TIMEOUT | SDHCI_INT_DATA_END |
 		    SDHCI_INT_RESPONSE;
 
+	if (host->tuning_mode == SDHCI_TUNING_MODE_2 ||
+	    host->tuning_mode == SDHCI_TUNING_MODE_3)
+		host->ier |= SDHCI_INT_RETUNE;
+
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
@@ -2673,6 +2677,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			pr_err("%s: Card is consuming too much power!\n",
 				mmc_hostname(host->mmc));
 
+		if (intmask & SDHCI_INT_RETUNE)
+			mmc_retune_needed(host->mmc);
+
 		if (intmask & SDHCI_INT_CARD_INT) {
 			sdhci_enable_sdio_irq_nolock(host, false);
 			host->thread_isr |= SDHCI_INT_CARD_INT;
@@ -2682,7 +2689,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
 			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
 			     SDHCI_INT_ERROR | SDHCI_INT_BUS_POWER |
-			     SDHCI_INT_CARD_INT);
+			     SDHCI_INT_RETUNE | SDHCI_INT_CARD_INT);
 
 		if (intmask) {
 			unexpected |= intmask;
@@ -2787,7 +2794,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	sdhci_disable_card_detection(host);
 
 	mmc_retune_timer_stop(host->mmc);
-	mmc_retune_needed(host->mmc);
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
 		host->ier = 0;
@@ -2848,7 +2856,8 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	unsigned long flags;
 
 	mmc_retune_timer_stop(host->mmc);
-	mmc_retune_needed(host->mmc);
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->ier &= SDHCI_INT_CARD_INT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e241e11a90d0..0411c9f36461 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -128,6 +128,7 @@
 #define  SDHCI_INT_CARD_INSERT	0x00000040
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
+#define  SDHCI_INT_RETUNE	0x00001000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
 #define  SDHCI_INT_CRC		0x00020000
@@ -518,6 +519,8 @@ struct sdhci_host {
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
 #define SDHCI_TUNING_MODE_1	0
+#define SDHCI_TUNING_MODE_2	1
+#define SDHCI_TUNING_MODE_3	2
 
 	unsigned long private[0] ____cacheline_aligned;
 };
-- 
1.9.1
