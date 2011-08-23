From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/2] mmc: queue: declare mmc_alloc_sg as static
Date: Tue, 23 Aug 2011 21:16:02 +0530
Message-ID: <1314114363-6767-2-git-send-email-svenkatr@ti.com>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1HWPqf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 11:46:35 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7NFkZ2F009483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:35 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7NFkZV1001699
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:35 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7NFkYPp028644
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:34 -0500 (CDT)
In-Reply-To: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

Fix the sparse warning "drivers/mmc/card/queue.c:111:20: warning:
 symbol 'mmc_alloc_sg' was not declared. Should it be static?"

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/card/queue.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 45fb362..5196312 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -108,7 +108,7 @@ static void mmc_request(struct request_queue *q)
 		wake_up_process(mq->thread);
 }
 
-struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
+static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
 
-- 
1.7.1

