Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FDC07E9D
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiI0MOX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiI0MOO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:14:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E5AE9D1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8so6405890wmi.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+NbKvblKXvTBz6c9sJuVyIRh2qgctsuKm2HRaATZXMA=;
        b=plYY1/Ffl6q6+dG9UB8r1e3cpfzGiSRF1AmBiw2qpER+1eNCyVvPoC0SEOq2r1SSwS
         41Ioak3bENttGuUEMnrj8pb24+Jb+yxFJ5YyUxI+SZfAHVgNlzenTm+HmhrGoM8F/amj
         gfnuAlhZD6JsJgsoZP7LiWQpqRZvDIRJD4LdsmhSTNJ27CUBZDblaFAW1Wz3sVeSNRbA
         qPrelZGA1yyGxqKD1vPA/FKCpuIB0tMg+7angAvqNCmkL/34L18/TIz+gnVxQ2y3x1Gk
         2ED34JapyYhoEoNStuQw9ojlXYQeFly1Ik9dt/09uvYHzBw+SUnWnqLUB+0JEnajb+0d
         7FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+NbKvblKXvTBz6c9sJuVyIRh2qgctsuKm2HRaATZXMA=;
        b=uNw9rINyBLtBccjimFcHTYrLjOaK7CfgFlZj5D5SJ2gw5xPHzECUf97mZD5UsHB62w
         Qxw6mZE0iAixG0xsAK4qn5k5h+ysIxK4CyKvaQgY9V7NoqjqPq6J+7e/1L9C55H1kkAM
         ZJhTjjP0fwRO063+gAO75ukBmmSI9ztelCCEiqA8AFp0m36lshCWfNQPly1ycDHMddJh
         NdiyLIEwMTO3uYki98M1u35CNGy9ZmeNN41sF5xyRGzDFc+46IxGsgvz51D2ypWYHkQ/
         88n618ZePAIV/LESPLXpk2mXydfFK98knN1EBjFMXOPNqiLdpUrAt/t0BJyKO8agX4qv
         aQRA==
X-Gm-Message-State: ACrzQf1EDc6cMCBemorged+CmeZMtgjuxz4PnRWj2od7CHYp8c02bkjM
        jyyG/I+ODKWzlrkrzPgLGGyarxi5jYSRNUz7MMtd+dPXkBQ=
X-Google-Smtp-Source: AMsMyM5FIn4UnzmAcQJRLrSq+MuN0UiXcGg0RCsHE9C5uDMCrbGobJLkTKXawoV5E2Woc8JX/OUzu1CGy+386Ec1EMs=
X-Received: by 2002:a05:600c:2608:b0:3b4:8dac:342a with SMTP id
 h8-20020a05600c260800b003b48dac342amr2398203wma.102.1664280851132; Tue, 27
 Sep 2022 05:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090506.10662-1-wenchao.chen666@gmail.com>
 <CAPDyKFqNJzwizZduMj_ig=aEXAgssQM8AzbYxa_T9XEqNXeWPw@mail.gmail.com>
 <25977700-7ab7-9a3b-5c67-c6c5fe35a13a@intel.com> <CA+Da2qxNU9cuYLm3-RcTeqpSszeCtHw4bzQ2xe_=76mwaKiKSQ@mail.gmail.com>
In-Reply-To: <CA+Da2qxNU9cuYLm3-RcTeqpSszeCtHw4bzQ2xe_=76mwaKiKSQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:34 +0200
Message-ID: <CAPDyKFqZUEse-bzNjdAX-jNDCq6qOhg9q7h8qMTZyLm9nPL5tQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Fix data stomping during mmc recovery
To:     =?UTF-8?B?6ZmI5paH6LaF?= <wenchao.chen666@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Sept 2022 at 07:45, =E9=99=88=E6=96=87=E8=B6=85 <wenchao.chen666=
@gmail.com> wrote:
>
> On Tue, Sep 20, 2022 at 6:19 PM Adrian Hunter <adrian.hunter@intel.com> w=
rote:
> >
> > On 20/09/22 12:32, Ulf Hansson wrote:
> > > + Adrian
> > >
> > > On Fri, 16 Sept 2022 at 11:05, Wenchao Chen <wenchao.chen666@gmail.co=
m> wrote:
> > >>
> > >> From: Wenchao Chen <wenchao.chen@unisoc.com>
> > >>
> > >> The block device uses multiple queues to access emmc. There will be =
up to 3
> > >> requests in the hsq of the host. The current code will check whether=
 there
