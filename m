From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v3 3/4] mmc: sdhci: add a quirk for single block transactions
Date: Fri,  9 Jan 2015 19:41:44 +0800
Message-ID: <1420803705-4539-4-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, andy.green@linaro.org, linux@arm.linux.org.uk, patches@linaro.org, chris@printf.net, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, jaswinder.singh@linaro.org
List-Id: linux-mmc@vger.kernel.org

This patch defines a quirk to disable the block count
for single block transactions.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 8 +++++---
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b319c10..5581b16 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -911,7 +911,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
-	u16 mode;
+	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
 	if (data == NULL) {
@@ -929,9 +929,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	WARN_ON(!host->data);
 
-	mode = SDHCI_TRNS_BLK_CNT_EN;
+	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
+		mode = SDHCI_TRNS_BLK_CNT_EN;
+
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
-		mode |= SDHCI_TRNS_MULTI;
+		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
 		/*
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dd2ba4b..2e048f4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -108,6 +108,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
 /* forced tuned clock */
 #define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<12)
+/* disable the block count for single block transactions */
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0
