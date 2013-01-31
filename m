From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: fix the aysync mechanism when card removed
Date: Thu, 31 Jan 2013 19:48:43 +0900
Message-ID: <001f01cdffa0$8a01b3b0$9e051b10$%jun@samsung.com>
References: <50FE838C.5010709@samsung.com> <510A2E69.6000608@codeaurora.org>
 <510A3D69.5080309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18723 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3AaKsq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 05:48:46 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHH00KZIKP3PF80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 19:48:44 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHH00E0ZKP7NX00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 19:48:43 +0900 (KST)
In-reply-to: <510A3D69.5080309@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Subhash Jadavani' <subhashj@codeaurora.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Per FORLIN' <per.forlin@stericsson.com>, 'Maya Erez' <merez@codeaurora.org>

On Thursday, January 31, 2013, Jaehoon Chung wrote:
> On 01/31/2013 05:42 PM, Subhash Jadavani wrote:
> > On 1/22/2013 5:48 PM, Jaehoon Chung wrote:
> >> When card removed, then didn't complete the previously data.
> >> (It didn't wakeup any interrupt.)
> >> If card is removed, then we can assume to complete the previously data.
> >> And wakeup the interrupt for wait_event of data.
> >>
> >> This problem is produced when sd-card is removed.(Sd-card is running some operation)
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> >> ---
> >>   drivers/mmc/core/core.c |   31 ++++++++++++++++++++-----------
> >>   1 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 8b3a122..bc1d627 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -515,17 +515,26 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> >>           mmc_pre_req(host, areq->mrq, !host->areq);
> >>         if (host->areq) {
> >> -            err = mmc_wait_for_data_req_done(host, host->areq->mrq,
> >> -                    areq);
> >> -            if (err == MMC_BLK_NEW_REQUEST) {
> >> -                if (error)
> >> -                    *error = err;
> >> -                /*
> >> -                 * The previous request was not completed,
> >> -                 * nothing to return
> >> -                 */
> >> -                return NULL;
> >> -            }
> >> +        err = mmc_wait_for_data_req_done(host, host->areq->mrq,
> >> +                areq);
> >> +        if (err == MMC_BLK_NEW_REQUEST) {
> >> +            if (error)
> >> +                *error = err;
> >> +            /*
> >> +             * The previous request was not completed,
> >> +             * nothing to return
> >> +             */
> >> +            return NULL;
> >> +        } else if (err == MMC_BLK_NOMEDIUM && areq) {
> >> +            struct mmc_context_info *ctnx = &host->context_info;
> >> +            /*
> >> +             * If crad is removed,
> >> +             * then we didn't wait for data completed.
> >> +             * Assume that data-recieve done.
> >> +             */
> >> +            ctnx->is_done_rcv = true;
> >> +            wake_up_interruptible(&ctnx->wait);
> >
> > Can you please explain more on what exactly we are trying to do here (may be you can list down the
> call flow)? I am not sure if i understood this correctly. But why would you need to wakeup the thread
> here? We are here because thread is already woken up. mmc_wait_for_data_req_done() would return only
> if either the new request is received or the currently running request on controller is completed.
> This problem is produced when card is removed and running some operation.
> If card is removed, mmc_wait_for_data_req_done() is returned error, right?
> But if there was async request and running async operation, then maybe run mmc_start_request() with
> areq.
> controller is waiting "_for_req_data_done_" for areq.
> 
> If request is host->areq.process is running at this time.
> But if request is areq(prepared request), then mmc_wait_for_data_req_done should be pending.
> and system is dead-lock.
I also found this problem with sdcard.
I think it can be solved easily. Did you see the following patch?
[PATCH 1/2] mmc: core: fix permanent sleep of mmcqd during card removal
We may just get the hint from __mmc_start_req function.

Thanks,
Seungwon Jeon
> 
> Best Regards,
> Jaehoon Chung
> 
> >
> > Regards,
> > Subhash
> >
> >> +        }
> >>           /*
> >>            * Check BKOPS urgency for each R1 response
> >>            */
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

