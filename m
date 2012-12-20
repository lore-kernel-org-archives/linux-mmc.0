From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RESEND PATCH v4] mmc: fix async request mechanism for sequential
 read scenarios
Date: Thu, 20 Dec 2012 16:39:52 +0900
Message-ID: <003901cdde85$32a9d520$97fd7f60$%jun@samsung.com>
References: <n@samsung.com>
 <1355149430-17496-1-git-send-email-kdorfman@codeaurora.org>
 <001c01cddc51$c9cc3f00$5d64bd00$%jun@samsung.com>
 <50D09324.1000502@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29261 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab2LTHjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Dec 2012 02:39:55 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFB008XJJYEG5H0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Dec 2012 16:39:52 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFB000DXJYG9830@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Dec 2012 16:39:52 +0900 (KST)
In-reply-to: <50D09324.1000502@codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Konstantin Dorfman' <kdorfman@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, 'Per Forlin' <per.lkml@gmail.com>

On Wednesday, December 19, 2012, Konstantin Dorfman wrote:
> On 12/17/2012 02:26 PM, Seungwon Jeon wrote:
> > Hi, Konstantin.
> >
> > I added comments more below.
> I've answered below.
> >
> > On Wednesday, December 12, 2012, Seungwon Jeon wrote:
> >> On Monday, December 10, 2012, Konstantin Dorfman wrote:
> >>>   /*
> >>>    * Prepare a MMC request. This just filters out odd stuff.
> >>> @@ -63,11 +62,20 @@ static int mmc_queue_thread(void *d)
> >>>   		set_current_state(TASK_INTERRUPTIBLE);
> >>>   		req = blk_fetch_request(q);
> >>>   		mq->mqrq_cur->req = req;
> >>> +		if (!req && mq->mqrq_prev->req &&
> >>> +			!(mq->mqrq_prev->req->cmd_flags & REQ_FLUSH) &&
> >>> +			!(mq->mqrq_prev->req->cmd_flags & REQ_DISCARD))
> >>> +			mq->card->host->context_info.is_waiting_last_req = true;
> >>> +
> > Unlike normal R/W request,  request for discard/flush will be finished synchronously.
> > That means blk_end_request is called with 1's cycle of 'issue_fn' and request will be freed in block
> layer.
> > Currently 'mqrq_prev->req' is keeping these request and is used above condition.
> > Maybe, same area may be reallocated for normal R/W request after discard/flush is finished.
> > But we still expect discard or flush is saved in 'mq->mqrq_prev->req'.
> > I wonder that 'mq->mqrq_prev->req' indicates the valid area in all case.
> 
> It seems like a bug causing unnecessary call to `issue_fn(mq, req)` even
> when `req` is NULL, because 'mq->mqrq_prev->req' that holds old control
> request is not NULL. It is not directly related to the patch, it could
> be fixed by cleaning 'mq->mqrq_prev->req' (for control requests). I
> think this should be done in separate patch.
Yes, it's different issue. I've already checked it.
But I'm seeing whether cmd_flag of 'mq->mqrq_prev->req' is valid or not after blk_end_request is completed.
As it's mentioned above, special requests are completed at once.
> 
> Also this action (context_info.is_waiting_last_req = true;) could be
> moved into card/block.c: mmc_blk_issue_rq() function just for the case,
> when request is data request. Do you think it will be cleaner?
Wherever it is moved, we need other condition to decide whether last data transfer is ongoing.
'card->host->areq' could be good condition.

> >>> @@ -2086,6 +2186,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >>>
> >>>   	mmc_send_if_cond(host, host->ocr_avail);
> >>>
> >>> +	spin_lock_init(&host->context_info.lock);
> >>> +	host->context_info.is_new_req = false;
> >>> +	host->context_info.is_done_rcv = false;
> >>> +	host->context_info.is_waiting_last_req = false;
> >>> +	init_waitqueue_head(&host->context_info.wait);
> >>> +
> >> This path may be retired when mmc_rescan_try_freq is failed.
> >> How about putting these in mmc_add_card(mmc/core/bus.c)
> >> <Quote>
> >>          ret = device_add(&card->dev);
> >>          if (ret)
> >>                  return ret;
> >> -> Here seems good point.
> It is ok to put the initialization just before calling to "device_add",
> because data requests starting to arrive immediately after device_add().
> I've tested this already and will post soon.
Yes, it's reasonable.

Thanks,
Seungwon Jeon
> >>
> >> 	mmc_card_set_present(card);
> >> </Quote>
> >> Thanks,
> >> Seungwon Jeon

