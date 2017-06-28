From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] mmc: android-goldfish: remove logically dead code in
 goldfish_mmc_irq()
Date: Wed, 28 Jun 2017 08:55:15 -0500
Message-ID: <20170628135515.GA5462@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

Local variable transfer_error is assigned to a constant value and
it is never updated again.

Remove this variable and the dead code it guards.

Addresses-Coverity-ID: 1222110
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/mmc/host/android-goldfish.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 5b3e1c9..63fe509 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -290,7 +290,6 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 	u16 status;
 	int end_command = 0;
 	int end_transfer = 0;
-	int transfer_error = 0;
 	int state_changed = 0;
 	int cmd_timeout = 0;
 
@@ -322,9 +321,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 	if (end_command)
 		goldfish_mmc_cmd_done(host, host->cmd);
 
-	if (transfer_error)
-		goldfish_mmc_xfer_done(host, host->data);
-	else if (end_transfer) {
+	if (end_transfer) {
 		host->dma_done = 1;
 		goldfish_mmc_end_of_data(host, host->data);
 	} else if (host->data != NULL) {
@@ -347,8 +344,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 		mmc_detect_change(host->mmc, 0);
 	}
 
-	if (!end_command && !end_transfer &&
-	    !transfer_error && !state_changed && !cmd_timeout) {
+	if (!end_command && !end_transfer && !state_changed && !cmd_timeout) {
 		status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
 		dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
 		if (status != 0) {
-- 
2.5.0
