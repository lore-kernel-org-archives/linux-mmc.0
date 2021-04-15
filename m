Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EEC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F726610E6
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhDOI5M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhDOI5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 04:57:12 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4054C061574
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:56:49 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k128so1517916vke.9
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEUSHdKFAjl92shRCBXj7lhXkk+8/3c0TTVgZccIEZQ=;
        b=yuqEySmDxKqh4AGCyh9z0KZKBRPyvBVV+DINAo3qcJSpNQ6K71ODh6meWF5aVgaoiV
         Z5tscF8QneWpYprlFvEtbAOgekbF29oU3ygBXzvjQbIOr7hK+m1v47xT65AW8rJ4my7U
         DLCLgSSVfPNJzj00cgQMz3YX5LnydN9sNURrVaCdFugJ7r9DLPXtupfqbLi0hrMQa+T7
         0BYs0wWOP35td33+OPMDhyrL++2oM6RKM3Aaw2H2AT0tIBe6g/ZKNPHnXHuaf7uN3Xgi
         mKwk1fFTJXKVp4AH/HnKZXLGGvVj5xJcV+LnJIeTFB8hWkeUmg8oFWtmiuFOA6ZLSNmf
         0g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEUSHdKFAjl92shRCBXj7lhXkk+8/3c0TTVgZccIEZQ=;
        b=bpRtdGN7GadqsetrcSYpW3oiIw2h3O+i+P5HxAfwt3BAJKRj311o8Zs1uHKRcV9Ipm
         BbHcXegq59uxW8qbwhbk43gH1oVAk2rchY5Y9LBjbRAyAZFhS1/kLu8gEEY8FVOzZbbU
         CFNCWB6tdrsX8GzcCPftIaDTswIFAMhJ0WzNst7Nf19bcB2zrPilVvIYDuU3BbVwMVLa
         P1j6VgLcdcllx1VfCW9KTqYoo2Y1X6khgfu4pot9GSP07PUKv4+Lr5O58h97ZCaHQFbR
         OtF8W6VgO/4JIMwEusvmBQ1afVyeS6I8/+BgcYbMd+Cb9xM0zLQV/jXMyvdsB9SmmNWu
         is+Q==
X-Gm-Message-State: AOAM530CzUbWRbN8R44V1DJNyzNiWmqaOyrzw8iKprb+1OM7vzfdvSsQ
        1N+MdqciC0BWH2ZZGOkuBg/qyYNiIsFeYIkBh//P6Q==
X-Google-Smtp-Source: ABdhPJy4jYet5QmZpV6TnoRvDQKFM/Nxt1EVgXDz1lsYbHHB5i/kMBKsBh0wstzx2AFePu6QxUZ7XD691zTpjqhiWU4=
X-Received: by 2002:a1f:1f81:: with SMTP id f123mr1051472vkf.6.1618477009022;
 Thu, 15 Apr 2021 01:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210413003621.1403300-1-swboyd@chromium.org>
In-Reply-To: <20210413003621.1403300-1-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 10:56:12 +0200
Message-ID: <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Apr 2021 at 02:36, Stephen Boyd <swboyd@chromium.org> wrote:
>
> There's a chance that the IDA allocated in mmc_alloc_host() is not freed
> for some time because it's freed as part of a class' release function
> (see mmc_host_classdev_release() where the IDA is freed). If another
> thread is holding a reference to the class, then only once all balancing
> device_put() calls (in turn calling kobject_put()) have been made will
> the IDA be released and usable again.
>
> Normally this isn't a problem because the kobject is released before
> anything else that may want to use the same number tries to again, but
> with CONFIG_DEBUG_KOBJECT_RELEASE=y and OF aliases it becomes pretty
> easy to try to allocate an alias from the IDA twice while the first time
> it was allocated is still pending a call to ida_simple_remove(). It's
> also possible to trigger it by using CONFIG_DEBUG_KOBJECT_RELEASE and
> probe defering a driver at boot that calls mmc_alloc_host() before
> trying to get resources that may defer likes clks or regulators.

Thanks for a very nice description of the problem.

>
> Instead of allocating from the IDA in this scenario, let's just skip it
> if we know this is an OF alias. The number is already "claimed" and
> devices that aren't using OF aliases won't try to use the claimed
> numbers anyway (see mmc_first_nonreserved_index()). This should avoid
> any issues with mmc_alloc_host() returning failures from the
> ida_simple_get() in the case that we're using an OF alias.

At first glance, this seems like a good idea, but I am not completely
sure, yet. See more below.

>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sujit Kautkar <sujitka@chromium.org>
> Reported-by: Zubin Mithra <zsm@chromium.org>
> Fixes: fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/mmc/core/host.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..137b4a769f62 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -39,7 +39,8 @@ static void mmc_host_classdev_release(struct device *dev)
>  {
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
>         wakeup_source_unregister(host->ws);
> -       ida_simple_remove(&mmc_host_ida, host->index);
> +       if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
> +               ida_simple_remove(&mmc_host_ida, host->index);
>         kfree(host);
>  }
>
> @@ -444,7 +445,7 @@ static int mmc_first_nonreserved_index(void)
>   */
>  struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
> -       int err;
> +       int index;
>         struct mmc_host *host;
>         int alias_id, min_idx, max_idx;
>
> @@ -457,20 +458,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>
>         alias_id = of_alias_get_id(dev->of_node, "mmc");
>         if (alias_id >= 0) {
> -               min_idx = alias_id;
> -               max_idx = alias_id + 1;
> +               index = alias_id;
>         } else {
>                 min_idx = mmc_first_nonreserved_index();
>                 max_idx = 0;
> -       }
>
> -       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> -       if (err < 0) {
> -               kfree(host);
> -               return NULL;
> +               index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> +               if (index < 0) {
> +                       kfree(host);
> +                       return NULL;
> +               }

This means that a DTB that is screwed up in a way that it has two mmc
aliases with the same index, would be allowed to use the same index.

What will happen when we continue the probe sequence in such a case?

>         }
>
> -       host->index = err;
> +       host->index = index;
>
>         dev_set_name(&host->class_dev, "mmc%d", host->index);
>         host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));

Another concern that could potentially be a problem, is that the
"thread" that holds the reference that prevents ida from being
removed, how would that react to a new mmc device to become
re-registered with the same index?

I wonder if we perhaps should return -EPROBE_DEFER instead, when
ida_simple_get() fails?

Kind regards
Uffe
