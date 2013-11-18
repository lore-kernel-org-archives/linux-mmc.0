From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: fix host release issue after discard operation
Date: Mon, 18 Nov 2013 20:24:14 +0900
Message-ID: <001801cee450$b6648280$232d8780$%jun@samsung.com>
References: <1382810624-17659-1-git-send-email-rjui@broadcom.com>
 <5277EA3A.4020001@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37395 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab3KRLYQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2013 06:24:16 -0500
In-reply-to: <5277EA3A.4020001@broadcom.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ray Jui' <rjui@broadcom.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Tue, November 05, 2013, Ray Jui wrote:
> On 10/26/2013 11:03 AM, Ray Jui wrote:
> > Under function mmc_blk_issue_rq, after an MMC discard operation,
> > the MMC request data structure may be freed in memory. Later in
> > the same function, the check of req->cmd_flags & MMC_REQ_SPECIAL_MASK
> > is dangerous and invalid. It causes the MMC host not to be released
> > when it should
Is commit message cut here?


> >
> > This patch fixes the issue by marking the special request down before
> > the discard/flush operation
> >
> > Reported by: Harold (SoonYeal) Yang <haroldsy@broadcom.com>
> > Signed-off-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >   drivers/mmc/card/block.c |    7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index 1a3163f..4e8212c 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -1959,6 +1959,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> >   	struct mmc_card *card = md->queue.card;
> >   	struct mmc_host *host = card->host;
> >   	unsigned long flags;
> > +	unsigned int cmd_flags = req ? req->cmd_flags : 0;
> >
> >   	if (req && !mq->mqrq_prev->req)
> >   		/* claim host only for the first request */
> > @@ -1974,7 +1975,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> >   	}
> >
> >   	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> > -	if (req && req->cmd_flags & REQ_DISCARD) {
> > +	if (cmd_flags & REQ_DISCARD) {
> >   		/* complete ongoing async transfer before issuing discard */
> >   		if (card->host->areq)
> >   			mmc_blk_issue_rw_rq(mq, NULL);
> > @@ -1983,7 +1984,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> >   			ret = mmc_blk_issue_secdiscard_rq(mq, req);
> >   		else
> >   			ret = mmc_blk_issue_discard_rq(mq, req);
> > -	} else if (req && req->cmd_flags & REQ_FLUSH) {
> > +	} else if (cmd_flags & REQ_FLUSH) {
> >   		/* complete ongoing async transfer before issuing flush */
> >   		if (card->host->areq)
> >   			mmc_blk_issue_rw_rq(mq, NULL);
> > @@ -1999,7 +2000,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> >
> >   out:
> >   	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
> > -	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
> > +	     (cmd_flags & MMC_REQ_SPECIAL_MASK))
> >   		/*
> >   		 * Release host when there are no more requests
> >   		 * and after special request(discard, flush) is done.
> >
> Hi Seungwon/Chris,
> 
> Have you got a chance to review the MMC discard patch V2? The patch v2
> makes changes from v1 based on Seungwon's review comments.

Adding linux-mmc. It has been omitted.
(+linux-mmc)

CC: Stable <stable@kernel.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

