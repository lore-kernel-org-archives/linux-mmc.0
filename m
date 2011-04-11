From: Andrei Warkentin <andreiw@motorola.com>
Subject: [patchv4 1/2] MMC: block.c cleanup for host claim/release.
Date: Mon, 11 Apr 2011 18:10:24 -0500
Message-ID: <1302563425-17168-1-git-send-email-andreiw@motorola.com>
References: <BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:49318 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1DKWbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 18:31:23 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BMTYWV009961
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:29:35 -0400 (EDT)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3BMTYMo009951
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 18:29:34 -0400 (EDT)
Received: by yib12 with SMTP id 12so4203219yib.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 15:31:21 -0700 (PDT)
In-Reply-To: <BANLkTinHodYLMMA0=JJ1z_kX8jQm1P=akA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Move host claim/release into mmc_blk_issue_rq.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 91a6767..3e9082b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -273,8 +273,6 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -294,8 +292,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -307,8 +303,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_secure_erase_trim(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -330,8 +324,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -402,8 +394,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		(rq_data_dir(req) == WRITE) &&
 		REL_WRITES_SUPPORTED(card);
 
-	mmc_claim_host(card->host);
-
 	do {
 		struct mmc_command cmd;
 		u32 readcmd, writecmd, status = 0;
@@ -589,8 +579,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	} while (ret);
 
-	mmc_release_host(card->host);
-
 	return 1;
 
  cmd_err:
@@ -617,8 +605,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	}
 
-	mmc_release_host(card->host);
-
 	spin_lock_irq(&md->lock);
 	while (ret)
 		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
@@ -629,16 +615,25 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
+	int ret;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+
+	mmc_claim_host(card->host);
+
 	if (req->cmd_flags & REQ_DISCARD) {
 		if (req->cmd_flags & REQ_SECURE)
-			return mmc_blk_issue_secdiscard_rq(mq, req);
+			ret = mmc_blk_issue_secdiscard_rq(mq, req);
 		else
-			return mmc_blk_issue_discard_rq(mq, req);
+			ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (req->cmd_flags & REQ_FLUSH) {
-		return mmc_blk_issue_flush(mq, req);
+		ret = mmc_blk_issue_flush(mq, req);
 	} else {
-		return mmc_blk_issue_rw_rq(mq, req);
+		ret = mmc_blk_issue_rw_rq(mq, req);
 	}
+
+	mmc_release_host(card->host);
+	return ret;
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
-- 
1.7.0.4

