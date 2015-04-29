From: <micky_ching@realsil.com.cn>
Subject: [PATCH 02/12] mmc: core: modify mmc_app_cmd interface for SD4.0
Date: Wed, 29 Apr 2015 09:23:34 +0800
Message-ID: <daf8d0aceaa873a2c5bed2c524b11908480750eb.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

When card running in SD4.0 mode, ACMD is not need to send two command,
we only need to mark a flag for the CMD which is to be send.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/card/block.c  |  2 +-
 drivers/mmc/core/sd_ops.c | 17 ++++++++++++-----
 include/linux/mmc/core.h  |  3 ++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2fc4269..a2acf3c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -532,7 +532,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_rel_host;
 
 	if (idata->ic.is_acmd) {
-		err = mmc_app_cmd(card->host, card);
+		err = mmc_app_cmd(card->host, card, &cmd);
 		if (err)
 			goto cmd_rel_host;
 	}
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 48d0c93..cd37971c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -22,7 +22,8 @@
 #include "core.h"
 #include "sd_ops.h"
 
-int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
+int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card,
+	struct mmc_command *next_cmd)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -30,6 +31,11 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	BUG_ON(!host);
 	BUG_ON(card && (card->host != host));
 
+	if (card && mmc_card_uhsii(card)) {
+		next_cmd->app_cmd = true;
+		return 0;
+	}
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
@@ -82,7 +88,7 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	 * we cannot use the retries field in mmc_command.
 	 */
 	for (i = 0;i <= retries;i++) {
-		err = mmc_app_cmd(host, card);
+		err = mmc_app_cmd(host, card, cmd);
 		if (err) {
 			/* no point in retrying; no APP commands allowed */
 			if (mmc_host_is_spi(host)) {
@@ -162,7 +168,8 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
-		err = mmc_wait_for_app_cmd(host, NULL, &cmd, MMC_CMD_RETRIES);
+		err = mmc_wait_for_app_cmd(host, host->card,
+			&cmd, MMC_CMD_RETRIES);
 		if (err)
 			break;
 
@@ -260,7 +267,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 
 	/* NOTE: caller guarantees scr is heap-allocated */
 
-	err = mmc_app_cmd(card->host, card);
+	err = mmc_app_cmd(card->host, card, &cmd);
 	if (err)
 		return err;
 
@@ -363,7 +370,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 
 	/* NOTE: caller guarantees ssr is heap-allocated */
 
-	err = mmc_app_cmd(card->host, card);
+	err = mmc_app_cmd(card->host, card, &cmd);
 	if (err)
 		return err;
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 337c6b8..b9821f1 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -235,7 +235,8 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
-extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
+extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *,
+	struct mmc_command *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
-- 
1.9.1
