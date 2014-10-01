From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 3/5] mmc: core: Initialize SET_BLOCK_COUNT request fields
Date: Wed, 1 Oct 2014 07:14:09 -0500
Message-ID: <1412165651-2652-4-git-send-email-andrew_gabbasov@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62100 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMPE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:15:04 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIoB-0001wQ-Ca from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:15:03 -0700
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Some request fields are initialized just before request processing
for sanity purposes. This is done for command, data, and stop parts
of the request, but not for sbc (set block count) part. Add such
initialization for that part too.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d03a080..b8e57db 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -214,6 +214,10 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	mrq->cmd->error = 0;
 	mrq->cmd->mrq = mrq;
+	if (mrq->sbc) {
+		mrq->sbc->error = 0;
+		mrq->sbc->mrq = mrq;
+	}
 	if (mrq->data) {
 		BUG_ON(mrq->data->blksz > host->max_blk_size);
 		BUG_ON(mrq->data->blocks > host->max_blk_count);
-- 
2.1.0

