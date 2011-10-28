From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH] mmc: support BKOPS feature for eMMC
Date: Fri, 28 Oct 2011 11:10:27 +0800
Message-ID: <5D8008F58939784290FAB48F549751984E263D0087@shsmsx502.ccr.corp.intel.com>
References: <4EA93C08.9030009@samsung.com>
	<5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
 <CAAgDR1NHu82t-Mub9HUSUyt-7c2os9gnGVfG2cX506b-8fzvqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30897 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab1J1DKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 23:10:50 -0400
In-Reply-To: <CAAgDR1NHu82t-Mub9HUSUyt-7c2os9gnGVfG2cX506b-8fzvqA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

> -----Original Message-----
> From: Sebastian Rasmussen [mailto:sebras@gmail.com]
> Sent: Friday, October 28, 2011 4:31 AM
> To: Dong, Chuanxiao
> Cc: Jaehoon Chung; linux-mmc; Chris Ball; Kyungmin Park; Hanumath Prasad
> Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
> 
> >> @@ -68,6 +68,7 @@ static int mmc_queue_thread(void *d)
> >>                               set_current_state(TASK_RUNNING);
> >>                               break;
> >>                       }
> >> +                     mmc_start_bkops(mq->card);
> >>                       up(&mq->thread_sem);
> >>                       schedule();
> >>                       down(&mq->thread_sem);
> > Maybe put mmc_interrupt_bkops(card) here is better, I think.
> 
> And the reason being that one already knows at this point that there
> is a new request to be processed and so BKOPS may just as well be
> interrupted at this point as later inside mq->issue_fn()?
Yes. To me, that is the reason. Since once schedule back here, means block driver will handle mmc request then. No matter what kind of request, that will need to use eMMC card. So I think here is an proper position to interrupt background operations.


> 
> >> +     /* send HPI to interrupt BKOPS. */
> >> +     err = mmc_send_hpi_cmd(card, &status);
> > What will be happened if eMMC card only support BKOPS but not support HPI?
> 
> For eMMC 4.41 this is actually a valid, but possibly unlikely, scenario.
> For eMMC 4.5 both BKOPS and HPI are mandatory as I read the spec.
> 
> As far as I can understand is that card->ext_csd.hpi_cmd == 0 (as
> card->ext_csd.hpi == 0 due toe EXT_CSD_HPI_FEATURES being 0). Inside
> mmc_send_hpi_cmd() this means that cmd.opcode not going to be either
> MMC_STOP_TRANSMISSION or MMC_SEND_STATUS but the command is still
> sent. As far as I understand the card will is that case not responde,
> but only set it's ILLEGAL_COMMAND bit in the status register and
> mmc_send_hpi_cmd() will be stuck in mmc_wait_for_cmd().
> 
> Basically you are trying to say that BKOPS should only be enabled if
> HPI is also supported and enabled. Unfortunately it may be the case
> that someone has enabled BKOPS through the one-time programmable
> BKOPS_EN for an eMMC which does not support HPI. If the MMC framework
> discovers such a card I suggest bailing out early, because such a card
> is obviously misconfigured.
Yes, basically that is what I mean. Seems you know a lot of about me ;).
Maybe if the eMMC card only support BKOPS, then mmc_interrupt_bkops can send CMD13 to poll the card status instead of sending HPI command directly.
Just as we mentioned below, BKOPS_EN is one time programmable, thus this bit should be programmed by eMMC device vendor or some product provider. They can choose whether to enable this from a device performance point of view. If there device have a performance improvement even without a HPI support, then go forward. If not, just leave this bit along.
So what driver does is only to do the right things. If he has HPI, using HPI to stop BKOPS. If not, he has to poll the card status.

Thanks
Chuanxiao

