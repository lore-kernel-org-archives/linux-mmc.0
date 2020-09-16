Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757AEC433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CDB2068D
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 07:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgYllN+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIPHiL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIPHiD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 03:38:03 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3AC061788
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 00:38:03 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x203so3443760vsc.11
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ql2HHk7xdYd1gFzJiNUYKj4+ShA64J5FO0Fpo9subGg=;
        b=QgYllN+sJMUY6IuNH3kRCFQJNCcrUIoyn7TfP6oEUs9aB7Viis3UfjVfm0FgBAWKGl
         KZd2QiAmyOgSQIGoOTBCmxo7ZNqGOeSB9+YduMA+OMvsz/nozc8AlVILEqePedlRO9Oi
         xbwztFePw6scCBRSjrjy6+9YPVews1dXkVvMwrfJ6jE03z+wVLIb7o1RG5Y1gQjLnZRQ
         PQhnOnh7YQTIye1jVY60amlekjqk3pAP3wJW9CDNvyh4SO8J8Y+02FXlLuKQb6hTJ0JJ
         FuzrJ7Aiyn+2Rc/1PAwqspdf8C9MBZeZKFXF1vDshGiWGlgJ+K/Ng0eMIGOAYXzceky0
         SuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ql2HHk7xdYd1gFzJiNUYKj4+ShA64J5FO0Fpo9subGg=;
        b=MLXhOjZ9C50jyTp/Wbjy4KmCEJcmnvX4uCm6yQXD8ZDuRZqGP1+4c2gTshnkfGMOeQ
         X6QkXcI9twnQekzNgx1RzfRPQ4ZMRHu0prJ0dbDIrtntz3pk81K1G8N/MBoLthcdKjwm
         Bvph8k1qE0Vq+Ne53I8mw3wGlUb+FQdthaKN+Q8JXDBpA3zwLKLClyxLjeXEUod/utBm
         LVCJa9WDf2EVKWZ7LTRinNz6+gsqbAUWWY9xb86ZMijoCUZOiGtlxmDDnDC44YqDPYkL
         b10mt+0qb184J4+piBM2ob57odF3g6ygH5e1E4Z0crcUNj2NnT4vktn554M25vtj0e3U
         67Ng==
X-Gm-Message-State: AOAM532C1XuPmTm13V+9wtU9S80ZieP1eGj63e/1Ea6sgfQKnpd0EPoG
        k8sMcZLcpycK7VuHjJfEBSiojaD8ekffPyfglTJI8g==
X-Google-Smtp-Source: ABdhPJwAIVZFHEuYzqUsbgel+CzL0Ssqkp0Twb2u8HkeHT4/zRLDF7InSMgI7svCSj8PI2ql/cmeOzBtl2N8qyWrEDw=
X-Received: by 2002:a67:2e54:: with SMTP id u81mr3713148vsu.55.1600241882142;
 Wed, 16 Sep 2020 00:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
 <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com> <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
