Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BCC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AE060200
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCSaI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:30:08 -0400
Received: from smtp2.axis.com ([195.60.68.18]:1441 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhKCSaI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Nov 2021 14:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635964051;
  x=1667500051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9YrRyKpujI/sKECti+lyUtNiQbGA350KriqqTVSP5us=;
  b=J+wBU8S7SXQ60ZONSp2mjEtv6vfREYOgTAAzZtQ1xKjnVYqFn8B6hJnj
   AF2rFgpr0/Pd0CNofRjOtKrI6iYtAzd7tnkoIxzSndjRp3wG3pKvi+Yuu
   uOJE3fmvMmRTzooy4OYQoU7ZDLjvQiFm9GVr6c+aBSJ1ipZP4gUVyY/4f
   DW81WBAaQAt09fjYw2vHNk6qcO/0mGcPCBXOpmV3VUkTHewnuE5fB8/6Z
   xiQPyRwdtgpk02hjyies+qfe185bu4tiC5KNJtgdr62CzgCFk4hGkv9ZY
   6DiqWfBq11U/Nm7aUO/aD4It6rVyAdMj/7P2kew5yggsWuajNngXq03VI
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] mmc: dw_mmc: Avoid hung state if GEN_CMD transfer fails
Date:   Wed, 3 Nov 2021 19:27:16 +0100
Message-ID: <20211103182716.28419-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we get a data error during a block transfer command, a stop command
(CMD12) is normally initiated. But this does not work for the general
command (CMD56), but instead the action is ignored and an uninitialized
command struct is used for the stop action, with unexpected result.

Fix this by adding a check for GEN_CMD when preparing stop transmission.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6578cc64ae9e..988c32e93e03 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -335,7 +335,8 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	    cmdr == MMC_WRITE_BLOCK ||
 	    cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
 	    cmdr == MMC_SEND_TUNING_BLOCK ||
-	    cmdr == MMC_SEND_TUNING_BLOCK_HS200) {
+	    cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
+	    cmdr == MMC_GEN_CMD) {
 		stop->opcode = MMC_STOP_TRANSMISSION;
 		stop->arg = 0;
 		stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
-- 
2.20.1

