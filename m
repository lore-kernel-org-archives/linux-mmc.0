From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 5/6] mmc: move mmc_send_cxd_data() to core.c
Date: Fri, 13 Nov 2015 15:56:11 +0100
Message-ID: <1447426572-11756-6-git-send-email-holgerschurig@gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avi.shchislowski@sandisk.com, alex.lemberg@sandisk.com
Cc: Holger Schurig <holgerschurig@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This function can be used to send ext_csd data towards the chip, which is
needed in the (upcoming) firmware update patch.

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>
---
 drivers/mmc/core/mmc_ops.c | 4 ++--
 include/linux/mmc/core.h   | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1f44426..d1d6abc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -287,8 +287,7 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
  * NOTE: void *buf, caller for the buf is required to use DMA-capable
  * buffer or on-stack buffer (with some overhead in callee).
  */
-static int
-mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
+int mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		u32 opcode, void *buf, unsigned len)
 {
 	struct mmc_request mrq = {NULL};
@@ -336,6 +335,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 
 	return 0;
 }
+EXPORT_SYMBOL(mmc_send_cxd_data);
 
 int mmc_send_csd(struct mmc_card *card, u32 *csd)
 {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 774846f..b0e0f15 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -162,6 +162,9 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+extern int mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
+		u32 opcode, void *buf, unsigned len);
+
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
-- 
2.1.4
