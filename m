Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59125C001B0
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjHHRly (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHHRl3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:41:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F4238D3
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:18:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76c845dc5beso353394085a.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511461; x=1692116261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsX16JaE/dN4gOylJbVE7fA44TuS5QnBc2EtJo4lrms=;
        b=Dn2ZiL8IXvYl7dWhCwxR5A3p3ptS6IPNyOGTlOCM5igBlWL0eA+UIlbjuN2thYVZNp
         XqaO0ggYc8Ev7UfhwxrbL7eLVPcLOPGh5EVeGct57UqaolbIWXpPgjTafJvC7zyMO5Sl
         bbppmMMjAvxSo83gSm8WLmGzaMFPVe9RAV4Xjfa6cj8efaA8EbbZp53p7Hn+6tfJeylm
         UwyVpTrOC6KEY++WQQW6Y/LlxIfn327L+x3zhj20cCXi+HCulmam9JjeJjVyPkn54FCW
         I+yKGGZPWwgz6uQzx4gHgNMaLzh+Z4ATkft3SQ5PcDzVd+4COw5d8dGmB8rnzSb2Kgxv
         y12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511461; x=1692116261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsX16JaE/dN4gOylJbVE7fA44TuS5QnBc2EtJo4lrms=;
        b=kYv9E16DPTon9dHkMYMl6pcIMiIUlO5eQJDZJhwylYeRHxGmAGhQGJKT2OfYvG2bTL
         mdvjjcO5W+/O8JVucDjPaftzQklxfeE5lu92pSeRMmAyWnB9ZDtus4CMOEOAIP5JGvsQ
         YDa8DL0MY8Pcif19rxN3Kd8AnPHu9F1OZuAjCKaldtSwPlGyj/kwTuaSjLipXkxDopmb
         U6VLWqNqACjE1YbzQeGcvwkZXuxMvLEyy6Dp2dxw2osgKRY2aGBkHUpa8OZuIbNSzy6e
         hzxG20JXZwh8ZBp59ZTXIX+2heNrFhKSzTMIO8hzjaIJeMOhtJVpAvbfduHyHMJhNBjr
         C5VA==
X-Gm-Message-State: AOJu0YysRtWf3KVcyWbuEQ+Aaz6IN8E232nY2Ws8brAO5iz8u64PoaoZ
        iv9A0CbmBrMIQ6AvVmWk8c2V5NXF6hu5TeJmPcFr4N5t9EpYSu8vQw8=
X-Google-Smtp-Source: AGHT+IFcHuCdhWhFwV2CScacW37TrXchQ6LgEx/9avD7k7yowHOyPtOByTZWzFezP6769EyQm7oX+P3bxdH+dA6DuRY=
X-Received: by 2002:a25:cc8a:0:b0:d09:544a:db1b with SMTP id
 l132-20020a25cc8a000000b00d09544adb1bmr14692730ybf.34.1691492228235; Tue, 08
 Aug 2023 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com>
 <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com> <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com>
In-Reply-To: <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:56:32 +0200
Message-ID: <CAPDyKFp2Yp=7FjWreaxHb6nbF8MVaTNtiKR7wfUk=nsE5vVihg@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Aug 2023 at 12:41, Wenchao Chen <wenchao.chen666@gmail.com> wrote=
:
>
> On Tue, Aug 8, 2023 at 5:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> wro=
te:
> > >
> > > Hsq is similar to cqe, using hsq->depth to represent
> > > the maximum processing capacity of hsq. We can adjust
> > > hsq->depth according to the actual situation.
> >
> > Sorry, but I don't quite follow here.
> >
> > Are you planning to update the host->hsq_depth dynamically from somewhe=
re?
> >
> > Kind regards
> > Uffe
> >
> Hi Uffe,
> Depending on the mmc device, some devices allow host to send more reqs
> to the device.

In that case, please add a patch for that too, to show how this is
going to be useful.

> Also, we use hsq->hsq_depth instead of immediate number "2" to make
> the code easier to understand.

Right, but we don't need a new member in struct mmc_host for that. We
could just be checking HSQ_MAX_DEPTH instead.

Kind regards
Uffe

>
> Thanks
> Wenchao.Chen
> > >
> > > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > > ---
> > >  drivers/mmc/core/queue.c   | 6 +-----
> > >  drivers/mmc/host/mmc_hsq.c | 1 +
> > >  drivers/mmc/host/mmc_hsq.h | 7 +++++++
> > >  include/linux/mmc/host.h   | 1 +
> > >  4 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > > index b396e3900717..a0a2412f62a7 100644
> > > --- a/drivers/mmc/core/queue.c
> > > +++ b/drivers/mmc/core/queue.c
> > > @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_m=
q_hw_ctx *hctx,
> > >                 }
> > >                 break;
> > >         case MMC_ISSUE_ASYNC:
> > > -               /*
> > > -                * For MMC host software queue, we only allow 2 reque=
sts in
> > > -                * flight to avoid a long latency.
> > > -                */
> > > -               if (host->hsq_enabled && mq->in_flight[issue_type] > =
2) {
> > > +               if (host->hsq_enabled && mq->in_flight[issue_type] > =
host->hsq_depth) {
> > >                         spin_unlock_irq(&mq->lock);
> > >                         return BLK_STS_RESOURCE;
> > >                 }
> > > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > > index 424dc7b07858..7b3952721c17 100644
> > > --- a/drivers/mmc/host/mmc_hsq.c
> > > +++ b/drivers/mmc/host/mmc_hsq.c
> > > @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_=
host *mmc)
> > >         hsq->mmc =3D mmc;
> > >         hsq->mmc->cqe_private =3D hsq;
> > >         mmc->cqe_ops =3D &mmc_hsq_ops;
> > > +       mmc->hsq_depth =3D HSQ_MAX_DEPTH;
> > >
> > >         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
> > >                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
> > > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > > index 1808024fc6c5..795f6b9421d7 100644
> > > --- a/drivers/mmc/host/mmc_hsq.h
> > > +++ b/drivers/mmc/host/mmc_hsq.h
> > > @@ -5,6 +5,13 @@
> > >  #define HSQ_NUM_SLOTS  64
> > >  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> > >
> > > +/*
> > > + * For MMC host software queue, we usually allow 2 requests in
> > > + * flight to avoid a long latency. But we can adjust hsq->depth
> > > + * according to the actual situation.
> > > + */
> > > +#define HSQ_MAX_DEPTH  2
> > > +
> > >  struct hsq_slot {
> > >         struct mmc_request *mrq;
> > >  };
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index 461d1543893b..1fd8b1dd8698 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -520,6 +520,7 @@ struct mmc_host {
> > >
> > >         /* Host Software Queue support */
> > >         bool                    hsq_enabled;
> > > +       int                     hsq_depth;
> > >
> > >         u32                     err_stats[MMC_ERR_MAX];
> > >         unsigned long           private[] ____cacheline_aligned;
> > > --
> > > 2.17.1
> > >
