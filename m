Return-Path: <SRS0=Ubev=IG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F23C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C5C651D3
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 11:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHLdG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhCHLct (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 06:32:49 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094F4C06174A
        for <linux-mmc@vger.kernel.org>; Mon,  8 Mar 2021 03:32:49 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id b189so4652926vsd.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Mar 2021 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7j5Ym8di/S9MMBAyH8gxfLYD6RZeMR3DvmAm26nMwd8=;
        b=tV4kL+rFMzgtqv+9mPMtlY8E8ogmIC18X83EcBWAIHRTU9dA04Rq/9y2lnJGMQ/nV0
         cV3c0FwkeNfbndU/WxEjtyo9a5A6LE7t1c6RCdHJQDX3GoYtqRgLM026/pqTalGrQ6EE
         LChfS9Ep3H/v/hpnJHcu0wA5oIP/cgXjI9XOTNLUFAAun7hCLgk39EAv9y2z94LqRLzY
         rEI5Xakay17uQGZAV3CPX0DhgBflZ+W4AcrbbgDnXoCTZIK6LpQ3HrUe79q8wUV4PxF5
         b3TkErrwoaim4XVsPC4SQQYfXwJ88EvTXi/M0PPYDB2p6cgMpadM3uXT05oV8nQtEGda
         Myyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7j5Ym8di/S9MMBAyH8gxfLYD6RZeMR3DvmAm26nMwd8=;
        b=K+IvY1qIflo2ItZrm9ppxk234MVPGKxJMLlfQK4KZCCxwHzFv7Wuu3rqX23s+25jA9
         Tg+78eNLCFBY79X8iTiSq9yVyuahf7KGZuOsiEM8hl42cOIiDZUfELC+8fi/QugMlGgy
         D3l6EaWLzqNx4Q9IhXPoQOrqtgTYcpZkHgsNeNoH6TCY87TUaZnFnpodOC8rnfCy0T/0
         zafYOCwJ/+K6t/D+YrifGFfqYRb4qMCYfpVc0tT3sX83PTvI+/+vkkQXixkrURhrag61
         cMCsChCcbhbAyNSBb6ELR96UCQrPvUvk9JDneu64jVQ4JM9xLD1/Q9z0Kih9w/+PjB77
         xdpQ==
X-Gm-Message-State: AOAM530e0lh5HWUUCnLuHU2E1nWk9t5tjp9CYHxliuqYD4BObMuci0nT
        oWoZYS5PFSnZEuQYyUW5o6BVkre8xkYxDtRODpCmQA==
X-Google-Smtp-Source: ABdhPJyqwO2kUWusG8tUPLQQI6MMaSMCDzhHKDIkdGvq50Wj71ZBiKuNIVHZb8P0idzmfOkk0fvCi7ObWdOvQce0838=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr10558498vsg.34.1615203168156;
 Mon, 08 Mar 2021 03:32:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07@epcas2p1.samsung.com>
 <000001d7100e$b7380f50$25a82df0$@samsung.com> <CAPDyKFr0x7vinYpy=AHcYfqxO-Q_S+SuU_SUb+kRTxRkNm4G6A@mail.gmail.com>
 <008b01d710ca$1207fab0$3617f010$@samsung.com>
In-Reply-To: <008b01d710ca$1207fab0$3617f010$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Mar 2021 12:32:11 +0100
Message-ID: <CAPDyKFprcns85m2aVocrK-M7Cmwi3_Vjc5FRgv+-Z+p5TdW3JA@mail.gmail.com>
Subject: Re: About SD initialization at resume time
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Mar 2021 at 08:43, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
>
> > > This is what had actually happened and was fixed with some code in
> > commercial products.
> >
> > The above code in the mmc core was introduced around kernel v3.11, even if
> > it has been fine tuned since then.
> >
> > Maybe you have been using even older kernels?
> >
> Dear Uffe
>
> First, you give me what I want.
> We've used higher versions than 3.11 but applied our own changes for some reasons.
> Anyway, thanks !
>
> That is the first problem for me on SD.
> The 2nd thing is very long latency issue for a race between an IO thread and a kworker to run mmc_rescan.
>
> There is an application to put many IO requests to a SD card right after completion of system resume.
> Current MMC stack invokes mmc_rescan is invoked asynchronously for PM_POST_SUSPEND.
> As reported to me, however, there could be a race between an IO thread and the kworker for mmc_rescan
> especially the function of mmc_rescan is run later than expected and the application mentioned before is installed.
>
> For a series of IO requests, mmc_rescan, particularily at __mmc_claim_host called in mmc_sd_detect,
> doesn't acquire a host for longer than expected.
> Below is the call stacks shown after the symptom happened and the system tried to enter into suspend again.
> In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it waits for completion or cancelling the work for mmc_rescan.
> For the latency, users can see black screen for a long time sometimes.
>
> So I want to post a patch not to do _mmc_detect_change conditionally
> because it helps remove the race and the case assumes SD card initialization is already done.
> If you have your different views, please let me know.

This is getting hard to discuss, as you are bringing up several
different things in the same email thread.

Please repost this as a separate bug-report to continue the discussion there.

Kind regards
Uffe

>
> Thanks.
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
>
