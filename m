From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 2/3] mmc: sd: Allow calling sd mode switch with retries
Date: Thu, 10 Sep 2015 00:33:17 +0800
Message-ID: <1441816398-4330-2-git-send-email-yszhou4tech@gmail.com>
References: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34337 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbIIQhp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 12:37:45 -0400
Received: by padhy16 with SMTP id hy16so15026434pad.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2015 09:37:44 -0700 (PDT)
In-Reply-To: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Yousong Zhou <yszhou4tech@gmail.com>

This will allow retrying access mode switch to High-Speed in the
following commit.

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 drivers/mmc/core/core.c   |    4 ++++
 drivers/mmc/core/sd_ops.c |    5 +++--
 drivers/mmc/core/sd_ops.h |   10 ++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9ad73f3..e726bb1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -468,11 +468,13 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
+	struct mmc_data *data;
 
 	while (1) {
 		wait_for_completion(&mrq->completion);
 
 		cmd = mrq->cmd;
+		data = mrq->data;
 
 		/*
 		 * If host has timed out waiting for the sanitize
@@ -501,6 +503,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
 		cmd->error = 0;
+		if (data)
+			data->error = 0;
 		__mmc_start_request(host, mrq);
 	}
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 48d0c93..22bef3c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -304,8 +304,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	return 0;
 }
 
-int mmc_sd_switch(struct mmc_card *card, int mode, int group,
-	u8 value, u8 *resp)
+int __mmc_sd_switch(struct mmc_card *card, int mode, int group,
+	u8 value, u8 *resp, int retries)
 {
 	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
@@ -328,6 +328,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.retries = retries;
 
 	data.blksz = 64;
 	data.blocks = 1;
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index ffc2305..a53c51e 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -17,9 +17,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
 int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
-int mmc_sd_switch(struct mmc_card *card, int mode, int group,
-	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 
+int __mmc_sd_switch(struct mmc_card *card, int mode, int group,
+	u8 value, u8 *resp, int retries);
+static inline int mmc_sd_switch(struct mmc_card *card, int mode, int group,
+	u8 value, u8 *resp)
+{
+	return __mmc_sd_switch(card, mode, group, value, resp, 0);
+}
+
 #endif
 
-- 
1.7.10.4

