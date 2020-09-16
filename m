Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE14C433E2
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 05:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CAA221E7
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 05:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcV2xPoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIPFWw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgIPFWt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 01:22:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193BC061788
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 22:22:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so3289985pfd.5
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 22:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3E9hVNUS9hl+g/ET5NtLbC6kuy/hmmqxMhC6YHOdByw=;
        b=fcV2xPoStd0Jn5pPKp3sCxVRkz/56UAIYT0bsxaoNxh2FLpr8rJZN5ZU+VpIQUNERk
         WsQppsQ4ijBd5yX1qcgrmmXFUar4JbQA1T5zqOhnE0stGPnTpDNjRwOvnqJLigQ3OeLy
         oMJk20S06LNCDNUI8X9ZoOhnIg8gxMyB1b9GuZhO5Awr3Oig4O3IucSBOhO8ZirA/74G
         XUY7p4/a0OSNdoac/xenlTVsJOoOyJ0WhwngqbwPI7IZW6NokDt1rh4ST39IEj/wW5Q6
         Du7IlGFziG/Ume1AEtCk9UiZmXMchMwUNrep69xtWxKJk6z+x2nISbLpQ+STql8gAWJC
         gjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3E9hVNUS9hl+g/ET5NtLbC6kuy/hmmqxMhC6YHOdByw=;
        b=glkw31zETBfFidgYwRLxmkYZBaiZTmozyMj/d5/riogRBTXYLsWn2Rjox3QvIEnSqz
         yKQfhvF6Pwwq+5Bzr9sZh2ILeOXILu2RtfJia1ak5ZYEpZMip2GLeezkb84WEb8CgmXi
         YdzTn8UIDFereUjPoiDqKgTbqWTX/HzMtcFuPIXP2IHO1AdeAdKSAlmmmTpKHQT5BzfW
         xMlbaWZfjESnh3z+DSPdyGgp1inNksF5h9SyVm2vvwN1XVmFLUJuSYPvP2Kto7j9iVG1
         sh7rrsYbWOvOSpvuXsT5W4oPBjHtR7c6291NTiAUNCD+fZeTPKehQeEPFjujhGkVggf2
         bTyA==
X-Gm-Message-State: AOAM530sn5omGOAzoKBgE9wHKNyJTIYh0GA+1w9RBBfcPsloZWHofa7A
        PpL90mHOl+Qk/REZKqk1qWHWHA==
X-Google-Smtp-Source: ABdhPJxKq1C236x3+23o+hcAe7HflPw0SBB+cNtPfrUaShA9EQ6maxUaLlboG3PLt7jZEI//3f0wHA==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr16080585pgc.297.1600233767068;
        Tue, 15 Sep 2020 22:22:47 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id q198sm12478343pfq.185.2020.09.15.22.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 22:22:46 -0700 (PDT)
Date:   Wed, 16 Sep 2020 10:52:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: Unable to handle kernel paging request at virtual address dead -
 __clk_put
Message-ID: <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
References: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
 <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15-09-20, 23:39, Ulf Hansson wrote:
