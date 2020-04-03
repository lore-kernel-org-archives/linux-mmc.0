Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F92C43331
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 01:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2262C20721
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 01:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvvOIHH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgDCBVe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:21:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46277 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDCBVe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2020 21:21:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so4365671lfb.13;
        Thu, 02 Apr 2020 18:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUNSl/50eGIpSGqTMmeK3n+jOC9cdY6NAvZm5scvZCM=;
        b=BvvOIHH54JYbLZpG8jHom1v+3utD1GuTCb1GvwQg0cR99xIyeSKWhp0R4iBWGy7qId
         OedpGcZmKzTat1uZ6YUQY1tcPYu21uniNS30K3bYHSQgEus9m66PVrVoygpghxz2j3Ep
         lPGp0Fh/mOicFryW8uBemwWxxhCRJRpduLQ0h4RiW1M/HdD5oNjCwW0Cop7uZeQ8WRWU
         839YbixNatdA+4jmpq06UbVpVgsWuOawhBQRTiTKpy/O0gCyKS8KhNYgRl1eVxE6Fm+v
         7azUoFEDYAJyV37IgnbpW6sLMWkubimb2Gp2/OwCP61iAja6fARfQYgSLTdxYt4hP+bg
         8QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUNSl/50eGIpSGqTMmeK3n+jOC9cdY6NAvZm5scvZCM=;
        b=sN+SZSf3iPdW7eyRuW3B5D4BpjcHbeiD4xYbNQAYdVbLYHEToZNNh74gFyGVJ2y6WV
         6ihkgRsLYKzHCsgNkttDsgrA7Ac9YhJv7WNqnooWrb6T0Y+MXSQE1nBhQca2fVXPkxji
         bWFjWheKNEugbdcFStsj5m4RIikYPWbADsZIikHVEBChIH2QGavqY1dyvP3mp5RsEFH5
         /B+JE35HpcMZjJQ9TR4f74bkydrqoyaiqABrcb2pRcxL1pkoIaNK/sf/PoQNhg6CFdrf
         GWa0hz9TXyUQ48Ck8RjgPf/lSfYwomFg9nf2r2FSV959dExhZcpcdzqKDJJzmlFf/9Oc
         UBaA==
X-Gm-Message-State: AGi0PuazZ9YkuGIh9igrfeCPUSoEvM9vhcPqEqaZpAHIgXeaaoD8dw46
        S7A8sH0UChEGPgBAKokipPe5H/kgWu+eucVAs28=
X-Google-Smtp-Source: APiQypJl7WYfWV/62lAg1ft5FVLuaKll7/rVzXalCK1EQt+89RB6TIupoVvDtStwgSUR+d7/LPyWGBlw3lsk0g7bOw0=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr3786670lfh.90.1585876890361;
 Thu, 02 Apr 2020 18:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584615043.git.baolin.wang7@gmail.com> <c94b7e9a2fb48ac921fe41dba56df91efcdaa6c4.1584615043.git.baolin.wang7@gmail.com>
 <3e048723-2edb-cc5b-a8f1-8ab8554e077f@intel.com>
In-Reply-To: <3e048723-2edb-cc5b-a8f1-8ab8554e077f@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 3 Apr 2020 09:21:19 +0800
Message-ID: <CADBw62r5FxFv42=BZz2ZmF408rkYD18DkxkJpMpy_Z+6mF6eDg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: host: hsq: Handle an unusual case of returing busy
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Thu, Apr 2, 2020 at 6:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/03/20 12:54 pm, Baolin Wang wrote:
> > There is an unusual case that the card is busy when trying to send a
> > command, and we can not polling the card status in interrupt context
> > by using request_atomic() to dispatch requests.
> >
> > Thus we should queue a work to try again in the non-atomic context
> > in case the host releases the busy signal later.
>
> I think this should be part of patch 1

OK. Will move these changes into patch 1.

>
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> Sorry for the slow reply.
>
> > ---
> >  drivers/mmc/host/mmc_hsq.c | 37 ++++++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/mmc_hsq.h |  1 +
> >  2 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > index fdbaa98..3edad11 100644
> > --- a/drivers/mmc/host/mmc_hsq.c
> > +++ b/drivers/mmc/host/mmc_hsq.c
> > @@ -15,11 +15,33 @@
> >  #define HSQ_NUM_SLOTS        64
> >  #define HSQ_INVALID_TAG      HSQ_NUM_SLOTS
> >
> > +static void mmc_hsq_retry_handler(struct work_struct *work)
> > +{
> > +     struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> > +     struct mmc_host *mmc = hsq->mmc;
> > +     struct mmc_request *mrq = hsq->mrq;
> > +     struct mmc_data *data = mrq->data;
> > +
> > +     if (mmc->ops->request) {
>
> ->request() is not an optional mmc operation so checking it is not necessary.

Yes, will remove the checking.

>
> > +             mmc->ops->request(mmc, mrq);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * If host does not supply the callback in normal context to
> > +      * handle request, just finish this request.
> > +      */
> > +     data->error = -EBUSY;
> > +     data->bytes_xfered = 0;
> > +     mmc_hsq_finalize_request(mmc, mrq);
> > +}
> > +
> >  static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >  {
> >       struct mmc_host *mmc = hsq->mmc;
> >       struct hsq_slot *slot;
> >       unsigned long flags;
> > +     int ret = 0;
> >
> >       spin_lock_irqsave(&hsq->lock, flags);
> >
> > @@ -42,9 +64,21 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >       spin_unlock_irqrestore(&hsq->lock, flags);
> >
> >       if (mmc->ops->request_atomic)
> > -             mmc->ops->request_atomic(mmc, hsq->mrq);
> > +             ret = mmc->ops->request_atomic(mmc, hsq->mrq);
> >       else
> >               mmc->ops->request(mmc, hsq->mrq);
> > +
> > +     /*
> > +      * If returning BUSY from request_atomic(), which means the card
> > +      * may be busy now, and we should change to non-atomic context to
> > +      * try again for this unusual case, to avoid time-consuming operations
> > +      * in the atomic context.
> > +      *
> > +      * Note: we can ignore other error cases, since the host driver
> > +      * will handle them.
> > +      */
> > +     if (ret == -EBUSY)
> > +             schedule_work(&hsq->retry_work);
>
> Let's add a warning for unexpected return values i.e.
>
>         WARN_ON_ONCE(ret && ret != -EBUSY);

Sure. Thanks for your comments.

>
>
> >  }
> >
> >  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
> > @@ -327,6 +361,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
> >       hsq->mmc->cqe_private = hsq;
> >       mmc->cqe_ops = &mmc_hsq_ops;
> >
> > +     INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
> >       spin_lock_init(&hsq->lock);
> >       init_waitqueue_head(&hsq->wait_queue);
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > index d51beb7..81f6c4f 100644
> > --- a/drivers/mmc/host/mmc_hsq.h
> > +++ b/drivers/mmc/host/mmc_hsq.h
> > @@ -12,6 +12,7 @@ struct mmc_hsq {
> >       wait_queue_head_t wait_queue;
> >       struct hsq_slot *slot;
> >       spinlock_t lock;
> > +     struct work_struct retry_work;
> >
> >       int next_tag;
> >       int num_slots;
> >
>


-- 
Baolin Wang
