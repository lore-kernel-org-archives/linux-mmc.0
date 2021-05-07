Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C5C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BFA61458
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhEGLk2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhEGLk2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 07:40:28 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3848C061574
        for <linux-mmc@vger.kernel.org>; Fri,  7 May 2021 04:39:26 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id h1so2741510uar.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 May 2021 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOAvVsXjzC/DT4HN7XbmniRbk3KgKOLcZddilQid+b0=;
        b=PIIl0qvKO5RPmusfE2bol16/Pw5JNmuoSs6hZn2V8OtFm8K00HUNIlb56tUbCe2DUN
         uacoBtystMHLIu5IE7HyUfteV7sK/CNfe5YIgTjovwItZpo4aUC86HTTm0f0Xx6dome+
         CyFTEVncVeg0q9INUbd3q7ggxq5nam6V2peNOG5wIYO2Fgsy2Fru1gntgi9EgclVg2g7
         N+rb1m8fdWRTgd/ixqLAiNiuFNt4xvx+AWHWf0UhI3aHqkluLylcw1LJUmu/0M1WJOCa
         wtyEr2NHbQsmJLc6heN4B9r+XQdjDKMJS0zqg3zpVYN3W41jMm1Yj5R9jyHQR4KcXrCi
         /UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOAvVsXjzC/DT4HN7XbmniRbk3KgKOLcZddilQid+b0=;
        b=l3XrxlYiyTVJSDE/kclvkyj3oIB5xXRH4hQaCvf00D/ynESX4i5UOvVuMhVLuFzjF9
         bODOq+z45bqSGIAxgkXu6Ixr4Ws5iI28W6VzQ//xmSp30nO8V9/2ymboX4SmWFnXuyrQ
         gjXy8SmuLnih2D7A1uSe2GyqDIKtf2rkGBlXnISTuwbwRjZw/X85K6OR0bntG9cjN0Uz
         KoCOtR4/9f/2/Zsib2KWQ2kJc234aQU+g9r0kwjQhEatIX1aTiVZaK5GbdZXwVH//Jt1
         ecc8VFpwx6+4SSQQcGnoFU0PCdEStdtn/ukTBIA7BK7A6OhpE+aDRnFKSkXb2Tlmmqob
         XO3g==
X-Gm-Message-State: AOAM532s7A8erRP4Xis7vTKsgpFDPVUQWFFPHDWkvmOBuv/+lWYYp2Pi
        Ww/x5rp+aIN5fhh8Iwb5vqIInmPmetaizOfQjSW2cw==
X-Google-Smtp-Source: ABdhPJwTeUB+QWASRpKFyQIvFIFoIUX4/chhdSv+mIuPXh7ytxq6tKVBBGmRl9/fY6ULg5uqL6Gmuu4oJlD5MWew6ms=
X-Received: by 2002:ab0:5fdb:: with SMTP id g27mr8005163uaj.15.1620387565882;
 Fri, 07 May 2021 04:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
 <CAMjpFAW0D12vxNSYLcwSWxf-zB+toT5cmiQ8mtUUE+nzWMJZ3g@mail.gmail.com> <CAPDyKFqqRY3rj9zzzDvPTCO68abfQ+G-siAJVgdPuESUwko28A@mail.gmail.com>
In-Reply-To: <CAPDyKFqqRY3rj9zzzDvPTCO68abfQ+G-siAJVgdPuESUwko28A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 13:38:49 +0200
Message-ID: <CAPDyKFoAQX3xe0=LYhbScx-bs97imGgnVJCpzvTirxszcUY03w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     chgokhl@163.com
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Mar 2021 at 15:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Mar 2021 at 11:49, hieagle <chgokhl@gmail.com> wrote:
> >
> > We encounter a resume issue in our device sometimes. The mmc device's
> > parent list is
> > mmc0:0001->mmc_host mmc0->fa630000.mmc->soc in our soc. We found in the blow
> > case with mmc0->power.disable_depth=0 the mmc_runtime_resume will be skipped,
> > which cause subsequent mmc command fail.
> >
> > mmc_get_card(mmc0:0001)->pm_runtime_get_sync->rpm_resume(mmc0:0001)->rpm_resume(mmc0)
> > The rpm_resume(mmc0) return -ENOSYS due to no callback and
> > mmc0->power.runtime_status
> > keep RPM_SUSPENDED. This lead to rpm_resume(mmc0:0001) return -EBUSY and skip
> > rpm_callback which call mmc_runtime_resume, the mmc is still in
> > suspended and the
> > subsequent mmc command fail.
> >
> > [  198.856157] Call trace:
> > [  198.858917] [<ffffff800808bd9c>] dump_backtrace+0x0/0x1cc
> > [  198.864966] [<ffffff800808bf7c>] show_stack+0x14/0x1c
> > [  198.870627] [<ffffff8008400e88>] dump_stack+0xa8/0xe0
> > [  198.876288] [<ffffff800854d38c>] rpm_resume+0x850/0x938
> > [  198.882141] [<ffffff800854cd8c>] rpm_resume+0x250/0x938
> > [  198.887994] [<ffffff800854d4c4>] __pm_runtime_resume+0x50/0x74
> > [  198.894530] [<ffffff80087b9e64>] mmc_get_card+0x3c/0xb8
> > [  198.900388] [<ffffff80087cd2e0>] mmc_blk_issue_rq+0x2b0/0x4d8
> > [  198.906824] [<ffffff80087cd5e4>] mmc_queue_thread+0xdc/0x198
> > [  198.913165] [<ffffff80080d4b2c>] kthread+0xec/0x100
> > [  198.918632] [<ffffff8008083890>] ret_from_fork+0x10/0x40
> > [  198.924582] mmc0  callback           (null)
> > [  198.935837] mmcblk mmc0:0001: __pm_runtime_resume ret -16
> >
> > Mark mmc_host device with pm_runtime_no_callbacks will solve the issue.
> > Thanks.
> > Huanlin Ke
>
> Thanks for sharing more details! I have to admit, that this sounds
> quite weird to me. I wonder if this is a problem that deserves to be
> fixed in the runtime PM core....
>
> Let me have a closer look a get back to you again. Please be patient
> though, I have a busy week in front of me.

Just wanted to notify you that I haven't forgotten. I will look into
this beginning of the next week.

[...]

Kind regards
Uffe
