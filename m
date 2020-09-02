Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05229C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C382087D
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCbwB5ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIBHER (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIBHEO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 03:04:14 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F587C061245
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 00:04:14 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n7so980185vkq.5
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqyOUgHPVXwuZM1HmllvHicoQC/cT/OXdA6Uv2/+iB4=;
        b=eCbwB5ca757GasTgZxHRzpZGyB6bd5yVA51xbq1QDoyBOhhSinGhVMYG9jEVunUCWK
         Ld7ATH27h1nkd5HI5RCeahmEq/NS6t94eb6LQpmx0fIviM8UM6laCTlxPYG/Fzkh9kpN
         MYYxNaB96nPEXHCaQea8O81073pZE9iqpMELUQn5nYZ+NIYGcHf79ojR8VVdUt8XHP6h
         QBZNqLC6mTBimGCNM9CFMqqB1gSE0pW94CM4OD2MftHIziqwIYoJnJjynUQSLWSaSA/r
         wVAQ2CCM/WSy+0ighikTA/BMGQR8XCXUkhiw5YNX0aoV2lK/EVwEJFhTkpOOOR/hbfig
         xFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqyOUgHPVXwuZM1HmllvHicoQC/cT/OXdA6Uv2/+iB4=;
        b=TlZTE/RmOn08y7U8Wo/aMGMTOn+g7TvRXeGhG/XAyRUELptaE/pgW9286ImMvpr7RH
         o5gebItXp7/bgkWvIgUTuXhKuRvFDyOxEzaefsl0ka6Q3Xie746Tond3EcTvHGXnc6ys
         dHNZc/Uv8iGzsgAK7Y1j+4FP366dQ8OjPDdjmekD8ynjoxEJh3a9Wcv44W+xwHrWMkAM
         nb4MY7uyf8m+x9jrPfx57VZILITEmIvCALil2llysXFIVTw4crar2bL5JuTT/7kekGyg
         4iwwCnEd5NLbZCCE8RxELAcKtxpLc5ghYfkUgid9KnbGVnj28G601IfOfHiMIiUyNgIy
         j57Q==
X-Gm-Message-State: AOAM532bcCaCSAtpAvvczzC/AgT+TaTuZ+8T/T/LFjz0i5Tq7G8E1auQ
        RCfnu4Obrz9tNsa0VJWU7HR61aqunE46g6OBnFI4sQ==
X-Google-Smtp-Source: ABdhPJzfSNs6jZeqCuXz5Y44M9LkgRNqp3/czj2HsyCcMxrEGmrTRQgLe8Z9ajKvWLgQg8HUNGhfuUCll6CTEjSaT1o=
X-Received: by 2002:a1f:141:: with SMTP id 62mr4522158vkb.2.1599030253660;
 Wed, 02 Sep 2020 00:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org> <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72> <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
In-Reply-To: <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 09:03:37 +0200
Message-ID: <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
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

On Tue, 1 Sep 2020 at 19:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 01, 2020 at 09:13:40AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 01, 2020 at 05:50:14PM +0200, peterz@infradead.org wrote:
> > > On Tue, Sep 01, 2020 at 09:44:17AM -0600, Lina Iyer wrote:
> > > > > > > > > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> > > > > > > > > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> > > > > > > > > that's the easiest approach, at least to start with.
> > >
> > > > I think this would be nice. This should also cover the case, where PM domain
> > > > power off notification callbacks call trace function internally. Right?
> > >
> > > That's just more crap for me to clean up later :-(
> > >
> > > trace_*_rcuidle() and RCU_NONIDLE() need to die, not proliferate.
> >
> > Moving the idle-entry boundary further in is good in any number of ways.
> > But experience indicates that no matter how far you move it, there will
> > be something complex further in.  Unless you are pushing it all the way
> > into all the arch-specific code down as far as it can possibly go?
>
> Not all; the simple cpuidle drivers should be good already. The more
> complicated ones need some help.
>
> The patch provided earlier:
>
>   https://lkml.kernel.org/r/20200901104206.GU1362448@hirez.programming.kicks-ass.net
>
> should allow the complicated drivers to take over and DTRT.

Don't get me wrong, I fully support your approach by moving the
rcu_idle_enter() down as far as possible, but it seems to require more
work than just adding a simple flag for the idle states.

Lots of cpuidle drivers are using CPU_PM notifiers (grep for
cpu_pm_enter and you will see) from their idlestates ->enter()
callbacks. And for those we are already calling
rcu_irq_enter_irqson|off() in cpu_pm_notify() when firing them.

Kind regards
Uffe
