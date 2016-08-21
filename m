From: Hans de Goede <hdegoede@redhat.com>
Subject: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed), related
 to: "drivers: use req op accessor" ?
Date: Sun, 21 Aug 2016 17:15:43 +0200
Message-ID: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbcHUPWK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 21 Aug 2016 11:22:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Mike Christie <mchristi@redhat.com>, Jens Axboe <axboe@fb.com>, regressions@leemhuis.info
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi All,

With 4.8-rc1 I'm seeing WARN_ON(!host->claimed) triggering in both
mmc_start_request() as well as in mmc_release_host(). The first
indicating that we're executing mmc commands without doing
mmc_claim_host() and the second one indicating that we're
releasing the host without having claimed it first.

The backtraces all point to mmc_blk_issue_rq(). I've done
a very naive hack / workaround:

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2151,9 +2151,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
  	struct mmc_host *host = card->host;
  	unsigned long flags;

-	if (req && !mq->mqrq_prev->req)
-		/* claim host only for the first request */
-		mmc_get_card(card);
+	mmc_get_card(card);

  	ret = mmc_blk_part_switch(card, md);
  	if (ret) {
@@ -2190,15 +2188,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
  	}

  out:
-	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
-	    mmc_req_is_special(req))
-		/*
-		 * Release host when there are no more requests
-		 * and after special request(discard, flush) is done.
-		 * In case sepecial request, there is no reentry to
-		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
-		 */
-		mmc_put_card(card);
+	mmc_put_card(card);
+
  	return ret;
  }


Which fixes this, further pointing to the somewhat magical claim / release
code in mmc_blk_issue_rq() being the culprit.

Looking at recent commits these 2 stand out as possible causes of this:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c2df40dfb8c015211ec55f4b1dd0587f875c7b34
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a5e02ced11e22ecd9da3d6710afe15bcfee1d10

I've the feeling that one of these is making mmc_blk_issue_rq() not claiming
the host while it should do so ...

Maybe instead of the magic at the top we need a simple bool to check
if the host is already claimed by the mmc_queue code ?

I can reproduce the WARN_ON's pretty much at will (running 4.8-rc1 on
Allwinner ARM devices with rootfs on a sdcard), let me know if you've
a fix you want me to test.

Regards,

Hans


p.s.

Besides the WARN_ON triggering another side-effect of this is that the
machines will hang at poweroff.

