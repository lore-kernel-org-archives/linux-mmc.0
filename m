From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: check correct variable after kzalloc()
Date: Tue, 12 Feb 2013 15:24:54 +0300
Message-ID: <20130212122454.GC19045@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27459 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103Ab3BLMZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 07:25:17 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, kbuild@01.org, kernel-janitors@vger.kernel.org

There is a typo here so we check "mqrq_cur->packed" instead of
"mqrq_prev->packed".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c0d1315..97a848b 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -378,7 +378,7 @@ int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
 	}
 
 	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
-	if (!mqrq_cur->packed) {
+	if (!mqrq_prev->packed) {
 		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
 			   mmc_card_name(card));
 		kfree(mqrq_cur->packed);
