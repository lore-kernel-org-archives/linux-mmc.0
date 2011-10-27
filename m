From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 22:31:21 +0200
Message-ID: <CAAgDR1NHu82t-Mub9HUSUyt-7c2os9gnGVfG2cX506b-8fzvqA@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56624 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab1J0UbW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 16:31:22 -0400
Received: by ywm3 with SMTP id 3so3013434ywm.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 13:31:21 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

>> @@ -68,6 +68,7 @@ static int mmc_queue_thread(void *d)
>>                               set_current_state(TASK_RUNNING);
>>                               break;
>>                       }
>> +                     mmc_start_bkops(mq->card);
>>                       up(&mq->thread_sem);
>>                       schedule();
>>                       down(&mq->thread_sem);
> Maybe put mmc_interrupt_bkops(card) here is better, I think.

And the reason being that one already knows at this point that there
is a new request to be processed and so BKOPS may just as well be
interrupted at this point as later inside mq->issue_fn()?

>> +     /* send HPI to interrupt BKOPS. */
>> +     err = mmc_send_hpi_cmd(card, &status);
> What will be happened if eMMC card only support BKOPS but not support HPI?

For eMMC 4.41 this is actually a valid, but possibly unlikely, scenario.
For eMMC 4.5 both BKOPS and HPI are mandatory as I read the spec.

As far as I can understand is that card->ext_csd.hpi_cmd == 0 (as
card->ext_csd.hpi == 0 due toe EXT_CSD_HPI_FEATURES being 0). Inside
mmc_send_hpi_cmd() this means that cmd.opcode not going to be either
MMC_STOP_TRANSMISSION or MMC_SEND_STATUS but the command is still
sent. As far as I understand the card will is that case not responde,
but only set it's ILLEGAL_COMMAND bit in the status register and
mmc_send_hpi_cmd() will be stuck in mmc_wait_for_cmd().

Basically you are trying to say that BKOPS should only be enabled if
HPI is also supported and enabled. Unfortunately it may be the case
that someone has enabled BKOPS through the one-time programmable
BKOPS_EN for an eMMC which does not support HPI. If the MMC framework
discovers such a card I suggest bailing out early, because such a card
is obviously misconfigured.

>> +      * enable BKOPS feature (if supported)
>> +      */
>> +     if (card->ext_csd.bkops) {
>> +             err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                     EXT_CSD_BKOPS_EN, 1, 0);
> Just found this bit is one time programmable, so that is to say this bit is not suitable for driver to change.

Agreed, my suggestion was to read BKOPS_EN and if BKOPS then use that
to determine if the framework should call mmc_start_bkops().

 / Sebastian
