Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12DC2D0EC
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 02:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5768206BE
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 02:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H72fQuUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDHCSZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:18:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44022 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgDHCSZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Apr 2020 22:18:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id g27so5873639ljn.10;
        Tue, 07 Apr 2020 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZmuuQDmjbfThkdVucOfg24uF/F+xF9tJ0Uct4xLzGQ=;
        b=H72fQuUm75SvElYdkSlzbhcZxlQJHc4OJevS7TZo2KD0sTUEYhlo6P21yL0HsMkfX6
         qIRlSd21OjZC3eVl+YQPdVyGTHBwEpUqaX9P3nQD+q1Hbfxz9VZZOwPJSONFg6wss2gn
         Te01XcGaibNrTcCoPA8qPVwGmBZpQ0gh1sKG6j3xF9OEYYc2zbwpNWsWwxZv1iK0ajtA
         TZroX86w9dQQhGYfkPAdKydkexY+T/40MsEJRbdW9BtziKI5+FEavXQfr9ZRvBkomgmy
         CajReVDUnhlDAP2y1qwvm/KC8Sou1PQV5T6O/qgR6azkV71PiQXfkcG5Htdnudv36+ku
         L1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZmuuQDmjbfThkdVucOfg24uF/F+xF9tJ0Uct4xLzGQ=;
        b=bbi8kUwcsw22lLFXKq5uSbJRcPA/JAJFOJvgkhmRK5s9JK9TqGFcVcWV1D3WrRP/iR
         QwWKlLMyqHWhDLWORxIcfLbLL7ovfAI+JfINGPgTLzf9lqfqBZ4NmqFa4xJkmfuEK15P
         5jw7ymeB6ItpX7lukkzRh9Q0tbOj7wA0S0BQG+zBjMjyMVGyP8Bd50wB6AncI/OyZbee
         yDAxDdKigciFNSFM18M8FmTAyVaM/XG56gw1e7CWCcLGSLsYy7NwG2yRAESC9tegwsjZ
         ApoCSY+PftwOFXneORc3hcRwR9ZulPPl6/s9EutQ1Q/yqGUnUvsxxrKw3GziGefuwyRS
         fVmA==
X-Gm-Message-State: AGi0PuZGwybt1QCdSagwYsoWbGyXwquACOs4SdVLR0yFm5OzYroiLo83
        845IdqGfWYEgIS6C+oXgUgXCbbhnxfcE4/4jqV8=
X-Google-Smtp-Source: APiQypL7SQxveWDJmbOkj2JVO8+lLQOKdZsrqeYIgluaVFBvztmLXBMag8SValmexT6+EWcnGWh88JaMdRezOeKomOk=
X-Received: by 2002:a2e:8105:: with SMTP id d5mr3382375ljg.196.1586312302315;
 Tue, 07 Apr 2020 19:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585896945.git.baolin.wang7@gmail.com> <04c25ff9f9b17d41d734c498e4be61dee745bb30.1585896945.git.baolin.wang7@gmail.com>
 <5a55947b-e920-4515-49cf-163f6d539421@intel.com> <CADBw62qXyQCO5s+8Ytg2VCn5tEXS6dPQarQW1mHWJMJm+jUiXQ@mail.gmail.com>
 <5cc006fe-e5f5-b9bf-bb01-c425d943783c@intel.com>
In-Reply-To: <5cc006fe-e5f5-b9bf-bb01-c425d943783c@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 8 Apr 2020 10:18:11 +0800
Message-ID: <CADBw62qp0=4iq5yZNQzB7jCd0LCa4Jy7Xi7ErBpuDcj10DSdxQ@mail.gmail.com>
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

On Tue, Apr 7, 2020 at 6:15 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/04/20 10:21 am, Baolin Wang wrote:
> > On Tue, Apr 7, 2020 at 2:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 3/04/20 10:05 am, Baolin Wang wrote:
> >>> The SD host controller can process one request in the atomic context if
> >>> the card is nonremovable, which means we can submit next request in the
> >>> irq hard handler when using the MMC host software queue to reduce the
> >>> latency. Thus this patch adds a new API request_atomic() for the host
> >>> controller, as well as adding support for host software queue to submit
> >>> a request by the new request_atomic() API.
> >>>
> >>> Moreover there is an unusual case that the card is busy when trying to
> >>> send a command, and we can not polling the card status in interrupt
> >>> context by using request_atomic() to dispatch requests. Thus we should
> >>> queue a work to try again in the non-atomic context in case the host
> >>> releases the busy signal later.
> >>>
> >>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >>
> >>
> >> One minor point below, otherwise:
> >>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >>> ---
> >>>  drivers/mmc/host/mmc_hsq.c | 29 ++++++++++++++++++++++++++++-
> >>>  drivers/mmc/host/mmc_hsq.h |  1 +
> >>>  include/linux/mmc/host.h   |  3 +++
> >>>  3 files changed, 32 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> >>> index b90b2c9..a57f802 100644
> >>> --- a/drivers/mmc/host/mmc_hsq.c
> >>> +++ b/drivers/mmc/host/mmc_hsq.c
> >>> @@ -16,11 +16,20 @@
> >>>  #define HSQ_NUM_SLOTS        64
> >>>  #define HSQ_INVALID_TAG      HSQ_NUM_SLOTS
> >>>
> >>> +static void mmc_hsq_retry_handler(struct work_struct *work)
> >>> +{
> >>> +     struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> >>> +     struct mmc_host *mmc = hsq->mmc;
> >>> +
> >>> +     mmc->ops->request(mmc, hsq->mrq);
> >>> +}
> >>> +
> >>>  static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >>>  {
> >>>       struct mmc_host *mmc = hsq->mmc;
> >>>       struct hsq_slot *slot;
> >>>       unsigned long flags;
> >>> +     int ret = 0;
> >>>
> >>>       spin_lock_irqsave(&hsq->lock, flags);
> >>>
> >>> @@ -42,7 +51,24 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >>>
> >>>       spin_unlock_irqrestore(&hsq->lock, flags);
> >>>
> >>> -     mmc->ops->request(mmc, hsq->mrq);
> >>> +     if (mmc->ops->request_atomic)
> >>> +             ret = mmc->ops->request_atomic(mmc, hsq->mrq);
> >>> +     else
> >>> +             mmc->ops->request(mmc, hsq->mrq);
> >>> +
> >>> +     /*
> >>> +      * If returning BUSY from request_atomic(), which means the card
> >>> +      * may be busy now, and we should change to non-atomic context to
> >>> +      * try again for this unusual case, to avoid time-consuming operations
> >>> +      * in the atomic context.
> >>> +      *
> >>> +      * Note: we just give a warning for other error cases, since the host
> >>> +      * driver will handle them.
> >>> +      */
> >>> +     if (ret == -EBUSY)
> >>> +             schedule_work(&hsq->retry_work);
> >>> +     else
> >>> +             WARN_ON_ONCE(ret && ret != -EBUSY);
> >>
> >> 'ret != -EBUSY' is redundant because it is always true in the 'else' clause.
> >
> > Ah, Yes, thanks for pointing this out and I will fix it ine next version.
> >
> > By the way, could you help to review patch 2 and 3 in this patch set? Thanks.
> >
>
> I'd like to handle the inhibit wait differently.  I will make some patches
> for that and send them out.

OK, great. I'd like to test them. Thanks.

-- 
Baolin Wang
