Return-Path: <SRS0=BwSF=5X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B84CC2BA16
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 07:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F3720678
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 07:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d23qVeU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDGHVr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:21:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39001 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGHVr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Apr 2020 03:21:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id i20so2501506ljn.6;
        Tue, 07 Apr 2020 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgyJX/tT/p7EOsEfgotNMj1exMf/z2jpwTwXDaChsqw=;
        b=d23qVeU9A4iyXSxPoFvo0fxSxwBchKebgTpZOFTYf5W6FShO0c7apqTiKZWJ0scD9o
         +RJbdP9KUDcwvWa+cjICZ0HVm1zes1M2o0YaacNoGAWEFK2gKIZfRBpb9XihKzzXCpH1
         4FTWO+3wjPZNkD1U+7jLnZlYFrmGbT6TYAoC1LwrvgMPcW4novFqlVI4xsjdsR6D7m4b
         91klmrIbMdJ1nv/SjIwbZ3ThK5usw+9lgkgdm1sgkG7BZpud8XUVq28luJCI9YHlQUZ7
         rwSsjhEKvVi0agDwF/qLD5JZe2k3FcQEMJTSyAe8JWwlsuMC/kmX0XvRpCpmSG2dZoIw
         Dj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgyJX/tT/p7EOsEfgotNMj1exMf/z2jpwTwXDaChsqw=;
        b=RSLStfHNelRZ/1iAz9Jjmhwsp8nDT++z1m5W/FYgzu0d/oVJAt9g4v/JkHNerpu5rE
         zKF44qUiPsSIe8i/oHAQBAljxiQO6WUiQFmqk2n5xp53OqLNUmZvJYAUyr14NjgXo36f
         H6N0ccNN0kT8XuwA6pho8K+7cqvaDeqMcrtBi6+Ppfe2Pt+W8QRigd/ShFS2pSKZkdm6
         jOuwkJO1Ux5+NUf+osp0yRe8XjLfW365SwhaqXCiSy3ZRGgmj+sZcTbiuW+ld0Mf/3Sz
         zQJlCkAHxw0QikqqTTCAs13B4xtSyhfdDSHtXP45oZY4eDgVmV6ycdVJEsY07Jb2Xl7i
         tlYQ==
X-Gm-Message-State: AGi0PuZJ5w1B3eT6dCVNcGAOWSLn1cG6+6K4r9Ed7kZXUojYb3uq/uVL
        QBzb2qAfMrQy5ZByuBJiL/hMbgYOGmR8a9avnDM=
X-Google-Smtp-Source: APiQypL0QO0fYdBCVGmywG1GuBMZ3MCrkmIuKXq+lBh+5kloWljtZtB11OvNSrqxC7vAP0e9L75JE4xR9G4URoBnhl8=
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr784501ljk.48.1586244104623;
 Tue, 07 Apr 2020 00:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585896945.git.baolin.wang7@gmail.com> <04c25ff9f9b17d41d734c498e4be61dee745bb30.1585896945.git.baolin.wang7@gmail.com>
 <5a55947b-e920-4515-49cf-163f6d539421@intel.com>
In-Reply-To: <5a55947b-e920-4515-49cf-163f6d539421@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 7 Apr 2020 15:21:33 +0800
Message-ID: <CADBw62qXyQCO5s+8Ytg2VCn5tEXS6dPQarQW1mHWJMJm+jUiXQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mmc: host: Introduce the request_atomic() for the host
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

On Tue, Apr 7, 2020 at 2:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/04/20 10:05 am, Baolin Wang wrote:
> > The SD host controller can process one request in the atomic context if
> > the card is nonremovable, which means we can submit next request in the
> > irq hard handler when using the MMC host software queue to reduce the
> > latency. Thus this patch adds a new API request_atomic() for the host
> > controller, as well as adding support for host software queue to submit
> > a request by the new request_atomic() API.
> >
> > Moreover there is an unusual case that the card is busy when trying to
> > send a command, and we can not polling the card status in interrupt
> > context by using request_atomic() to dispatch requests. Thus we should
> > queue a work to try again in the non-atomic context in case the host
> > releases the busy signal later.
> >
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
>
> One minor point below, otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/mmc_hsq.c | 29 ++++++++++++++++++++++++++++-
> >  drivers/mmc/host/mmc_hsq.h |  1 +
> >  include/linux/mmc/host.h   |  3 +++
> >  3 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > index b90b2c9..a57f802 100644
> > --- a/drivers/mmc/host/mmc_hsq.c
> > +++ b/drivers/mmc/host/mmc_hsq.c
> > @@ -16,11 +16,20 @@
> >  #define HSQ_NUM_SLOTS        64
> >  #define HSQ_INVALID_TAG      HSQ_NUM_SLOTS
> >
> > +static void mmc_hsq_retry_handler(struct work_struct *work)
> > +{
> > +     struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> > +     struct mmc_host *mmc = hsq->mmc;
> > +
> > +     mmc->ops->request(mmc, hsq->mrq);
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
> > @@ -42,7 +51,24 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >
> >       spin_unlock_irqrestore(&hsq->lock, flags);
> >
> > -     mmc->ops->request(mmc, hsq->mrq);
> > +     if (mmc->ops->request_atomic)
> > +             ret = mmc->ops->request_atomic(mmc, hsq->mrq);
> > +     else
> > +             mmc->ops->request(mmc, hsq->mrq);
> > +
> > +     /*
> > +      * If returning BUSY from request_atomic(), which means the card
> > +      * may be busy now, and we should change to non-atomic context to
> > +      * try again for this unusual case, to avoid time-consuming operations
> > +      * in the atomic context.
> > +      *
> > +      * Note: we just give a warning for other error cases, since the host
> > +      * driver will handle them.
> > +      */
> > +     if (ret == -EBUSY)
> > +             schedule_work(&hsq->retry_work);
> > +     else
> > +             WARN_ON_ONCE(ret && ret != -EBUSY);
>
> 'ret != -EBUSY' is redundant because it is always true in the 'else' clause.

Ah, Yes, thanks for pointing this out and I will fix it ine next version.

By the way, could you help to review patch 2 and 3 in this patch set? Thanks.

> >  }
> >
> >  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
> > @@ -325,6 +351,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
> >       hsq->mmc->cqe_private = hsq;
> >       mmc->cqe_ops = &mmc_hsq_ops;
> >
> > +     INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
> >       spin_lock_init(&hsq->lock);
> >       init_waitqueue_head(&hsq->wait_queue);
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > index 18b9cf5..ffdd9cd 100644
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
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index c318fb5..d4a50e5d 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -92,6 +92,9 @@ struct mmc_host_ops {
> >                           int err);
> >       void    (*pre_req)(struct mmc_host *host, struct mmc_request *req);
> >       void    (*request)(struct mmc_host *host, struct mmc_request *req);
> > +     /* Submit one request to host in atomic context. */
> > +     int     (*request_atomic)(struct mmc_host *host,
> > +                               struct mmc_request *req);
> >
> >       /*
> >        * Avoid calling the next three functions too often or in a "fast
> >
>


-- 
Baolin Wang
