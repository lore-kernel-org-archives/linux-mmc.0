From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Tue, 6 Dec 2011 01:03:40 +0900
Message-ID: <CAELcNGQ0R63675epEQtULmyB_7So1piMbR4yvXE1iL=PV--2Ng@mail.gmail.com>
References: <4EC45A39.5030706@samsung.com>
	<051ff64068f04c729d6f6a32c25db5cc.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42530 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1LEQDl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 11:03:41 -0500
Received: by eeaq14 with SMTP id q14so2013041eea.19
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2011 08:03:40 -0800 (PST)
In-Reply-To: <051ff64068f04c729d6f6a32c25db5cc.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Konstantin.

Thanks for your comment..
I will consider your opinion and send path-v4...then also let me know
more comments :)

Best Regards,
Jaehoon Chung

2011/12/2 Konstantin Dorfman <kdorfman@codeaurora.org>:
> Hello Jaehoon,
> After applying your patch and debugging it for some time,
> I want to share my results and suggests some changes to the patch.
> See comments below:
>
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> + =A0 =A0 int err;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 BUG_ON(!card);
>> + =A0 =A0 if ((!card->ext_csd.bkops_en) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(card->host->caps2 & MMC_=
CAP2_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If card is already doing bkops or need for
>> + =A0 =A0 =A0* bkops flag is not set, then do nothing just
>> + =A0 =A0 =A0* return
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mmc_card_doing_bkops(card)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_bkops(ca=
rd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 mmc_claim_host(card->host);
>> + =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1, 0)=
;
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("error %d starting bkops\n", er=
r);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>> + =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 mmc_card_set_doing_bkops(card);
>
> mmc_switch() will use CMD6 with MMC_RSP_R1B flag (see mmc_switch()
> implementation), this flag
> causes mmc controler to wait until busy line (DAT0) released:
>
> ----from eMMC v4.5 protocol----
> 6.12 Responses
> ...
> R1b is identical to R1 with an optional busy signal transmitted on th=
e
> data line DAT0.
> The Device may become busy after receiving these commands based on it=
s
> state prior to the command reception.
> ...
> 7.4.56 BKOPS_START [164]
> Writing any value to this field shall manually start background
> operations. Device shall stay busy till no more
> background operations are needed.
> ----cut----
>
> This means, that mmc_switch() returns only after BKOPS finished by ca=
rd
> and there is no point
> in setting mmc_card_set_doing_bkops(card). Also, HPI command send to =
the
> card in order to interrupt BKOPS in mmc_queue_thread()
> will never actually interrupt BKOPS. To resolve this I suggest follow=
ing:
>
> 1) =A0Define two variants of mmc_switch(...,wait_flag) for BKOPS, whe=
re
> =A0 =A0 =A0wait_flag is true sends CMD6 with MMC_RSP_R1b flag as it h=
appens now.
> =A0 =A0 =A0wait_flag is false sends CMD6 with MMC_RSP_R1 flag (the on=
ly
> difference is MMC_RSP_BUSY bit),
> =A0 =A0so the flow continues immediately after CMD response arrives a=
nd will
> not wait for busy line release.
>
> 2) The only situation when we want to use synchronous mmc_switch(...,
> true) is URGENT bit arrives from card, in mmc_blk_issue_rw_rq().
> =A0 There is no point in waiting for idle time check in mmc_queue_thr=
ead(),
> host should start synchronous BKOPS immediately.
>
> 3) When in idle (no requests to issue) we can read BKOPS_STATUS[246] =
from
> card and depending on state decide:
> =A0 =A0 0: nothing to do go idle
> =A0 =A0 1: start BKOPS with no wait for busy line ( mmc_switch(..., f=
alse))
> and mmc_set_doing_bkops()
> =A0 =A0 3&2: start synchronous BKOPS
>
> Let me describe this by pseudo-code below:
>
> queue.c: =A0mmc_queue_thread():
> ...
> req =3D blk_fetch_request(q)
> if(req =3D=3D NULL) {
> =A0state =3D read_bkops_state(); // read BKOPS_STATUS[246] from card
> =A0switch(state) {
> =A0 =A0case 0:
> =A0 =A0 =A0go_idle()
> =A0 =A0 =A0break;
> =A0 =A0case 1:
> =A0 =A0 =A0start_asynch_bkops() =A0// send CMD6 with no wait for busy
> =A0 =A0 =A0mmc_set_doing_bkops() // update flag
> =A0 =A0 =A0break;
> =A0 =A0case 2:
> =A0 =A0case 3:
> =A0 =A0 =A0start_synch_bkops() // start CMD6 with wait for busy
> =A0 =A0 =A0break;
> =A0 =A0default:
> =A0 =A0 =A0go_idle()
> =A0}
> } else {
> =A0 if( mmc_doing_bkops() ) {
> =A0 =A0 mmc_send_hpi()
> =A0 =A0 mmc_clear_doing_bkops()
> =A0 }
> =A0 issue(req)
> }
>
> mmc\card\block.c: mmc_blk_issue_rw_rq()
> ...
> =A0if ( (mmc_is_exception_event(card,EXT_CSD_URGENT_BKOPS)) {
> =A0 =A0 =A0 =A0start_synch_bkops() // start CMD6 with wait for busy
> =A0}
> ...
> -----------------------end of pseudo code-------------
>
> Does this make sense?
> Thanks, Kostya
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
