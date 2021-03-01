Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A73C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0064DF2
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhCAIyt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhCAIwP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Mar 2021 03:52:15 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA35C061221
        for <linux-mmc@vger.kernel.org>; Mon,  1 Mar 2021 00:51:33 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id a15so263153vsi.7
        for <linux-mmc@vger.kernel.org>; Mon, 01 Mar 2021 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AUiVQ6s2fNTXwR9rmj4jz/o7HiABJqvqze+rG8lt4E8=;
        b=DynCNbNJPSlN7exDpAiPb8PaIHXz7Zp4xSOx8VNf1NNTeILf0lWu01K7hL5qVmxfJL
         TxcFOgJkSE8SMwXBmNSlpzfGGN1PvfqbKtUc2rMspnHpfUD8ChCA+SN+pZHA5ivErIiX
         NgWKayg0vKJssysPGtTtyn+gPA/Q0EKdPtMJppgXwKyYsoQ08yUyEVPdzEAH3sw0oJYw
         eMEllf2kMj6jUqih3S6IUe9yhxca/rUov7bq2bv3VsfY4tXHdNgtp2HWljbt/aBebyOy
         RVNtWjdsBoap5ruGNDZPoGipllxbPvbnFEETvJQL5REN058yxp9AqzDsv4xJS3raZ6ZQ
         VbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AUiVQ6s2fNTXwR9rmj4jz/o7HiABJqvqze+rG8lt4E8=;
        b=sDZKu5WzT8IV9VltIYLF8RltUHgGA5M6LcRKXMCVKDMXmkhnnTBI+e19/pQBd56D4K
         pu/QvtrN647EmMyzJahqDp8Acg4mPo/yVieRHvhY3hECVTBeOXvOJzjN0alntPwuApZb
         355GS0twlC8oFXG0gGSSAYq9wu0xq6sGXJQv/cWOzR5VZVTX9n2v+qZcJrmOAlL+E3OI
         tefvUbRU+dDDQATcCupTNRasAaI/RY47TuZd0edEMZYNPIcQVAimsoSkIhMLYReCdo9Q
         hYhQiLpDKmAm7A3o48az2LoAYdNOJwIYGL5K7U2NvMILRLuNfRWxKhaXj/Y2DligqaeE
         vWuw==
X-Gm-Message-State: AOAM530/auqVDLGoXMrcaQhKwCng54eDuvs7EfC8gwnI21F/+CVsEPNi
        xbIxd18AblY/nD4OYd8JqK5wz3bOsxfIhPRdwUkK6GtLNQM=
X-Google-Smtp-Source: ABdhPJyfpeteOozCdyenpUr4Qm5D1SEviLm41A/ITJVyGcNu15q8Cy4ZfWsLY/R0nJZAr/Csvg2JDdtViyDo6Y61hfg=
X-Received: by 2002:a67:ec7:: with SMTP id 190mr7046277vso.42.1614588692668;
 Mon, 01 Mar 2021 00:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20210216224252.22187-1-marten.lindahl@axis.com>
In-Reply-To: <20210216224252.22187-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Mar 2021 09:50:56 +0100
Message-ID: <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     kernel@axis.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Tue, 16 Feb 2021 at 23:43, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
>
> Sometimes SD cards that has been run for a long time enters a state
> where it cannot by itself be recovered, but needs a power cycle to be
> operational again. Card status analysis has indicated that the card can
> end up in a state where all external commands are ignored by the card
> since it is halted by data timeouts.
>
> If the card has been heavily used for a long time it can be weared out,
> and should typically be replaced. But on some tests, it shows that the
> card can still be functional after a power cycle, but as it requires an
> operator to do it, the card can remain in a non-operational state for a
> long time until the problem has been observed by the operator.
>
> This patch adds function to power cycle the card in case it does not
> respond to a command, and then resend the command if the power cycle
> was successful. This procedure will be tested 1 time before giving up,
> and resuming host operation as normal.

I assume the context above is all about the ioctl interface?

So, when the card enters this non functional state, have you tried
just reading a block through the regular I/O interface. Does it
trigger a power cycle of the card - and then makes it functional
again?

>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
> Please note: This might not be the way we want to handle these cases,
> but at least it lets us start the discussion. In which cases should the
> mmc framework deal with error messages like ETIMEDOUT, and in which
> cases should it be handled by userspace?
> The mmc framework tries to recover a failed block request
> (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> Would it be an idea to act in a similar way when an ioctl times out?

Maybe, it's a good idea to allow the similar reset for ioctls as we do
for regular I/O requests. My concern with this though, is that we
might allow user space to trigger a HW resets a bit too easily - and
that could damage the card.

Did you consider this?

>
>  drivers/mmc/core/block.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 42e27a298218..d007b2af64d6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -976,6 +976,7 @@ static inline void mmc_blk_reset_success(struct mmc_b=
lk_data *md, int type)
>   */
>  static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *r=
eq)
>  {
> +       int type =3D rq_data_dir(req) =3D=3D READ ? MMC_BLK_READ : MMC_BL=
K_WRITE;
>         struct mmc_queue_req *mq_rq;
>         struct mmc_card *card =3D mq->card;
>         struct mmc_blk_data *md =3D mq->blkdata;
> @@ -983,7 +984,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq=
, struct request *req)
>         bool rpmb_ioctl;
>         u8 **ext_csd;
>         u32 status;
> -       int ret;
> +       int ret, retry =3D 1;
>         int i;
>
>         mq_rq =3D req_to_mmc_queue_req(req);
> @@ -994,9 +995,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *m=
q, struct request *req)
>         case MMC_DRV_OP_IOCTL_RPMB:
>                 idata =3D mq_rq->drv_op_data;
>                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i++) {
> +cmd_do:
>                         ret =3D __mmc_blk_ioctl_cmd(card, md, idata[i]);
> -                       if (ret)
> +                       if (ret =3D=3D -ETIMEDOUT) {
> +                               dev_warn(mmc_dev(card->host),
> +                                        "error %d sending command\n", re=
t);
> +cmd_reset:
> +                               mmc_blk_reset_success(md, type);
> +                               if (retry--) {
> +                                       dev_warn(mmc_dev(card->host),
> +                                                "power cycling card\n");
> +                                       if (mmc_blk_reset
> +                                           (md, card->host, type))
> +                                               goto cmd_reset;
> +                                       mmc_blk_reset_success(md, type);
> +                                       goto cmd_do;
> +                               }
>                                 break;
> +                       }
>                 }
>                 /* Always switch back to main area after RPMB access */
>                 if (rpmb_ioctl)
> --
> 2.11.0
>

Kind regards
Uffe
