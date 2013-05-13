From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: [RFC/PATCH] mmc: core: fix HPI polling timeout
Date: Mon, 13 May 2013 11:28:42 +0300
Message-ID: <1368433722-17503-1-git-send-email-kdorfman@codeaurora.org>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:63751 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3EMIbl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 04:31:41 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: sthumma@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, merez@codeaurora.org, Konstantin Dorfman <kdorfman@codeaurora.org>

Out of CPU time for the MMC context included into measured timeout. System
under heavy load will easily exceed out_of_int_time (typically 20 ms).
In this case real card status checked again and error reported for wrong
card state only.

Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c40396f..4d06ada 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -630,8 +630,11 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 
 		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
 			break;
-		if (time_after(jiffies, prg_wait))
-			err = -ETIMEDOUT;
+		if (time_after(jiffies, prg_wait)) {
+			err = mmc_send_status(card, &status);
+			if (!err && R1_CURRENT_STATE(status) != R1_STATE_TRAN)
+				err = -ETIMEDOUT;
+		}
 	} while (!err);
 
 out:
-- 
1.7.6
--
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