> On Tue, 15 Sep 2020 at 16:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > arm64 dragonboard-410c boot failed while running linux next 2020915 due to
> > the kernel crash.
> >
> > metadata:
> >   git branch: master
> >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git describe: next-20200915
> >   make_kernelversion: 5.9.0-rc5
> >   kernel-config:
> > https://builds.tuxbuild.com/J5oDTkph2aj855oeGOd45Q/kernel.config
> >
> >
> > crash log:
> > -------------
> > [    3.517615] Synopsys Designware Multimedia Card Interface Driver
> > [    3.524258] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    3.531302] Unable to handle kernel paging request at virtual
> > address dead000000000108
> > [    3.531396] Mem abort info:
> > [    3.531460] sdhci_msm 7864900.sdhci: Got CD GPIO
> > [    3.539182]   ESR = 0x96000044
> > [    3.541953] ledtrig-cpu: registered to indicate activity on CPUs
> > [    3.546692]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    3.546701]   SET = 0, FnV = 0
> > [    3.555694] usbcore: registered new interface driver usbhid
> > [    3.555703] usbhid: USB HID core driver
> > [    3.561638] genirq: irq_chip msmgpio did not update eff. affinity
> > mask of irq 75
> > [    3.563908]   EA = 0, S1PTW = 0
> > [    3.580792] Data abort info:
> > [    3.583673]   ISV = 0, ISS = 0x00000044
> > [    3.583900] NET: Registered protocol family 10
> > [    3.586785]   CM = 0, WnR = 1
> > [    3.586794] [dead000000000108] address between user and kernel address ranges
> > [    3.586806] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > [    3.591869] Segment Routing with IPv6
> > [    3.594829] Modules linked in:
> > [    3.594841] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted
> > 5.9.0-rc5-next-20200915 #1
> > [    3.594844] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    3.594862] Workqueue: events_unbound async_run_entry_fn
> > [    3.597959] NET: Registered protocol family 17
> > [    3.604991] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
> > [    3.605000] pc : __clk_put+0x40/0x140
> > [    3.605009] lr : __clk_put+0x2c/0x140
> > [    3.610613] 9pnet: Installing 9P2000 support
> > [    3.614183] sp : ffff80001005bbe0
> > [    3.614189] x29: ffff80001005bbe0
> > [    3.617233] Key type dns_resolver registered
> > [    3.624696] x28: 000000000000002e
> > [    3.624701] x27: ffff00003b620a68 x26: ffff800011496568
> > [    3.624708] x25: ffff00003fcfe8f8 x24: ffff00003d30c410
> > [    3.632518] registered taskstats version 1
> > [    3.636931] x23: ffff800011495cf8 x22: ffff00003b620a40
> > [    3.636938] x21: ffff00003d30c400 x20: ffff00003b620580
> > [    3.636945] x19: ffff00003b64f380 x18: 0000000007824000
> > [    3.636951] x17: ffff00003b620a00 x16: ffff00003b6205d0
> > [    3.636958] x15: ffff8000119929f8 x14: ffffffffffffffff
> > [    3.636965] x13: ffff800012947000 x12: ffff800012947000
> > [    3.636975] x11: 0000000000000020
> > [    3.641233] Loading compiled-in X.509 certificates
> > [    3.646650] x10: 0101010101010101
> > [    3.646654] x9 : ffff8000107b4c84 x8 : 7f7f7f7f7f7f7f7f
> > [    3.646661] x7 : ffff000009fe5880 x6 : 0000000000000000
> > [    3.646668] x5 : 0000000000000000 x4 : ffff000009fe5880
> > [    3.646674] x3 : ffff80001250d7a0 x2 : ffff000009fe5880
> > [    3.746653] x1 : ffff00003b64f680 x0 : dead000000000100
> > [    3.751949] Call trace:
> > [    3.757243]  __clk_put+0x40/0x140
> > [    3.759413]  clk_put+0x18/0x28
> > [    3.762885]  dev_pm_opp_put_clkname+0x30/0x58
> > [    3.765837]  sdhci_msm_probe+0x288/0x9a8
> > [    3.770265]  platform_drv_probe+0x5c/0xb0
> > [    3.774258]  really_probe+0xf0/0x4d8
> > [    3.778163]  driver_probe_device+0xfc/0x168
> > [    3.781810]  __driver_attach_async_helper+0xbc/0xc8
> > [    3.785717]  async_run_entry_fn+0x4c/0x1b0
> > [    3.790575]  process_one_work+0x1c8/0x498
> > [    3.794741]  worker_thread+0x54/0x428
> > [    3.798822]  kthread+0x120/0x158
> > [    3.802467]  ret_from_fork+0x10/0x30
> > [    3.805771] Code: 35000720 a9438660 f9000020 b4000040 (f9000401)
> > [    3.809334] ---[ end trace 1a607a5ea6891b9f ]---
> >
> > full test log link,
> > https://lkft.validation.linaro.org/scheduler/job/1765840#L2014
> > https://lkft.validation.linaro.org/scheduler/job/1765842#L1960
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> 
> Naresh, thanks for reporting!
> 
> There have been regressions related to the opp library this cycle, so
> I am wondering if Viresh may have any ideas, before going into more
> details.

I am really pissed at this. This is the exact bug we got earlier,
which Naresh also confirmed as being fixed after the patches I
proposed.

> One thing that also changed from the sdhci-msm point of view, is that
> we enabled async probe [1]. This could be the thing that triggers an
> untested error path of the probe?

Maybe, but I am not sure if this will cause such an issue. At max it
should cause issues for other stuff that depends on sdhci.

> Otherwise we can always try to revert "mmc: sdhci-msm: Unconditionally
> call dev_pm_opp_of_remove_table()", which I recently applied again
> after the earlier errors.

Yeah, that's the easiest of all.

I am trying to find someone with local 410c who can help me fix it in
realtime. Lets see.

-- 
viresh
