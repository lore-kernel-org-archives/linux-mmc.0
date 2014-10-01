From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 4/5] mmc: core: Add debug message for SET_BLOCK_COUNT result
Date: Wed, 1 Oct 2014 07:14:10 -0500
Message-ID: <1412165651-2652-5-git-send-email-andrew_gabbasov@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62101 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMPG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:15:06 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIoD-0001wU-Bq from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:15:05 -0700
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The debug messages with commands execution results, that are printed
after processing the request, do not include results of sbc (set block count)
part of request. Add the debug message for that part too.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8e57db..162bcd3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -149,6 +149,14 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		led_trigger_event(host->led, LED_OFF);
 
+		if (mrq->sbc) {
+			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
+				mmc_hostname(host), mrq->sbc->opcode,
+				mrq->sbc->error,
+				mrq->sbc->resp[0], mrq->sbc->resp[1],
+				mrq->sbc->resp[2], mrq->sbc->resp[3]);
+		}
+
 		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
 			mmc_hostname(host), cmd->opcode, err,
 			cmd->resp[0], cmd->resp[1],
-- 
2.1.0

