Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C52C761AF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Mar 2023 15:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXPrC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCXPrB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2023 11:47:01 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7F19B7
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 08:46:57 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544787916d9so39519167b3.13
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679672817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbMU26KvuDhxRgS5BOOObuB6VM/WTbVMpAKkjnkzln4=;
        b=tDh/YhuOk5MCCESde0mwLUN2BM1Dl78t7pzTqGBP9gGT6jOMYEpc+CRHwZX5mzF8k8
         G3yLu/rV1fzHghME0JzOx5ym1akTHmDTITeWXNib3v8Girj/HudNG0P3TRI6UkSD8LYa
         ohvdkjbro+niCkywe81tZrIVijZfwEFwlzEEoKz8DJAR5vYY6W9GtvRvS7dkQy9NEolC
         CHjWutu/1tUWd8Q/iODL4HUNL0U+VshrMfE1bGDkbYL8iro6rEfRXrli2843wuaF0ibK
         pLrdgjdb7P4RdOR0e4XVJmJQosMHFo6mcEgsCbw0pZQFBhZfdzVqOHIjFmREgMdXWaql
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbMU26KvuDhxRgS5BOOObuB6VM/WTbVMpAKkjnkzln4=;
        b=plmNJJ5lJW3QPwoNrBdb+hD8xxZpT6paWUdaKY5dQqgHEsAJNrskRm3xRgkezonS1d
         kedmQplZhvJgfcOQF/8kWahUVYEpCj5szwUILFmI8cV6/wTcebLWKxilgMem2qvHqWum
         +Yj3lxJe+eMVYXchYUxunO9apcgnuNTk5lzmQ+kO55+v4hjdneZLSDp7g7NArduuypIM
         yQ8icyKhWj8DfadVxZl4EO4jYd0vYOxkWgxbai+AJ8OQwkeeNPqwnlMTCWzKBh61WPHx
         xcY0eZc5Ar/8yaVcSbnvxkzWikpzMmt3La/+NA3ew83JgwYiUKLYggJktY+lS5aoVOxf
         0EcQ==
X-Gm-Message-State: AAQBX9c+Pm8sHct3PHHaaYhH590kWGBw/fJFEmBYdzYEpJ7yFC6dbWfE
        m1UH/850g2UTdvnxN/R41SQ8rB+6RF60Edjr7m9dRg==
X-Google-Smtp-Source: AKy350ZrRmEOfSH9HdqIpxODwcFPtiWHoT78R7Alcg8WWhH4HeDKnIqzoPGfqP55wsLi0hO4jXGqCNIiHfxxN53t7AM=
X-Received: by 2002:a81:ae23:0:b0:52b:fd10:4809 with SMTP id
 m35-20020a81ae23000000b0052bfd104809mr1306472ywh.0.1679672815533; Fri, 24 Mar
 2023 08:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5@eucas1p2.samsung.com>
 <20230317064729.24407-1-yuzhe@nfschina.com> <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
In-Reply-To: <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Mar 2023 16:46:19 +0100
Message-ID: <CAPDyKFotp50rbyFqBzk28iXFVqUnXry5XzyA-jrBKVrDW3_a-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Zhe <yuzhe@nfschina.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Mar 2023 at 14:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 17.03.2023 07:47, Yu Zhe wrote:
> > Pointer variables of void * type do not require type cast.
> >
> > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > ---
> >   drivers/mmc/core/debugfs.c  | 2 +-
> >   drivers/mmc/core/host.c     | 2 +-
> >   drivers/mmc/core/mmc_test.c | 6 +++---
> >   3 files changed, 5 insertions(+), 5 deletions(-)
> ...
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 096093f7be00..76900f67c782 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> >
> >   static void devm_mmc_host_release(struct device *dev, void *res)
> >   {
> > -     mmc_free_host(*(struct mmc_host **)res);
> > +     mmc_free_host(res);
>
> The above chunk is wrong and causes following regression on today's
> Linux next-20230324:
>
> Unable to handle kernel paging request at virtual address 0000000000001020
> Mem abort info:
> meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
> ...
> [0000000000001020] user address but active_mm is swapper
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 10 Comm: kworker/u12:0 Not tainted 6.3.0-rc3-next-20230324+
> #13452
> Hardware name: Khadas VIM3 (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mmc_pwrseq_free+0x1c/0x38
> lr : devm_mmc_host_release+0x1c/0x34
> ...
> Call trace:
>   mmc_pwrseq_free+0x1c/0x38
>   devm_mmc_host_release+0x1c/0x34
>   release_nodes+0x5c/0x90
>   devres_release_all+0x8c/0xdc
>   device_unbind_cleanup+0x18/0x68
>   really_probe+0x11c/0x2b4
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0xd8/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x84/0xe0
>   __device_attach_async_helper+0xb0/0xd4
>   async_run_entry_fn+0x34/0xe0
>   process_one_work+0x288/0x5c0
>   worker_thread+0x74/0x450
>   kthread+0x124/0x128
>   ret_from_fork+0x10/0x20
> Code: f9000bf3 aa0003f3 f9424c00 b4000080 (f9401000)
> ---[ end trace 0000000000000000 ]---
>
> Ulf: do You want me to send a partial revert or will you handle it by
> dropping this patch?

Thanks for the report, I will simply drop the patch!

Kind regards
Uffe