In-Reply-To: <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Sep 2020 09:37:26 +0200
Message-ID: <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
Subject: Re: Unable to handle kernel paging request at virtual address dead - __clk_put
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Sep 2020 at 07:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-09-20, 23:39, Ulf Hansson wrote:
> > On Tue, 15 Sep 2020 at 16:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > arm64 dragonboard-410c boot failed while running linux next 2020915 due to
> > > the kernel crash.
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > >   git describe: next-20200915
> > >   make_kernelversion: 5.9.0-rc5
> > >   kernel-config:
> > > https://builds.tuxbuild.com/J5oDTkph2aj855oeGOd45Q/kernel.config
> > >
> > >
> > > crash log:
> > > -------------
> > > [    3.517615] Synopsys Designware Multimedia Card Interface Driver
> > > [    3.524258] sdhci-pltfm: SDHCI platform and OF driver helper
> > > [    3.531302] Unable to handle kernel paging request at virtual
> > > address dead000000000108
> > > [    3.531396] Mem abort info:
> > > [    3.531460] sdhci_msm 7864900.sdhci: Got CD GPIO
> > > [    3.539182]   ESR = 0x96000044
> > > [    3.541953] ledtrig-cpu: registered to indicate activity on CPUs
> > > [    3.546692]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [    3.546701]   SET = 0, FnV = 0
> > > [    3.555694] usbcore: registered new interface driver usbhid
> > > [    3.555703] usbhid: USB HID core driver
> > > [    3.561638] genirq: irq_chip msmgpio did not update eff. affinity
> > > mask of irq 75
> > > [    3.563908]   EA = 0, S1PTW = 0
> > > [    3.580792] Data abort info:
> > > [    3.583673]   ISV = 0, ISS = 0x00000044
> > > [    3.583900] NET: Registered protocol family 10
> > > [    3.586785]   CM = 0, WnR = 1
> > > [    3.586794] [dead000000000108] address between user and kernel address ranges
> > > [    3.586806] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > > [    3.591869] Segment Routing with IPv6
> > > [    3.594829] Modules linked in:
> > > [    3.594841] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted
> > > 5.9.0-rc5-next-20200915 #1
> > > [    3.594844] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [    3.594862] Workqueue: events_unbound async_run_entry_fn
> > > [    3.597959] NET: Registered protocol family 17
> > > [    3.604991] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
> > > [    3.605000] pc : __clk_put+0x40/0x140
> > > [    3.605009] lr : __clk_put+0x2c/0x140
> > > [    3.610613] 9pnet: Installing 9P2000 support
> > > [    3.614183] sp : ffff80001005bbe0
> > > [    3.614189] x29: ffff80001005bbe0
> > > [    3.617233] Key type dns_resolver registered
> > > [    3.624696] x28: 000000000000002e
> > > [    3.624701] x27: ffff00003b620a68 x26: ffff800011496568
> > > [    3.624708] x25: ffff00003fcfe8f8 x24: ffff00003d30c410
> > > [    3.632518] registered taskstats version 1
> > > [    3.636931] x23: ffff800011495cf8 x22: ffff00003b620a40
> > > [    3.636938] x21: ffff00003d30c400 x20: ffff00003b620580
> > > [    3.636945] x19: ffff00003b64f380 x18: 0000000007824000
> > > [    3.636951] x17: ffff00003b620a00 x16: ffff00003b6205d0
> > > [    3.636958] x15: ffff8000119929f8 x14: ffffffffffffffff
> > > [    3.636965] x13: ffff800012947000 x12: ffff800012947000
> > > [    3.636975] x11: 0000000000000020
> > > [    3.641233] Loading compiled-in X.509 certificates
> > > [    3.646650] x10: 0101010101010101
> > > [    3.646654] x9 : ffff8000107b4c84 x8 : 7f7f7f7f7f7f7f7f
> > > [    3.646661] x7 : ffff000009fe5880 x6 : 0000000000000000
> > > [    3.646668] x5 : 0000000000000000 x4 : ffff000009fe5880
> > > [    3.646674] x3 : ffff80001250d7a0 x2 : ffff000009fe5880
> > > [    3.746653] x1 : ffff00003b64f680 x0 : dead000000000100
> > > [    3.751949] Call trace:
> > > [    3.757243]  __clk_put+0x40/0x140
> > > [    3.759413]  clk_put+0x18/0x28
> > > [    3.762885]  dev_pm_opp_put_clkname+0x30/0x58
> > > [    3.765837]  sdhci_msm_probe+0x288/0x9a8
> > > [    3.770265]  platform_drv_probe+0x5c/0xb0
> > > [    3.774258]  really_probe+0xf0/0x4d8
> > > [    3.778163]  driver_probe_device+0xfc/0x168
> > > [    3.781810]  __driver_attach_async_helper+0xbc/0xc8
> > > [    3.785717]  async_run_entry_fn+0x4c/0x1b0
> > > [    3.790575]  process_one_work+0x1c8/0x498
> > > [    3.794741]  worker_thread+0x54/0x428
> > > [    3.798822]  kthread+0x120/0x158
> > > [    3.802467]  ret_from_fork+0x10/0x30
> > > [    3.805771] Code: 35000720 a9438660 f9000020 b4000040 (f9000401)
> > > [    3.809334] ---[ end trace 1a607a5ea6891b9f ]---
> > >
> > > full test log link,
> > > https://lkft.validation.linaro.org/scheduler/job/1765840#L2014
> > > https://lkft.validation.linaro.org/scheduler/job/1765842#L1960
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
> >
> > Naresh, thanks for reporting!
> >
> > There have been regressions related to the opp library this cycle, so
> > I am wondering if Viresh may have any ideas, before going into more
> > details.
>
> I am really pissed at this. This is the exact bug we got earlier,
> which Naresh also confirmed as being fixed after the patches I
> proposed.

No worries, let's just fix it, again. :-)

>
> > One thing that also changed from the sdhci-msm point of view, is that
> > we enabled async probe [1]. This could be the thing that triggers an
> > untested error path of the probe?
>
> Maybe, but I am not sure if this will cause such an issue. At max it
> should cause issues for other stuff that depends on sdhci.
>
> > Otherwise we can always try to revert "mmc: sdhci-msm: Unconditionally
> > call dev_pm_opp_of_remove_table()", which I recently applied again
> > after the earlier errors.
>
> Yeah, that's the easiest of all.
>
> I am trying to find someone with local 410c who can help me fix it in
> realtime. Lets see.

I have the board as well. If you need some help with testing, just let me know.

In any case, I will try the revert and see how that changes things.

Kind regards
Uffe
