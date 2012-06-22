From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v5] mmc: core: Fix the HPI execution sequence
Date: Fri, 22 Jun 2012 11:42:36 +0530
Message-ID: <1340345556-13820-1-git-send-email-svenkatr@ti.com>
References: <003a01cd4fc3$c5e21ec0$51a65c40$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45800 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761316Ab2FVGNR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jun 2012 02:13:17 -0400
In-Reply-To: <003a01cd4fc3$c5e21ec0$51a65c40$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, subhashj@codeaurora.org, Venkatraman S <svenkatr@ti.com>, Kostya <kdorfman@codeaurora.org>

mmc_execute_hpi should send the HPI command only
once, and only if the card is in PRG state.

According to eMMC spec, the command's completion time is
not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
defined to begin at the end of sending the command itself.

Specify the default timeout for the actual sending of HPI
command, and then use OUT_OF_INTERRUPT_TIME to wait for
the transition out of PRG state.

Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
CC: Kostya <kdorfman@codeaurora.org>
---
v4->v5: Start time calculation after the HPI command has been sent

v3->v4: Fix coding style issues as suggested by Chris Ball.
       Use time_after() for safe time diff calculations as
        suggested by Subash Jadavani.

 drivers/mmc/core/core.c    |   55 ++++++++++++++++++++++++++------------------
 drivers/mmc/core/mmc_ops.c |    1 -
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 80ec427..f11de40 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 {
 	int err;
 	u32 status;
+	unsigned long prg_wait;
 
 	BUG_ON(!card);
 
@@ -419,30 +420,38 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 		goto out;
 	}
 
-	/*
-	 * If the card status is in PRG-state, we can send the HPI command.
-	 */
-	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
-		do {
-			/*
-			 * We don't know when the HPI command will finish
-			 * processing, so we need to resend HPI until out
-			 * of prg-state, and keep checking the card status
-			 * with SEND_STATUS.  If a timeout error occurs when
-			 * sending the HPI command, we are already out of
-			 * prg-state.
-			 */
-			err = mmc_send_hpi_cmd(card, &status);
-			if (err)
-				pr_debug("%s: abort HPI (%d error)\n",
-					 mmc_hostname(card->host), err);
+	switch (R1_CURRENT_STATE(status)) {
+	case R1_STATE_IDLE:
+	case R1_STATE_READY:
+	case R1_STATE_STBY:
+		/*
+		 * In idle states, HPI is not needed and the caller
+		 * can issue the next intended command immediately
+		 */
+		goto out;
+	case R1_STATE_PRG:
+		break;
+	default:
+		/* In all other states, it's illegal to issue HPI */
+		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
+			mmc_hostname(card->host), R1_CURRENT_STATE(status));
+		err = -EINVAL;
+		goto out;
+	}
 
-			err = mmc_send_status(card, &status);
-			if (err)
-				break;
-		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
-	} else
-		pr_debug("%s: Left prg-state\n", mmc_hostname(card->host));
+	err = mmc_send_hpi_cmd(card, &status);
+	if (err)
+		goto out;
+
+	prg_wait = jiffies + msecs_to_jiffies(card->ext_csd.out_of_int_time);
+	do {
+		err = mmc_send_status(card, &status);
+
+		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
+			break;
+		if (time_after(jiffies, prg_wait))
+			err = -ETIMEDOUT;
+	} while (!err);
 
 out:
 	mmc_release_host(card->host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 69370f4..0ed2cc5 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 
 	cmd.opcode = opcode;
 	cmd.arg = card->rca << 16 | 1;
-	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
-- 
1.7.10.rc2

