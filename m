From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: fix a typo in a comment
Date: Fri, 3 Jan 2014 07:57:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1401030754540.27216@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaACG5K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jan 2014 01:57:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

This fixes an s/hand of/hand off/ typo in queue.c

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/card/queue.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 357bbc5..91955af 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -483,7 +483,7 @@ static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *mq,
 }
 
 /*
- * Prepare the sg list(s) to be handed of to the host driver
+ * Prepare the sg list(s) to be handed off to the host driver
  */
 unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 {
-- 
1.7.2.5

