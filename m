Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B3BC433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED65C20773
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGlSn8KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBQHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIBQHm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 12:07:42 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56358C061245
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 09:07:42 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j185so34299vsc.3
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjV9Jb8EPkuY+LUkD8oQXrSyG4zZSwVPneOyWtPHv1Y=;
        b=AGlSn8KNdoY1ggi8QhNqyiqUGMvBUhOwy832NYNWdSKgrH1FW6FMAvFtsyfEoh1N94
         C/VkOtij1OeWyh4fAycHoRGF7V6tKnxu+t7oddOwHYicPsK7WoKZDVbsCazpWVhNArnX
         eLxzWcYFZT6MCOq7DpCoRJM4y9Y6kiW/0w2T3qQ8QxpAo6U2Q9oXnNhyQro1hmx89XNK
         2vjVGmo5a/K+LOF1pv7/UABCuKFJk2PC9K3SvqNJqrYAHU8fD2AM215WT2bVZ1ieTteB
         9iGL2Vapvx0VDl9PuSOoB/oWSmq5AwobXDeow538ctLBXc/Fk8kxVnytgxbnAnJG+6vV
         RzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjV9Jb8EPkuY+LUkD8oQXrSyG4zZSwVPneOyWtPHv1Y=;
        b=cm/TjlAKRCh+KqTJv75UaMZkhW6Wgzj44Egxcv7MAcSPNBgso5sr/92KlnZ8wtMk+g
         l86wA9C+uUTvib7sTTgVnyXZpP4PgWzFkz+eCMtnN7OmD5RQ4bT8MlQNHzMzkOxk1Q7F
         vxt6/sKpT2wpkGwqmB7tQM9iXM9QkwgBZeJl5Wnnk45ndcpfoc+xe2iQ+lU8fOK15buv
         QG8cHBtZnr4dHUywwf3M35Ek5tQhVbP6SQnnGpgC5RCiy/3nQ0rgIIYVcG4TuXVIeZLJ
         JPINj+36QvSOIPQ9f1c7cQ2fcj0/pVjzi/kwYlfbR2TEqRYchObX2B8EZDW5luUi1AAW
         F+lA==
X-Gm-Message-State: AOAM532rUoYAU99UHdmDnOsQDShYuPVRYbG+xIU2R1273rJQ7uAAXbn2
        5uJrNLuiE9LqlPEH2nu1DQazEYbmD4EmjJFRldrSDQ==
X-Google-Smtp-Source: ABdhPJy3G2uK8eBUBRQTkok/IvBwsXbzoK5iYOysUYXi+23NQGr/PHw9BnkDjjPcjFwd+TyxVliznfFAxwwe8KbXWLE=
X-Received: by 2002:a67:7c4e:: with SMTP id x75mr5782487vsc.60.1599062861296;
 Wed, 02 Sep 2020 09:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <20200901150047.GB29330@paulmck-ThinkPad-P72> <CAPDyKFptZK-OqnAuJYGnpfPbZ1qw-iSd4t5SuE7SmWic=ms48Q@mail.gmail.com>
 <20200902135202.GG29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200902135202.GG29330@paulmck-ThinkPad-P72>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 18:07:05 +0200
Message-ID: <CAPDyKFqAAjCDSSJ56V+cdy6t0F01sXj_AkNxdXRtAKegf8DDsQ@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        peterz@infrdead.org, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 15:52, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Sep 02, 2020 at 08:49:11AM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 17:00, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> [ . . . ]
>
> > > Here is the list, though it is early in the morning here:
> > >
> > > 1.      RCU_NONIDLE().
> > >
> > > 2.      Peter's patch, if it turns out to hoist your code out of what
> > >         RCU considers to be the idle loop.
> > >
> > > 3.      If the problem is trace events, use the _rcuidle() variant of the
> > >         trace event.  Instead of trace_blah(), use trace_blah_rcuidle().
> > >
> > > 4.      Switch from RCU (as in rcu_read_lock()) to SRCU (as in
> > >         srcu_read_lock()).
> > >
> > > 5.      Take Peter's patch a step further, moving the rcu_idle_enter()
> > >         and rcu_idle_exit() calls as needed.  But please keep in mind
> > >         that these two functions require that irqs be disabled by their
> > >         callers.
> > >
> > > 6.      If RCU_NONIDLE() in inconvenient due to early exits and such,
> > >         you could use the rcu_irq_enter_irqson() and rcu_irq_exit_irqson()
> > >         functions that it calls.
> > >
> > > Do any of those help?
> >
> > Yes, they will, in one way or the other. Thanks for providing me with
> > all the available options.
> >
> > BTW, I still don't get what good rcu_idle_enter|exit() does, but I am
> > assuming those need to be called at some point before the CPU goes to
> > sleep.
>
> These functions allow RCU to leave idle CPUs undisturbed.  If they
> were not invoked, RCU would periodically IPI idle CPUs to verify that
> there were no RCU readers running on them.  This would be quite bad for
> battery lifetime, among other things.  So the call to rcu_idle_enter()
> tells RCU that it may safely completely ignore this CPU until its next
> call to rcu_idle_exit().

Alright, thanks for explaining this, much appreciated.

So in one way, we would also like to call rcu_idle_enter(), as soon as
we know there is no need for the RCU to be active. To prevent
unnecessary IPIs I mean. :-)

Kind regards
Uffe
