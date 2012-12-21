From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: queue: exclude asynchronous transfer for special
 request
Date: Fri, 21 Dec 2012 14:36:34 +0900
Message-ID: <001801cddf3d$23b78040$6b2680c0$%jun@samsung.com>
References: <003c01cdde9c$95883ad0$c098b070$%jun@samsung.com>
 <50D3263F.6050407@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57776 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2LUFg6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 00:36:58 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFD00A0J8W9XNN0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 21 Dec 2012 14:36:35 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFD00DZ88WYGW60@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 21 Dec 2012 14:36:35 +0900 (KST)
In-reply-to: <50D3263F.6050407@codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Konstantin Dorfman' <kdorfman@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@linaro.org>

On Thursday, December 20, 2012, Konstantin Dorfman wrote:
> Hello Jeon,
> 
> 
> On 12/20/2012 12:27 PM, Seungwon Jeon wrote:
> > Unlike normal r/w request, special requests(discard, flush)
> > is finished with a one-time issue_fn. Request change to
> > mqrq_prev makes unnecessary call.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >   drivers/mmc/card/queue.c |    8 ++++++++
> >   1 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> > index fadf52e..a71db7a 100644
> > --- a/drivers/mmc/card/queue.c
> > +++ b/drivers/mmc/card/queue.c
> > @@ -58,6 +58,7 @@ static int mmc_queue_thread(void *d)
> >   	do {
> >   		struct request *req = NULL;
> >   		struct mmc_queue_req *tmp;
> > +		unsigned int cmd_flags = 0;
> >
> >   		spin_lock_irq(q->queue_lock);
> >   		set_current_state(TASK_INTERRUPTIBLE);
> > @@ -67,12 +68,19 @@ static int mmc_queue_thread(void *d)
> >
> >   		if (req || mq->mqrq_prev->req) {
> >   			set_current_state(TASK_RUNNING);
> > +			cmd_flags = req ? req->cmd_flags : 0;
> >   			mq->issue_fn(mq, req);
> >
> >   			/*
> >   			 * Current request becomes previous request
> >   			 * and vice versa.
> > +			 * In case of special requests, current request
> > +			 * has been finished. Do not remain it to previous
> > +			 * request.
> >   			 */
> > +			if (cmd_flags & REQ_DISCARD || cmd_flags & REQ_FLUSH)
> > +				mq->mqrq_cur->req = NULL;
> > +
> >   			mq->mqrq_prev->brq.mrq.data = NULL;
> >   			mq->mqrq_prev->req = NULL;
> >   			tmp = mq->mqrq_prev;
> >
> It is better to define control mask, REQ_CONTROL_MASK, which will
> include all control/special requests.
Agree, it's better.

> 
> Then, when additional request will be added, there will be no need to
> change here, only update the mask.
> 
> Another option - to clean mq->mqrq_cur->req immediately after executing
> a special request in mmc_blk_issue_rq().
Yes, I also approached it with the same idea at the beginning.
But it seems that 'queue.c' has a role of management of two requests, 
while 'block.c' just uses these request. It makes sense?

Thanks,
Seungwon Jeon
> 
> 
> --
> Konstantin Dorfman,
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
> Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

