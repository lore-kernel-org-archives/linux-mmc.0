Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DBDC433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D0E65285
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCINHw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCINHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 08:07:52 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06580C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 05:07:52 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 7so2964180vke.5
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF1q+KHLYeg9PARRubURS44/XLlGrXojNUNqT/ZaSAY=;
        b=e6hTNRwIW5GQzGgjIt62VyQqBewR9ou9Qge8/RtQatC/FXEy76e5lOGmKe+VoRK36p
         +2YFIrEYeEgkDUSTBx18PO/V6wXvvRZsO+Gn36kiPelooqfHJw3UdRm99qRQU8gW3dH3
         oGT4Zf9vtIV6DoJY5eOoj7+ErPHnbrCWFq1BG6ok1qRIHnqBWVERe83h6I00JGOKolvv
         xJ0SveLEwpPiHdpZ+nhm6yHBosVk54kGUUfZRRNFr5vVOtH57LkWrdMTtzoYGC42flTQ
         JQN4l6uxHpkf05Yo2em8uOSanpSpcn2aJBbZBlYR3YdFVmgFj9nRhQGhgwCgh/CXQR4x
         cCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF1q+KHLYeg9PARRubURS44/XLlGrXojNUNqT/ZaSAY=;
        b=cYecODGDswKpPuJUKhMWrBaCLtwnHCW0/RK0xzL/+zBBORt3TVaXEO0wwCl3/EIi5u
         45ROpIcpeSqgc/O/4v4dfKcOaAy51678XGREsliSX4y2UKNdl9A42cHLLHvPR6RUMdzo
         JRrntvoQ1a9J4LXoamvtCTnnxZIJf4Ng7PnCq5ASaqXE4IF4FslsdGlagj0O/5tlyYmL
         4VkySnaQxq5mNPxyW9SRvSvc0UqqZni/c3ZmM0w86UrB6nodl3mcK4Ii4ygexWHDafHV
         oBd1TICvs47f9bVsMvkpGy05ZAjCqA3FpRkfBqOFBnNORz1CAdeNZPra7SNdgnbctibI
         4FAA==
X-Gm-Message-State: AOAM530WdXWL4rEHspQBtt11gwldVEGlNiR2+jGg78kDakY6cpYa45Hx
        iGHvbLpWPPbc+2Zzb6lIiEb4L/GYRSqVaEAyZg9Ppg==
X-Google-Smtp-Source: ABdhPJyELv0aZKin4L0hl7Cc8HCBq4OeQ15nevZqqQxjiOlGQDXyk/wpaRuC1xQMKpKh13cQADSSmksU+TukvW5lsjk=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr16827653vke.6.1615295271005;
 Tue, 09 Mar 2021 05:07:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b@epcas2p4.samsung.com>
 <02da01d7149a$35dec530$a19c4f90$@samsung.com>
In-Reply-To: <02da01d7149a$35dec530$a19c4f90$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 14:07:14 +0100
Message-ID: <CAPDyKFpeCWp6JUS4w9h1K7ZLjvE0JuREuWgrsuQSzD7dOJBHGw@mail.gmail.com>
Subject: Re: About a possibility of long latency to claim host
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Mar 2021 at 05:11, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
>
> Dear All
>
> I want to discuss about this topic with you guys.
>
> There is an application to put many IO requests to a SD card right after completion of system resume.
> Current MMC stack invokes mmc_rescan asynchronously for PM_POST_SUSPEND.
> As reported to me, there could be a race between an IO thread and the kworker for mmc_rescan,
> especially when the application mentioned before is installed and the function of mmc_rescan is run later than expected
> For a series of IO requests, mmc_rescan, particularily at __mmc_claim_host called in mmc_sd_detect, didn't acquire a host for longer than expected.

That's not a problem, in general.

As long as the card is inserted and functional, the I/O operations
should be completed successfully. It doesn't matter if mmc_rescan() is
waiting to claim the host, as it's not important that it gets to run
as long as the card remains inserted/functional.

