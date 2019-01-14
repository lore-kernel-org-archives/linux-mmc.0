From: Alamy Liu <alamy.liu@gmail.com>
Subject: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date: Mon, 14 Jan 2019 11:17:21 -0800
Message-ID: <20190114191724.29960-1-alamy.liu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alamy Liu <alamy.liu@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Prevent to use fixed value (NUM_SLOTS) after it had been determined
and saved in a variable (cq_host->num_slots).

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 159270e947..26d63594b7 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
 		 * The only way to guarantee forward progress is to mark at
 		 * least one task in error, so if none is indicated, pick one.
 		 */
-		for (tag = 0; tag < NUM_SLOTS; tag++) {
+		for (tag = 0; tag < cq_host->num_slots; tag++) {
 			slot = &cq_host->slot[tag];
 			if (!slot->mrq)
 				continue;
-- 
2.17.1
