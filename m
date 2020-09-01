Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED11C433E7
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 06:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA692087D
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 06:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDF7LoOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIAGrh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIAGrc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2020 02:47:32 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734FFC0612B1
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 23:47:31 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id b4so80690vkh.9
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oifFdmXULzK6sVZQwlchaA3hM9sOOMssvlLwC1vno/Y=;
        b=EDF7LoOdrSEdX5GMv9D+fIHt9SNaw7sL3J6OZhS+t0Ap7gtIF9JH2gsgMz2uECU3IG
         CgM21YqTGpH9DBZViZWoE6ybiuuOOL6N+CWNuDp7hofQ9nlZCJt1Q+vTkRmZJRg42029
         rrbvG9HRw+7hZqrbOwK6OIJhlxojzK5uvYqxkZLhkgCaliaIrF7g++Z8Hws2NbReBvcY
         MmlGw2VzDX3Pg9oXixYwsHeLg1jCKFH4hQQFaa6STpYEioJGHp3/oakcIvls3yfiXsKW
         wYHlcHBJMomA/4axUYBF7DMbaFXGP7grNlkl8A2Dxgbdff0V62gGPdwk8Kxva6VEZ8P7
         QQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oifFdmXULzK6sVZQwlchaA3hM9sOOMssvlLwC1vno/Y=;
        b=ARAHp5vvEcvMII8dviANZDTKosjAJIQtGh2vUq1aTSZkopG2j6QCk+Ut+B77gAA/hQ
         knYB6t5ZY3adZj4/blbO/b+j+7yBIh4QdFZ5gmBhMeQ/URVgn7+Is2G9jNItzVH9reAB
         EKfWZevi+zcinS3V7R5uO0K1gsywr7E4mhhKp4jrspyO2Ucq4n/2mf9IPOVx81+VY7qx
         agzDrg5kQNUJkxIdKZpNUxpCr+RBLMc1aAEgLoxBJAj1wSt19v52FmNI38ZneixWi2QW
         Xk8pwrG+WDlGHsqQESibJbSjeKkO44bjGcWlB2W9JmIMQCwYSe/rXwCSU/0JLXCKOn5W
         gFiw==
X-Gm-Message-State: AOAM530GQyCuPCRevjP5OgYwjkcXX0S11hvZo0bnH18cMSXhONdonw9R
        Ky/ww+hOYom0yXdfIbBRPhufeGaArUt7aY6525/4cg==
X-Google-Smtp-Source: ABdhPJzH8WKHXGEEHlB0GOP6TJgcrRYA3rqU86DQAeSkHuTHB5EJoouKep21/cuL43FNK2ok8t8nPcr30YooPDX2lk8=
X-Received: by 2002:a1f:a286:: with SMTP id l128mr250532vke.1.1598942850433;
 Mon, 31 Aug 2020 23:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
In-Reply-To: <20200831194402.GD2855@paulmck-ThinkPad-P72>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 08:46:54 +0200
Message-ID: <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     paulmck@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

+ Saravanna, Rafael, Lina

On Mon, 31 Aug 2020 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Aug 31, 2020 at 12:02:31PM +0530, Naresh Kamboju wrote:
> > While booting linux mainline kernel on arm64 db410c this kernel warning
> > noticed.
> >
> > metadata:
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >   git commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
> >   git describe: v5.9-rc3
> >   make_kernelversion: 5.9.0-rc3
> >   kernel-config:
> > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-mainline/2965/config
> >
> > Boot log,
> >
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> > [    0.000000] Linux version 5.9.0-rc3 (oe-user@oe-host)
> > (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils)
> > 2.30.0.20180208) #1 SMP PREEMPT Mon Aug 31 00:23:15 UTC 2020
> > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > <>
> > [    5.299090] sdhci: Secure Digital Host Controller Interface driver
> > [    5.299140] sdhci: Copyright(c) Pierre Ossman
> > [    5.304313]
> > [    5.307771] Synopsys Designware Multimedia Card Interface Driver
> > [    5.308588] =============================
> > [    5.308593] WARNING: suspicious RCU usage
> > [    5.316628] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    5.320052] 5.9.0-rc3 #1 Not tainted
> > [    5.320057] -----------------------------
> > [    5.320063] /usr/src/kernel/include/trace/events/lock.h:37
> > suspicious rcu_dereference_check() usage!
> > [    5.320068]
> > [    5.320068] other info that might help us debug this:
> > [    5.320068]
> > [    5.320074]
> > [    5.320074] rcu_scheduler_active = 2, debug_locks = 1
> > [    5.320078] RCU used illegally from extended quiescent state!
> > [    5.320084] no locks held by swapper/0/0.
> > [    5.320089]
> > [    5.320089] stack backtrace:
> > [    5.320098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
> > [    5.346354] sdhci_msm 7864900.sdhci: Got CD GPIO
> > [    5.346446] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    5.346452] Call trace:
> > [    5.346463]  dump_backtrace+0x0/0x1f8
> > [    5.346471]  show_stack+0x2c/0x38
> > [    5.346480]  dump_stack+0xec/0x15c
> > [    5.346490]  lockdep_rcu_suspicious+0xd4/0xf8
> > [    5.346499]  lock_acquire+0x3d0/0x440
> > [    5.346510]  _raw_spin_lock_irqsave+0x80/0xb0
> > [    5.413118]  __pm_runtime_suspend+0x34/0x1d0
> > [    5.417457]  psci_enter_domain_idle_state+0x4c/0xb0
> > [    5.421795]  cpuidle_enter_state+0xc8/0x610
> > [    5.426392]  cpuidle_enter+0x3c/0x50
> > [    5.430561]  call_cpuidle+0x44/0x80
> > [    5.434378]  do_idle+0x240/0x2a0
>
> RCU ignores CPUs in the idle loop, which means that you cannot use
> rcu_read_lock() from the idle loop without use of something like
> RCU_NONIDLE().  If this is due to event tracing, you should use the
> _rcuidle() variant of the event trace statement.

In the runtime suspend path, the runtime PM core calls
device_links_read_lock() - if the device in question has any links to
suppliers (to allow them to be suspended too).

device_links_read_lock() calls srcu_read_lock().

It turns out that the device in question (the CPU device that is
attached to genpd) didn't have any links before - but that seems to
have changed, due to the work done by Saravana (links become created
on a per resource basis, parsed from DT during boot).

>
> Note also that Peter Zijlstra (CCed) is working to shrink the portion
> of the idle loop that RCU ignores.  Not sure that it covers your
> case, but it is worth checking.

Thanks for letting me know. Let's see what Peter thinks about this then.

Apologize for my ignorance, but from a cpuidle point of view, what
does it mean using RCU_NONIDLE()? I guess we should avoid RCU_NONIDLE
on bigger code paths?

I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
that's the easiest approach, at least to start with.

Or do you have any other ideas?

[...]

Kind regards
Uffe
