Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A821C64E8A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B6520731
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgTvw0bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgK3PJV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3PJU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 10:09:20 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7FC0613D2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 07:08:40 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a10so3834905uan.12
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oo/FBQBueWDd00EzjjP1iPUFL/XECO3UlBEDhq2h/3c=;
        b=kgTvw0bDMX5tcHNMAbwnTcEPGamvZGqYkvCeVd8u60O2P4buPHWUZD4hjpCCpKCls7
         00o8gJ5pKt3jEDcHfV9i0iRWRvzRBrjyZOn9oiZQOj5CMpOPZE61PK53fncZMRvCaPoX
         ytuJ9picx0e/7B8oXjvQLuckNUcw8KQmNgmq/hqSuxKREnPCQQzgJtlkD9IuZpd0oRzh
         vJF9AWahNpBcuQlabAiHJsLinPjtxgio3ZJfrTHINS32/uw5YVX32Ddsw83QF1tEUszD
         QddNCSxSuTTL24p9OWPJFDOQunYV0KNp4r3H1mVIk6Bav4sGoBFaKoeeDL356pyRA19i
         GaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oo/FBQBueWDd00EzjjP1iPUFL/XECO3UlBEDhq2h/3c=;
        b=uB3V9v1O4krmIOrjoy77RvfBXBnaW3VtBOyVSaliy/vIFRycdRyA4If0tMSuRd1RCd
         1b3lBgyTFcDgQMsNcGlbWQKuJb7vywKiXO5NF78A9K0jXjTZcyaB3olDRtl83CjEswQq
         9Tfu4YUKoykgUa03sKFVftYDPVp5CIdCyIlPmuAHRgJLxwShPoAeVfUm4JjCaP+NdxjB
         Gv3NKToFcFMedHdycpARu5Qu9diM50SVdaLVEblbY0pSCEAC2t5NiKMgz5o9p4iQbPD5
         e5v2VUyMDRP5e/5GOKNXhGBpV5OosD4NuSp//2sBndapaZLZQAYt4AMkhLrwQSkOTyJ4
         4ikw==
X-Gm-Message-State: AOAM531VvgVs+7ms+mSUHMDIaM3t7TJoA5ByrUvBeedpQ90rTeuPlmxT
        GXDBBr+n+xNgUlGsKu1jQkupl0nJ1ACrzUTEnZg/vyWCoxW+9KoY
X-Google-Smtp-Source: ABdhPJynFyHLFSQk/2ETJCHFnFPRt9+XPRb+zfMCwiW6pYdfHXa2NU3q1LYOLykRB9GSIcDA2uguoee+ryFCujWcdOY=
X-Received: by 2002:ab0:60b1:: with SMTP id f17mr13575257uam.104.1606748919488;
 Mon, 30 Nov 2020 07:08:39 -0800 (PST)
MIME-Version: 1.0
References: <c5252887-e4f9-953d-88df-d8cc62ecd136@eaxlabs.cz>
In-Reply-To: <c5252887-e4f9-953d-88df-d8cc62ecd136@eaxlabs.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Nov 2020 16:08:03 +0100
Message-ID: <CAPDyKFr8t-u_4YkuCzQ3Xd3VgxkTq_Anu+NzBo4Pfj8SLBnsvg@mail.gmail.com>
Subject: Re: armmmci rmmod causes hung tasks
To:     Martin DEVERA <devik@eaxlabs.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 29 Nov 2020 at 19:20, Martin DEVERA <devik@eaxlabs.cz> wrote:
>
> Hello,
>
> on STM32MP1 with almost vanilla 5.7.7 in single CPU mode. Pair of
> modprobe armmmci ; rmmod armmmci
>
> causes rmmod and kworker to hang. I should note that no MMC is detected
> on the board (SDIO device on MMC bus is not responding).
> On another board (where SDIO is responding) rmmod works.
>
> It seems as another manifestation of https://lkml.org/lkml/2019/8/27/945
>
> Thanks.
>
> INFO: task kworker/0:1:12 blocked for more than 368 seconds.
>        Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/0:1     D    0    12      2 0x00000000
> Workqueue: events_freezable mmc_rescan
> (__schedule) from (schedule+0x5b/0x90)
> (schedule) from (schedule_timeout+0x1b/0xa0)
> (schedule_timeout) from (__wait_for_common+0x7d/0xdc)
> (__wait_for_common) from (mmc_wait_for_req_done+0x1b/0x8c)
> (mmc_wait_for_req_done) from (mmc_wait_for_cmd+0x4d/0x68)
> (mmc_wait_for_cmd) from (mmc_io_rw_direct_host+0x87/0xc8)
> (mmc_io_rw_direct_host) from (sdio_reset+0x3b/0x58)
> (sdio_reset) from (mmc_rescan+0x15d/0x1d4)
> (mmc_rescan) from (process_one_work+0xdd/0x168)
> (process_one_work) from (worker_thread+0x17d/0x1ec)
> (worker_thread) from (kthread+0x9b/0xa4)
> (kthread) from (ret_from_fork+0x11/0x28)

It looks like the worker thread, which runs mmc_rescan() to try to
detect the SDIO card is hanging. Exactly why, I don't know.

Could be a misconfigured clock, pinctrl or a power domain being
suddenly gated...

>
> INFO: task rmmod:308 blocked for more than 368 seconds.
>        Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> rmmod           D    0   308    222 0x00000000
> (__schedule) from (schedule+0x5b/0x90)
> (schedule) from (schedule_timeout+0x1b/0xa0)
> (schedule_timeout) from (__wait_for_common+0x7d/0xdc)
> (__wait_for_common) from (__flush_work+0xb3/0x110)
> (__flush_work) from (__cancel_work_timer+0x97/0xf0)
> (__cancel_work_timer) from (mmc_stop_host+0x29/0x88)
> (mmc_stop_host) from (mmc_remove_host+0x9/0x22)
> (mmc_remove_host) from (mmci_remove+0x19/0x92 [armmmci])
> (mmci_remove [armmmci]) from (amba_remove+0x13/0x42)
> (amba_remove) from (device_release_driver_internal+0x89/0xe4)
> (device_release_driver_internal) from (driver_detach+0x57/0x60)
> (driver_detach) from (bus_remove_driver+0x53/0x84)
> (bus_remove_driver) from (mmci_driver_exit+0x9/0x11dc [armmmci])
> (mmci_driver_exit [armmmci]) from (sys_delete_module+0x115/0x154)
> (sys_delete_module) from (ret_fast_syscall+0x1/0x5a)
>

When unbinding the mmc host, mmc_stop_host() needs to make sure that
mmc_rescan() becomes disabled. This is to prevent a card from being
detected/removed at same time as when the host is being removed.

In any case, when we call...

cancel_delayed_work_sync(&host->detect);

...it seems like we end up waiting for the currently running
mmc_rescan() work to be completed.

Kind regards
Uffe
