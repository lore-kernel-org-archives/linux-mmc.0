Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA7C43461
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC27206EB
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgd2rOKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgICOjz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgICOjd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 10:39:33 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AAC061249
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 07:37:13 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q124so852461vkb.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLSg32zqZ1uwFhUQgFcon/VKvTPBahvcvor+61b9Y2o=;
        b=zgd2rOKCWNgbCnJWXnh44ZDoxhEral6Emwexd7kiirr8wCHd/0yXVlAzK3KL5dPaKm
         S5xjJ6F7XDedhaKcOwhxa/r2qRzjW0S4sMRxXeIhQJE14GYbMbMEjGz8YEBOS+9ZNHD7
         JX5Ug4XQLqLFfyAg1+R1pRWRoAWQ/fjpxcSOTDTXadYdAKECLtDIK852FPb9LfY7o9wU
         tHdKqRzEmAUT35ppQjItABIv5EYLCH6id9/WykRkwGPEwMFbM0R84gnHMbUkNbnF7nQL
         HJTyO/epUTizMmCuW2ZIUin9VCHRDWEinx3pukDX9Dw9R0Ka+2eNEwYbepMEaztvJRi7
         tNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLSg32zqZ1uwFhUQgFcon/VKvTPBahvcvor+61b9Y2o=;
        b=ZbXsnhQu6RdFzQ5wzwNFr8BsF8Bs1z4yucIPIHyiC+XfkbShAs0KVuUfaj3/hpvsw1
         4we3LXfLWe7gPk8R5A1s8ZwgbnTTxfccQsUr+6ugXunHnkmBXEj9oyE9ssuPvPk+y3Bz
         UWwuJbl5G8/FIc/ueUSupGLlgWTDMq8TxvGU/xOfiGSiwMki294fd48Y5tQvLlf4/ZIA
         /1kwwtbj7qq5jy4vJNmFKIyIrnkFnBQEVe93I9d6Wsq578DGl3VdUd5xWxNq8xXSIFFo
         H5z+6c5oviymUwavWbNClU2RSKUeb73mlziBBwpNFBgDgPektzEwXG3ZRSLYP5Qas/t8
         TMzQ==
X-Gm-Message-State: AOAM5308icyB+jdqP4O3jTvvHNqQ8tNY5sZ9aIFAdRxQdHE9sQGCI2C4
        BN+FAAV5Vxb4TEU05kV0txNY4lCJMqlJd4Sb5nNcwQ==
X-Google-Smtp-Source: ABdhPJxVBD/I9k3j29ntwBERLlwmUh+XdA4TLiaA+ldSn5HoDrbT+XvZ9K1ienLPG0zjVT/1zM3yMdHFGfj8JQO3z2I=
X-Received: by 2002:a05:6122:6bb:: with SMTP id r27mr1616268vkq.3.1599143832258;
 Thu, 03 Sep 2020 07:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org> <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72> <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
 <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com> <20200903135347.GC1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200903135347.GC1362448@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 16:36:35 +0200
Message-ID: <CAPDyKFqduU65YmhBZ8PwDRTZDLtWhWX087LBy0bx56go+ra4Ow@mail.gmail.com>
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

On Thu, 3 Sep 2020 at 15:53, <peterz@infradead.org> wrote:
>
> On Wed, Sep 02, 2020 at 05:58:55PM +0200, Ulf Hansson wrote:
> > On Wed, 2 Sep 2020 at 14:14, <peterz@infradead.org> wrote:
> > >
> > > On Wed, Sep 02, 2020 at 09:03:37AM +0200, Ulf Hansson wrote:
> > > > Lots of cpuidle drivers are using CPU_PM notifiers (grep for
> > > > cpu_pm_enter and you will see) from their idlestates ->enter()
> > > > callbacks. And for those we are already calling
> > > > rcu_irq_enter_irqson|off() in cpu_pm_notify() when firing them.
> > >
> > > Yeah, that particular trainwreck is on my todo list already ... then
> > > again, that list is forever overflowing.
> > >
> > > I'm thinking cpu_pm_unregister_notifier() is not a common thing? The few
> > > I looked at seem to suggest 'never' is a good approximation.
> >
> > The trend is that drivers are turning into regular modules that may
> > also need to manage "->remove()", which may mean unregistering the
> > notifier. Of course, I don't know for sure whether that becomes a
> > problem, but it seems quite limiting.
>
> You can pin modules, once they're loaded they can never be removed
> again.
>
> Anyway, the below should 'work', I think.
>
> ---
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index f7e1d0eccdbc..72804e0883d5 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -12,21 +12,18 @@
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
>
> -static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
> +static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
> +static DEFINE_SPINLOCK(cpu_pm_lock);
>
>  static int cpu_pm_notify(enum cpu_pm_event event)
>  {
>         int ret;
>
> -       /*
> -        * atomic_notifier_call_chain has a RCU read critical section, which
> -        * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
> -        * RCU know this.
> -        */
> -       rcu_irq_enter_irqson();
> -       ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
> -       rcu_irq_exit_irqson();
> +       lockdep_assert_irqs_disabled();

Nitpick, maybe the lockdep should be moved to a separate patch.

> +       ret = raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);

Converting to raw_notifiers seems reasonable - if we need to avoid the
RCU usage.

My point is, I wonder about if the notifier callbacks themselves are
safe from RCU usage. For example, I would not be surprised if tracing
is happening behind them.

Moreover, I am not sure that we really need to prevent and limit
tracing from happening. Instead we could push rcu_idle_enter|exit()
further down to the arch specific code in the cpuidle drivers, as you
kind of all proposed earlier.

In this way, we can step by step, move to a new "version" of
cpu_pm_enter() that doesn't have to deal with rcu_irq_enter_irqson(),
because RCU hasn't been pushed to idle yet.

[...]

Kind regards
Uffe
