From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/6] mmc: block: Resume multi-block reads after transient read errors.
Date: Fri, 22 Apr 2011 18:01:37 -0700
Message-ID: <1303520502-32171-2-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:35687 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab1DWBCB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 21:02:01 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0mQYQ001400
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 18:48:26 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3N12riB116610
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:02:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11rH6031866
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:54 -0600
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: David Ding <david.j.ding@motorola.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, Bentao Zou <bzou1@motorola.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>

From: David Ding <david.j.ding@motorola.com>

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
Signed-off-by: Bentao Zou <bzou1@motorola.com>
Signed-off-by: David Ding <david.j.ding@motorola.com>
Signed-off-by: San Mehat <san@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/card/block.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 61d233a..edac9ac 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -440,6 +440,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				continue;
 			}
 			status = get_card_status(card, req);
+		} else if (disable_multi == 1) {
+			disable_multi = 0;
 		}
 
 		if (brq.cmd.error) {
-- 
1.7.3.2.146.gca209