> > >> is a request doing recovery before entering the queue, but it will n=
ot check
> > >> whether there is a request when the lock is issued. The request is i=
n recovery
> > >> mode. If there is a request in recovery, then a read and write reque=
st is
> > >> initiated at this time, and the conflict between the request and the=
 recovery
> > >> request will cause the data to be trampled.
> > >>
> > >> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > >
> > > Looks like we should consider tagging this for stable kernels too, ri=
ght?
> Yes,
>
> Kernel crash log:
> [  242.987575] process reclaim queue work at vmpressure 79
> [  243.041611] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        WC O
>     5.4.147-ab07227 #1
> [  243.041615] Hardware name: Generic DT based system
> [  243.041628] Workqueue: events mmc_mq_recovery_handler
> [  243.041638] PC is at mmc_blk_mq_recovery+0x2c/0x120
> [  243.041643] LR is at mmc_mq_recovery_handler+0x54/0xb8
> [  243.041648] pc : [<c0b9511c>]    lr : [<c06e331c>]    psr: 20030013
> [  243.041651] sp : ee941f00  ip : eed191a0  fp : ee941f08
> [  243.041655] r10: 00000000  r9 : e00aca0c  r8 : e0243fc0
> [  243.041659] r7 : e0096000  r6 : eed1b280  r5 : 00000000  r4 : e00aca08
> [  243.041667] r3 : c0cb7fd0  r2 : 00000000  r1 : a68e26a3  r0 : e0096000
> [  243.059012] process reclaim queue work at vmpressure 72
>
> dis -lx mmc_blk_mq_recovery
> 0xc0b950f0 <mmc_blk_mq_recovery>:       push    {r4, r5, r11, lr}
> 0xc0b950f4 <mmc_blk_mq_recovery+0x4>:   add     r11, sp, #8
> 0xc0b950f8 <mmc_blk_mq_recovery+0x8>:   mov     r4, r0
> 0xc0b950fc <mmc_blk_mq_recovery+0xc>:   stmfd   sp!, {lr}
> 0xc0b95100 <mmc_blk_mq_recovery+0x10>:  ldmfd   sp!, {lr}
> 0xc0b95104 <mmc_blk_mq_recovery+0x14>:  ldr     r0, [r4]
> 0xc0b95108 <mmc_blk_mq_recovery+0x18>:  mov     r2, #0
> 0xc0b9510c <mmc_blk_mq_recovery+0x1c>:  ldr     r5, [r4, #196]  ; 0xc4
> 0xc0b95110 <mmc_blk_mq_recovery+0x20>:  ldr     r0, [r0]
> 0xc0b95114 <mmc_blk_mq_recovery+0x24>:  str     r2, [r4, #196]  ; 0xc4
> 0xc0b95118 <mmc_blk_mq_recovery+0x28>:  strb    r2, [r4, #148]  ; 0x94
> 0xc0b9511c <mmc_blk_mq_recovery+0x2c>:  ldr     r1, [r5, #404]  ; 0x194
>
> Analyze:
> 0xc0b9510c <mmc_blk_mq_recovery+0x1c>:  ldr     r5, [r4, #196]  ; 0xc4
> r4 =3D e00aca08
> r4 + 0xc4 =3D E00ACACC
> crash_arm> rd E00ACACC
> e00acacc:  ec00cc00
> But r5 is 0, the correct value should be ec00cc00
>
> Code:
> void mmc_blk_mq_recovery(struct mmc_queue *mq)
> {
> struct request *req =3D mq->recovery_req;
> struct mmc_host *host =3D mq->card->host;
> struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
>
> mq->recovery_req =3D NULL;//<2>
> mq->rw_wait =3D false;
>
> if (mmc_blk_rq_error(&mqrq->brq)) {
> mmc_retune_hold_now(host);
> mmc_blk_mq_rw_recovery(mq, req);
> }
>
> mmc_blk_urgent_bkops(mq, mqrq);
>
> mmc_blk_mq_post_req(mq, req, true);
> }
>
> static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
> {
> struct mmc_queue_req *mqrq =3D
> container_of(mrq, struct mmc_queue_req, brq.mrq);
> struct request *req =3D mmc_queue_req_to_req(mqrq);
> struct request_queue *q =3D req->q;
> struct mmc_queue *mq =3D q->queuedata;
> struct mmc_host *host =3D mq->card->host;
> unsigned long flags;
>
> if (mmc_blk_rq_error(&mqrq->brq) ||
>     mmc_blk_urgent_bkops_needed(mq, mqrq)) {
> spin_lock_irqsave(&mq->lock, flags);
> mq->recovery_needed =3D true;
> mq->recovery_req =3D req; //<1>
> spin_unlock_irqrestore(&mq->lock, flags);
>
> host->cqe_ops->cqe_recovery_start(host);
>
> schedule_work(&mq->recovery_work);
> return;
> }
>
> mmc_blk_rw_reset_success(mq, req);
>
> /*
> * Block layer timeouts race with completions which means the normal
> * completion path cannot be used during recovery.
> */
> if (mq->in_recovery)
> mmc_blk_cqe_complete_rq(mq, req);
> else if (likely(!blk_should_fake_timeout(req->q)))
> blk_mq_complete_request(req);
> }
>
> When <1> is executed, just after the previous work is executed <2>, at
> this time, mq->recovery_req will be reassigned to NULL, causing the
> kernel to crash.
> So we need to wait for the recovery to complete before continuing to issu=
e req.
>
> > >
> > >> ---
> > >>  drivers/mmc/host/mmc_hsq.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > >> index a5e05ed0fda3..9d35453e7371 100644
> > >> --- a/drivers/mmc/host/mmc_hsq.c
> > >> +++ b/drivers/mmc/host/mmc_hsq.c
> > >> @@ -34,7 +34,7 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *=
hsq)
> > >>         spin_lock_irqsave(&hsq->lock, flags);
> > >>
> > >>         /* Make sure we are not already running a request now */
> > >> -       if (hsq->mrq) {
> > >> +       if (hsq->mrq || hsq->recovery_halt) {
> > >
> > > This still looks a bit odd to me, but I may not fully understand the
> > > code, as it's been a while since I looked at this.
> > >
> > > In particular, I wonder why the callers of mmc_hsq_pump_requests()
> > > need to release the spin_lock before they call
> > > mmc_hsq_pump_requests()? Is it because we want to allow some other
> > > code that may be waiting for the spin_lock to be released, to run too=
?
> >
> > FWIW, I am not aware of any reason.
> >
> > >
> > > If that isn't the case, it seems better to let the callers of
> > > mmc_hsq_pump_requests() to keep holding the lock - and thus we can
> > > avoid the additional check(s). In that case, it means the
> > > "recovery_halt" flag has already been checked, for example.
> > >
> > >>                 spin_unlock_irqrestore(&hsq->lock, flags);
> > >>                 return;
> > >>         }
> > >> --
> > >> 2.17.1
> > >>
> > >
> > > Kind regards
> > > Uffe
> >

Alright, as I am tagging this for stable it's nice to keep the change
small and simple. So I decided to pick $subject patch as is and
applied it on my fixes branch.

That said, would you mind having a look at whether it makes sense to
change the locking paths, as suggested earlier? Note that, this is
better done as a separate change on top (if even possible).

Thanks and kind regards
Uffe
