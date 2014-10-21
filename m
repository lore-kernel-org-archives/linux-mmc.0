From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 14/15] mmc: core: Don't handle buffers on stack while fetching CXD registers
Date: Tue, 21 Oct 2014 19:19:12 +0200
Message-ID: <1413911953-19012-15-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:44325 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaJURTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:48 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so1457782lbv.12
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:46 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Due to previous patches, all callers of mmc_send_cxd_data() now
allocates their buffers from the heap. This enables us to simplify
mmc_send_cxd_data() by removing the support of handling buffers, which
are allocated from the stack.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 9a6181b..e04008f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -264,20 +264,6 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
-	void *data_buf;
-	int is_on_stack;
-
-	is_on_stack = object_is_on_stack(buf);
-	if (is_on_stack) {
-		/*
-		 * dma onto stack is unsafe/nonportable, but callers to this
-		 * routine normally provide temporary on-stack buffers ...
-		 */
-		data_buf = kmalloc(len, GFP_KERNEL);
-		if (!data_buf)
-			return -ENOMEM;
-	} else
-		data_buf = buf;
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -298,7 +284,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, data_buf, len);
+	sg_init_one(&sg, buf, len);
 
 	if (opcode == MMC_SEND_CSD || opcode == MMC_SEND_CID) {
 		/*
@@ -312,11 +298,6 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 
 	mmc_wait_for_req(host, &mrq);
 
-	if (is_on_stack) {
-		memcpy(buf, data_buf, len);
-		kfree(data_buf);
-	}
-
 	if (cmd.error)
 		return cmd.error;
 	if (data.error)
-- 
1.9.1