>
> Below is the call stacks shown after the symptom happened and the system tried to enter into suspend again.
> In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it waits for completion or cancelling the work for mmc_rescan.
> For the latency, mobile users can see black screen for a long time sometimes, even with pushing a power button to wake up the system.

I think I understand what you are saying, but please correct me if I am wrong.

The I/O requests keep flowing into the blk queue even after
PM_SUSPEND_PREPARE has been fired, thus preventing the earlier
scheduled mmc_rescan() from claiming the host?

This sounds quite reasonable that it could happen, at least
theoretically. Although, I am a bit surprised that nobody has reported
about this problem, until now. The design in the mmc core, has
remained unchanged in regards to this behaviour, for a very very long
time.

Let me try to reproduce the problem, I will get back to you soon. In
the meantime, I would also appreciate it if you could share, more
exactly, how to trigger this problem at your side.

>
> If there is another way to fix it w/o any change, please let me know.
> Or I want to post a patch not to do _mmc_detect_change conditionally
> because it helps remove the race and the case assumes SD card initialization is already done.

Unfortunately, it's not as easy as that, because we need to detect
whether a removable card has been removed after the system has
resumed.

There are other ways to solve this, but allow me to think a little
more about it and get back to you.

>
> --
> <6>[ 3965.259816] I[0:      swapper/0:    0]    22631        0      227    3902403994884 D(2)   3  ffffffc0007ee338                0  ffffffc85678e000 *    kworker/u16:4 [__mmc_claim_host]
> <6>[ 3965.259839] I[0:      swapper/0:    0] Workqueue: kmmcd mmc_rescan
> <0>[ 3965.259854] I[0:      swapper/0:    0] Call trace:
> <4>[ 3965.259870] I[0:      swapper/0:    0] [<ffffffc00013e674>] __switch_to+0x80/0x90
> <4>[ 3965.259886] I[0:      swapper/0:    0] [<ffffffc000b137f4>] __schedule+0x530/0x76c
> <4>[ 3965.259902] I[0:      swapper/0:    0] [<ffffffc000b13a9c>] schedule+0x6c/0x7c
> <4>[ 3965.259919] I[0:      swapper/0:    0] [<ffffffc0007ee338>] __mmc_claim_host+0xb8/0x188
> <4>[ 3965.259937] I[0:      swapper/0:    0] [<ffffffc0007eebfc>] mmc_get_card+0x24/0x38
> <4>[ 3965.259956] I[0:      swapper/0:    0] [<ffffffc0007f5c44>] mmc_sd_detect+0x90/0xe8
> <4>[ 3965.259973] I[0:      swapper/0:    0] [<ffffffc0007f08d8>] mmc_rescan+0xa0/0x2ec
> <4>[ 3965.259991] I[0:      swapper/0:    0] [<ffffffc0001688e0>] process_one_work+0x26c/0x434
> <4>[ 3965.260008] I[0:      swapper/0:    0] [<ffffffc000168dc8>] worker_thread+0x320/0x444
> <4>[ 3965.260026] I[0:      swapper/0:    0] [<ffffffc00016dac0>] kthread+0xdc/0xec
> ..
> <0>[ 3965.259854] I[0:      swapper/0:    0] Call trace:
> <4>[ 3965.259870] I[0:      swapper/0:    0] [<ffffffc00013e674>] __switch_to+0x80/0x90
> <4>[ 3965.259886] I[0:      swapper/0:    0] [<ffffffc000b137f4>] __schedule+0x530/0x76c
> <4>[ 3965.259902] I[0:      swapper/0:    0] [<ffffffc000b13a9c>] schedule+0x6c/0x7c
> <4>[ 3965.259919] I[0:      swapper/0:    0] [<ffffffc0007ee338>] __mmc_claim_host+0xb8/0x188
> <4>[ 3965.259937] I[0:      swapper/0:    0] [<ffffffc0007eebfc>] mmc_get_card+0x24/0x38
> <4>[ 3965.259956] I[0:      swapper/0:    0] [<ffffffc0007f5c44>] mmc_sd_detect+0x90/0xe8
> <4>[ 3965.259973] I[0:      swapper/0:    0] [<ffffffc0007f08d8>] mmc_rescan+0xa0/0x2ec
> <4>[ 3965.259991] I[0:      swapper/0:    0] [<ffffffc0001688e0>] process_one_work+0x26c/0x434
> <4>[ 3965.260008] I[0:      swapper/0:    0] [<ffffffc000168dc8>] worker_thread+0x320/0x444
> <4>[ 3965.260026] I[0:      swapper/0:    0] [<ffffffc00016dac0>] kthread+0xdc/0xec
> ..
> <0>[ 3965.203379] I[0:      swapper/0:    0] Call trace:
> <4>[ 3965.203397] I[0:      swapper/0:    0] [<ffffffc00013e674>] __switch_to+0x80/0x90
> <4>[ 3965.203414] I[0:      swapper/0:    0] [<ffffffc000b137f4>] __schedule+0x530/0x76c
> <4>[ 3965.203430] I[0:      swapper/0:    0] [<ffffffc000b13a9c>] schedule+0x6c/0x7c
> <4>[ 3965.203448] I[0:      swapper/0:    0] [<ffffffc000b160e8>] schedule_timeout+0x28/0x214
> <4>[ 3965.203464] I[0:      swapper/0:    0] [<ffffffc000b145a0>] wait_for_common+0x114/0x15c
> <4>[ 3965.203482] I[0:      swapper/0:    0] [<ffffffc000b14710>] wait_for_completion+0x10/0x20
> <4>[ 3965.203498] I[0:      swapper/0:    0] [<ffffffc000169990>] flush_work+0xf0/0x11c
> <4>[ 3965.203516] I[0:      swapper/0:    0] [<ffffffc000169ad0>] __cancel_work_timer+0x114/0x1a0
> <4>[ 3965.203533] I[0:      swapper/0:    0] [<ffffffc000169c44>] cancel_delayed_work_sync+0xc/0x1c
> <4>[ 3965.203554] I[0:      swapper/0:    0] [<ffffffc0007f1000>] mmc_pm_notify+0x78/0x12c
> <4>[ 3965.203573] I[0:      swapper/0:    0] [<ffffffc00016ebf4>] notifier_call_chain+0x7c/0xec
> <4>[ 3965.203590] I[0:      swapper/0:    0] [<ffffffc00016ef08>] __blocking_notifier_call_chain+0x44/0x68
> <4>[ 3965.203608] I[0:      swapper/0:    0] [<ffffffc00016ef3c>] blocking_notifier_call_chain+0x10/0x20
> <4>[ 3965.203628] I[0:      swapper/0:    0] [<ffffffc0001964ec>] pm_notifier_call_chain+0x1c/0x44
> <4>[ 3965.203644] I[0:      swapper/0:    0] [<ffffffc000197ad0>] pm_suspend+0x2e0/0x5fc
> <4>[ 3965.203662] I[0:      swapper/0:    0] [<ffffffc0001961cc>] state_store+0x4c/0x8c
> <4>[ 3965.203683] I[0:      swapper/0:    0] [<ffffffc0003f35ec>] kobj_attr_store+0x14/0x2c
> <4>[ 3965.203703] I[0:      swapper/0:    0] [<ffffffc0002aac2c>] sysfs_kf_write+0x40/0x50
> <4>[ 3965.203721] I[0:      swapper/0:    0] [<ffffffc0002aa000>] kernfs_fop_write+0xfc/0x148
> <4>[ 3965.203739] I[0:      swapper/0:    0] [<ffffffc000249b4c>] vfs_write+0xb8/0x190
> <4>[ 3965.203755] I[0:      swapper/0:    0] [<ffffffc000249cf0>] SyS_write+0x44/0x88

Kind regards
Uffe
