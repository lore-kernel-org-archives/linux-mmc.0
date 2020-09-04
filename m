Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5CC433E2
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6061206E7
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8Rfx90D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIDGJP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDGJO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2020 02:09:14 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9FC061246
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 23:09:14 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x203so3043466vsc.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug4djtA5GZ9Jcit3pQqACaL05SGu8YRJeDr/hO2jPpU=;
        b=G8Rfx90DHK4ZYfswSSLH6HpnzpkwheLzgRangJCN6O4g0PWanGj2nHjjGDTPCoO9Nf
         xWnOZ6/OkLqjUKVYKlOXMXG/wuim9/+4Lld6jb5ZMG0RdBnx5BcrEkXGILkOLCswU783
         jvIxh1NHB9JlNe08AHoKeBrdXPw95pexGZ+iEhUwJ76GFFQ8CpD49J8iPkPVEGc2BgI/
         xnP/VL2J95FeQAZZ304tFrFjpeJ8WpU+VKzCVEWtFadg+Nssg+PdYA2gvN3B3PzcDGHg
         TsgmKqSlGWo27zLby4VckCBLmTKYg/5IQAV1aOYTosxFSR1/lVgnK2hDCXb43Gnl1Tdv
         Q2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug4djtA5GZ9Jcit3pQqACaL05SGu8YRJeDr/hO2jPpU=;
        b=WDoLPHYF+hNZI6PfLuf5JTxkeaAU0S/bPRu7zySza0XhWoCJds9aeeB7dabOYznNut
         LrJG94uX7K3T6DVTDpfy8CeOAKD+S+jHG7dN2UFn5N65AyxL+Me1vTBmje0t3N1Gir8S
         4Qf1Ymwg8kKAp85ugiQ52q8hzucC9dlnS3LR/1ygUhrGWAPgLuZJHyD6JqVld9nUfpI8
         Td6VoWllqqgTDNJE6gDJ1s8SW0DzH6sR5FbuIaJRBftSakMvOvRR9UdAlbqAiUFxH1Wh
         GwlmigiexeQdMSl8tkcMRh5G4i68ks01Tdn00oyYAdsKODw863vQf42mVRr2r+/7fSfr
         rXoQ==
X-Gm-Message-State: AOAM533wKSF1Nofnk4TfQ6helohpDB8msT9axdk4Tn3A3iUUHEEs/iCq
        dhkJEzdUeOpKXN8888X63F4pVeNUV9KJfEHGOVsRzQ==
X-Google-Smtp-Source: ABdhPJxKdB1QJpJEKTAddkB6TjKNR3jmY8BhaNTS68k9yGl8ABJujx6Xf7Yf+QrFjnS5AhQ1RytJYEHYVPKAcRKcYBU=
X-Received: by 2002:a67:e45:: with SMTP id 66mr4494095vso.191.1599199753154;
 Thu, 03 Sep 2020 23:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org> <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72> <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
 <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com>
 <20200903135347.GC1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFqduU65YmhBZ8PwDRTZDLtWhWX087LBy0bx56go+ra4Ow@mail.gmail.com> <20200903150819.GE1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200903150819.GE1362448@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Sep 2020 08:08:36 +0200
Message-ID: <CAPDyKFqozsYk--rThgVZpuM86ohCNRCoRXum5NTxPOt2SoG2og@mail.gmail.com>
Subject: Re: [RFC][PATCH] cpu_pm: Remove RCU abuse
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 17:08, <peterz@infradead.org> wrote:
>
> On Thu, Sep 03, 2020 at 04:36:35PM +0200, Ulf Hansson wrote:
> > On Thu, 3 Sep 2020 at 15:53, <peterz@infradead.org> wrote:
> > >  static int cpu_pm_notify(enum cpu_pm_event event)
> > >  {
> > >         int ret;
> > >
> > > +       lockdep_assert_irqs_disabled();
> >
> > Nitpick, maybe the lockdep should be moved to a separate patch.
>
> Well, the unregister relies on IRQs being disabled here, so I figured
> asserting this was a good thing ;-)

Okay, make sense then.

>
> Starting the audit below, this might not in fact be true, which then
> invalidates the unregister implementation. In particular the notifier in
> arch/arm/kernel/hw_breakpoint.c seems to unconditionally enable IRQs.

I see.

>
> > > +       ret = raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
> >
> > Converting to raw_notifiers seems reasonable - if we need to avoid the
> > RCU usage.
> >
> > My point is, I wonder about if the notifier callbacks themselves are
> > safe from RCU usage. For example, I would not be surprised if tracing
> > is happening behind them.
>
> A bunch of them seem to call into the clk domain stuff, and I think
> there's tracepoints in that.
>
> > Moreover, I am not sure that we really need to prevent and limit
> > tracing from happening. Instead we could push rcu_idle_enter|exit()
> > further down to the arch specific code in the cpuidle drivers, as you
> > kind of all proposed earlier.
>
> Well, at some point the CPU is in a really dodgy state, ISTR there being
> ARM platforms where you have to manually leave the cache coherency
> fabric and all sorts of insanity. There should be a definite cut-off on
> tracing before that.

That's probably the case for some platforms, but I don't see why we
need to make everybody "suffer".

>
> Also, what is the point of all this clock and power domain callbacks, if
> not to put the CPU into an extremely low power state, surely you want to
> limit the amount of code that's ran when the CPU is in such a state.
>
> > In this way, we can step by step, move to a new "version" of
> > cpu_pm_enter() that doesn't have to deal with rcu_irq_enter_irqson(),
> > because RCU hasn't been pushed to idle yet.
>
> That should be easy enough to audit. The thing is that mainline is now
> generating (debug) splats, and some people are upset with this.
>
> If you're ok with ARM not being lockdep clean while this is being
> reworked I'm perfectly fine with that.

I think the splats can easily be fixed. Short term.

Adding RCU_NONIDLE (or similar) around pm_runtime calls in
psci_enter_domain_idle_state() does the trick. I have a patch for
that, it's tested and ready. Let me send it out.

Perhaps we should just accept that this is needed, as to allow us to
move step by step into a better situation, while also avoiding the
current splats.

>
> (There used to be a separate CONFIG for RCU-lockdep, but that seems to
> have been removed)

I don't think that would help. Infrastructure for testing will just
enable that Kconfig anyway still complains to us.

Kind regards
Uffe
