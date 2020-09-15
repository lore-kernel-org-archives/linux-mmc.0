Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238EC433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A802078D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 23:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuQZl+5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIOXrp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 19:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIOOdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 10:33:23 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE1C061788
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 07:33:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a16so1995659vsp.12
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2020 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=p/yQGVz5fe7W1l/XMybVgvb/Lq+/vuJm4F2nqOi4Uy0=;
        b=HuQZl+5yEL80JNR162wBgmVt3OdqHkNn8iHM4g1CYCd+zK3L7jbnkHeA98opEoWYyR
         r05XsjGUCY7BpN8xWrHItSm25Dy70wSY1/NOnCFsOYEdLzvsAxSA40rL+5pBBVS/6jtb
         cwmLwhs7wKHEuT87RTxPPT2hJsT2QNfRyIX7w033kFzXHZxTcQ0i5ld0SCByloYQ0iHF
         ujJDbYFv+9tpjtPlqJOxJM4m1egvh3AoXdWRUM0QBIS/v6XHjj1RzI/iZrWe/EiPRT+2
         uqYoM/Y7e5qj+I3ivaSC7bG1bSKpICNTzir0zSAjd/ESIvlX+vOsit8Ef5KzCo35diXN
         aHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p/yQGVz5fe7W1l/XMybVgvb/Lq+/vuJm4F2nqOi4Uy0=;
        b=Vj7a4o3kSRw8bOU5+QFmbCIrfgwqoOlZKrHZTzGbyq80jrXUpXhszTs9ngPTAt7VAC
         /iCddoWMYhtoT9+J9BJWFTwJrn57dYwuZevyz4OTMjbZEgZgUmylwLcFhBx/62vlZ77O
         PcR56WDS1OVBjqRkXFOgGZryy3OXR9kjJ6NkMzkSsuj3moJ2qpXX1YfOYdtTH8SCotbM
         3775Xm96K3sfPxy4mqJ1N9mKpbQ5OK9f8FtY4ATnIwTJfk3VJPnyMfGXJ8/21+cfv22S
         Om0fgGtm1Q0AJ8QbsXZaspWL214lJD+rkefX4bov8P9URC+LKi02gu6bcwksoIITj007
         h5kw==
X-Gm-Message-State: AOAM533a03btKqeO9K6WSzrr7+/pOAmKNeJyo7150DmBtnZdUVp3/H8S
        qq8VAA5GZhLofxDbwJvOGMB1mzXwPAQGWNrQ82ffag==
X-Google-Smtp-Source: ABdhPJwT5Pd+5fBeOKGtGHzst/KmWtPdm52ldHrwJZIJWHDFzAbHiqFeonOMHfEcqQEDv+llWjhbO3+b/n9EMVQ48Lk=
X-Received: by 2002:a67:8c48:: with SMTP id o69mr1427354vsd.39.1600180393158;
 Tue, 15 Sep 2020 07:33:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Sep 2020 20:03:01 +0530
Message-ID: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
Subject: Unable to handle kernel paging request at virtual address dead - __clk_put
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-clk <linux-clk@vger.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

arm64 dragonboard-410c boot failed while running linux next 2020915 due to
the kernel crash.

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20200915
  make_kernelversion: 5.9.0-rc5
  kernel-config:
https://builds.tuxbuild.com/J5oDTkph2aj855oeGOd45Q/kernel.config


crash log:
-------------
[    3.517615] Synopsys Designware Multimedia Card Interface Driver
[    3.524258] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.531302] Unable to handle kernel paging request at virtual
address dead000000000108
[    3.531396] Mem abort info:
[    3.531460] sdhci_msm 7864900.sdhci: Got CD GPIO
[    3.539182]   ESR = 0x96000044
[    3.541953] ledtrig-cpu: registered to indicate activity on CPUs
[    3.546692]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.546701]   SET = 0, FnV = 0
[    3.555694] usbcore: registered new interface driver usbhid
[    3.555703] usbhid: USB HID core driver
[    3.561638] genirq: irq_chip msmgpio did not update eff. affinity
mask of irq 75
[    3.563908]   EA = 0, S1PTW = 0
[    3.580792] Data abort info:
[    3.583673]   ISV = 0, ISS = 0x00000044
[    3.583900] NET: Registered protocol family 10
[    3.586785]   CM = 0, WnR = 1
[    3.586794] [dead000000000108] address between user and kernel address ranges
[    3.586806] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[    3.591869] Segment Routing with IPv6
[    3.594829] Modules linked in:
[    3.594841] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted
5.9.0-rc5-next-20200915 #1
[    3.594844] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    3.594862] Workqueue: events_unbound async_run_entry_fn
[    3.597959] NET: Registered protocol family 17
[    3.604991] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    3.605000] pc : __clk_put+0x40/0x140
[    3.605009] lr : __clk_put+0x2c/0x140
[    3.610613] 9pnet: Installing 9P2000 support
[    3.614183] sp : ffff80001005bbe0
[    3.614189] x29: ffff80001005bbe0
[    3.617233] Key type dns_resolver registered
[    3.624696] x28: 000000000000002e
[    3.624701] x27: ffff00003b620a68 x26: ffff800011496568
[    3.624708] x25: ffff00003fcfe8f8 x24: ffff00003d30c410
[    3.632518] registered taskstats version 1
[    3.636931] x23: ffff800011495cf8 x22: ffff00003b620a40
[    3.636938] x21: ffff00003d30c400 x20: ffff00003b620580
[    3.636945] x19: ffff00003b64f380 x18: 0000000007824000
[    3.636951] x17: ffff00003b620a00 x16: ffff00003b6205d0
[    3.636958] x15: ffff8000119929f8 x14: ffffffffffffffff
[    3.636965] x13: ffff800012947000 x12: ffff800012947000
[    3.636975] x11: 0000000000000020
[    3.641233] Loading compiled-in X.509 certificates
[    3.646650] x10: 0101010101010101
[    3.646654] x9 : ffff8000107b4c84 x8 : 7f7f7f7f7f7f7f7f
[    3.646661] x7 : ffff000009fe5880 x6 : 0000000000000000
[    3.646668] x5 : 0000000000000000 x4 : ffff000009fe5880
[    3.646674] x3 : ffff80001250d7a0 x2 : ffff000009fe5880
[    3.746653] x1 : ffff00003b64f680 x0 : dead000000000100
[    3.751949] Call trace:
[    3.757243]  __clk_put+0x40/0x140
[    3.759413]  clk_put+0x18/0x28
[    3.762885]  dev_pm_opp_put_clkname+0x30/0x58
[    3.765837]  sdhci_msm_probe+0x288/0x9a8
[    3.770265]  platform_drv_probe+0x5c/0xb0
[    3.774258]  really_probe+0xf0/0x4d8
[    3.778163]  driver_probe_device+0xfc/0x168
[    3.781810]  __driver_attach_async_helper+0xbc/0xc8
[    3.785717]  async_run_entry_fn+0x4c/0x1b0
[    3.790575]  process_one_work+0x1c8/0x498
[    3.794741]  worker_thread+0x54/0x428
[    3.798822]  kthread+0x120/0x158
[    3.802467]  ret_from_fork+0x10/0x30
[    3.805771] Code: 35000720 a9438660 f9000020 b4000040 (f9000401)
[    3.809334] ---[ end trace 1a607a5ea6891b9f ]---

full test log link,
https://lkft.validation.linaro.org/scheduler/job/1765840#L2014
https://lkft.validation.linaro.org/scheduler/job/1765842#L1960

-- 
Linaro LKFT
https://lkft.linaro.org
