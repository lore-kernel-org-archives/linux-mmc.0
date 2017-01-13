From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 12/15] mmc: vub300: Don't use mmc_card_present() when validating for inserted card
Date: Fri, 13 Jan 2017 14:14:13 +0100
Message-ID: <1484313256-25993-13-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36051 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdAMNPQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:15:16 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so33628959lff.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 05:15:15 -0800 (PST)
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_card_present() function helps the mmc core to track an internal
state of the card device. More importantly, it's not intended to be used by
mmc host drivers to check for an inserted card. Therefore, let's stop using
it and instead rely on checking for a valid pointer to a struct mmc_card,
as it should be good enough.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/vub300.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 21ea776..c061e7c 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -726,8 +726,7 @@ static void vub300_deadwork_thread(struct work_struct *work)
 		 */
 	} else if (vub300->card_present) {
 		check_vub300_port_status(vub300);
-	} else if (vub300->mmc && vub300->mmc->card &&
-		   mmc_card_present(vub300->mmc->card)) {
+	} else if (vub300->mmc && vub300->mmc->card) {
 		/*
 		 * the MMC core must not have responded
 		 * to the previous indication - lets
@@ -1754,8 +1753,7 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 		int data_length;
 		mutex_lock(&vub300->cmd_mutex);
 		init_completion(&vub300->command_complete);
-		if (likely(vub300->vub_name[0]) || !vub300->mmc->card ||
-		    !mmc_card_present(vub300->mmc->card)) {
+		if (likely(vub300->vub_name[0]) || !vub300->mmc->card) {
 			/*
 			 * the name of the EMPTY Pseudo firmware file
 			 * is used as a flag to indicate that the file
-- 
1.9.1

