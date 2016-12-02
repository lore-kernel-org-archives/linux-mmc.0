From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 5/9] mmc: mmc: Introduce mmc_abort_tuning()
Date: Fri,  2 Dec 2016 15:14:23 +0200
Message-ID: <1480684467-26833-6-git-send-email-adrian.hunter@intel.com>
References: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50159 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758960AbcLBNTp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 08:19:45 -0500
In-Reply-To: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

If a tuning command times out, the card could still be processing it, which
will cause problems for recovery. The eMMC specification says that CMD12
can be used to stop CMD21, so add a function that does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 25 +++++++++++++++++++++++++
 include/linux/mmc/core.h   |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 81ce63bb0773..b11c3455b040 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -678,6 +678,31 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
 }
 EXPORT_SYMBOL_GPL(mmc_send_tuning);
 
+int mmc_abort_tuning(struct mmc_host *host, u32 opcode)
+{
+	struct mmc_command cmd = {0};
+
+	/*
+	 * eMMC specification specifies that CMD12 can be used to stop a tuning
+	 * command, but SD specification does not, so do nothing unless it is
+	 * eMMC.
+	 */
+	if (opcode != MMC_SEND_TUNING_BLOCK_HS200)
+		return 0;
+
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	/*
+	 * For drivers that override R1 to R1b, set an arbitrary timeout based
+	 * on the tuning timeout i.e. 150ms.
+	 */
+	cmd.busy_timeout = 150;
+
+	return mmc_wait_for_cmd(host, &cmd, 0);
+}
+EXPORT_SYMBOL_GPL(mmc_abort_tuning);
+
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 0ce928b3ce90..e33cc748dcfe 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -176,6 +176,7 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
+extern int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
-- 
1.9.1

