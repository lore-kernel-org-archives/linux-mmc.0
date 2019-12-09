Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C6C43603
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B42072D
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/gXbkIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLIJIF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:08:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38156 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJIF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2019 04:08:05 -0500
Received: by mail-qv1-f68.google.com with SMTP id t5so2357941qvs.5;
        Mon, 09 Dec 2019 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsQ2cDmGprhje/X0/mOxIqAZtiH95tZMfnRQcWgEtGU=;
        b=k/gXbkIfkYKM8UAiGRIgpMRDdAMGNhUbCUJ3oWlXZg8YEhiUKi2kHqvCmFOspey+rK
         ujqwNkVaywsbQ/6igJCoscQnzsUMtTVOLNOaTc8bQn0gL3Fuxxh6vi1mNQgphfiiCr1w
         NsTvAN3Y9FOTMgXCo3xLA8WXyUFGMmrYI0m3OXXRyjssXs/WdaQKcz05WtnxWMYD7byY
         uskqA4FG7EoEaHju57oXwUgW2winyNQd8jYTvsQEOahXHPGN6r7LkqHL79mgZpM9FwdJ
         gkW5iQefATVtv5HmGLldwHgYis6+eiElsodNeCz1Xq8e7Rz9fzcuusCxo32T6tnndrAD
         EqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsQ2cDmGprhje/X0/mOxIqAZtiH95tZMfnRQcWgEtGU=;
        b=m2tHtaLGjCI6fgtKYQCXfwJAOD49pZcr9JuienSoZ+MdHr2tQXZMSaRoAEkfLZnKYU
         UGV2HyV4th8tXU0z0W5uAIvAuTqkGZ7s+7/FI9CFmq9ML53bsHly197ak6+QkLgwKFzN
         dGTCgPN95Z+zyhL/JKTfk+Z0UdNL/rGJIFNJcuM/bC9IQeHtTGF8JdpkuIPxlcseVPEC
         AK/qeVFORyCFuiLIOd0mM50MzD5tk/6HmYvfpH3jsP4AbNCe2KSxakpQzaVIlH5M8I/9
         nvx5pjV6zthUV7IoBoT9bHD/66uD5rH6ZU7OFv4wFm4gI3Q+4QKeVK2JJGR6j3K5Cz2A
         JuKw==
X-Gm-Message-State: APjAAAUncHHitqXEBrqKFO9KihjA/cw+G3YUewBXju/0MTIDe4o5QTyH
        rDeHanFuonpUXaFB6E/vPVBtXME0t3RgrX7qp/o=
X-Google-Smtp-Source: APXvYqwG+415JdeA8xETiG6lkE6CPXGAyNSlWo8u5TpjNUqOIU1vAQKLupugQVxv31avEepe1V+2zkFf+ajbMQKTQtk=
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr23160060qvb.89.1575882483886;
 Mon, 09 Dec 2019 01:08:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
 <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com> <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
In-Reply-To: <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 9 Dec 2019 17:07:52 +0800
Message-ID: <CADBw62qvkjrhpR7gKpf6NZNHai96Pc8GLHM+5sgNffbWS54WYA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, Nov 22, 2019 at 6:42 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Arnd,
>
> On Fri, Nov 22, 2019 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Nov 18, 2019 at 11:43 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > From: Baolin Wang <baolin.wang@linaro.org>
> > >
> > > Now the MMC read/write stack will always wait for previous request is
> > > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > > or queue a work to complete request, that will bring context switching
> > > overhead, especially for high I/O per second rates, to affect the IO
> > > performance.
> > >
> > > Thus this patch introduces MMC software queue interface based on the
> > > hardware command queue engine's interfaces, which is similar with the
> > > hardware command queue engine's idea, that can remove the context
> > > switching. Moreover we set the default queue depth as 32 for software
> > > queue, which allows more requests to be prepared, merged and inserted
> > > into IO scheduler to improve performance, but we only allow 2 requests
> > > in flight, that is enough to let the irq handler always trigger the
> > > next request without a context switch, as well as avoiding a long latency.
> > >
> > > From the fio testing data in cover letter, we can see the software
> > > queue can improve some performance with 4K block size, increasing
> > > about 16% for random read, increasing about 90% for random write,
> > > though no obvious improvement for sequential read and write.
> > >
> > > Moreover we can expand the software queue interface to support MMC
> > > packed request or packed command in future.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > Overall, this looks like enough of a win that I think we should just
> > use the current version for the moment, while still working on all the
> > other improvements.
> >
> > My biggest concern is the naming of "software queue", which is
> > a concept that runs against the idea of doing all the heavy lifting,
> > in particular the queueing in bfq.
> >
> > Then again, it does not /actually/ do much queuing at all, beyond
> > preparing a single request so it can fire it off early. Even with the
> > packed command support added in, there is not really any queuing
> > beyond what it has to do anyway.
>
> Yes. But can not find any better name until now and 'software queue'
> was suggested by Adrian.
>
> >
> > Using the infrastructure that was added for cqe seems like a good
> > compromise, as this already has a way to hand down multiple
> > requests to the hardware and is overall more modern than the
> > existing support.
> >
> > I still think we should do all the other things I mentioned in my
> > earlier reply today, but they can be done as add-ons:
> >
> > - remove all blocking calls from the queue_rq() function:
> >   partition-change, retune, etc should become non-blocking
> >   operations that return busy in the queue_rq function.
> >
> > - get bfq to send down multiple requests all the way into
> >   the device driver, so we don't have to actually queue them
> >   here at all to do packed commands
> >
> > - add packed command support
> >
> > - submit cmds from hardirq context if this is advantageous,
> >   and move everything else in the irq handler into irqthread
> >   context in order to remove all other workqueue and softirq
> >   processing from the request processing path.
> >
> > If we can agree on this as the rough plan for the future,
> > feel free to add my
>
> Yes, I agree with your plan. Thast's what we should do in future.
>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your reviewing and good suggestion.
>
> Ulf,
>
> I am not sure if there is any chance to merge this patch set into
> V5.5, I've tested for a long time and did not find any resession.
> Thanks.

Could you apply this patchset if no objection from your side? Or do
you need me to rebase and resend? Thanks.
