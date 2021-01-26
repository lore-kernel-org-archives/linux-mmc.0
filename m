Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF8C433E9
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276512311D
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404006AbhAZMqI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391808AbhAZJ7n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:59:43 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87159C061353
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:55 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o186so8722313vso.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJCLQRxrq3qEZskHQDdRGHVs/g7GsIs44v+7gnvo2ls=;
        b=FOFq8Rt4wj3ueoHnR83ehUcVd2jOut0bL1z0vDVXeQV2Rs3Vl4jGN3McmmUsSjU/ja
         wamaDid3KnCaWtLk5G90d0nwdcQUc4BlfZr9SJFqdejzfVHGeCBc/cR5KQhUvKARusF1
         ZPFskfWFCLWcp1uPPkQVOevDa63ZTw9U9oRCS0NZf9dZ/8bQWWmQCormdTj2fHKJz0Kt
         uSapIEtaovuHMj5EW1FIropN2ShVEdx071K943vd2znRgeRaB3lkm34Z1pQ2LW+YbB6m
         srbCbhRaXHf6YbJS0g8jFa2Adp3Yhfyn4zEZkLSssA2BzPFLsdpyfve88lfS+PLhUrxK
         6mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJCLQRxrq3qEZskHQDdRGHVs/g7GsIs44v+7gnvo2ls=;
        b=qyWv3rJ62VkNzWYD3wiDFcTfx32EYopP6f7wSIgZ0ZAjJoOsMq2UdYteMO9WukU1pb
         1v+Mr4DYtHns1b9m9SaIzDhhLp+0elFKUJqoN9ICFNY2UkIptR940nONvT8shD8wP0pT
         tnAkvT6rbh3QdNCeSlNh1uCw08ZTSpyaR6cytIbYry6r4Y/hnq5JOtN4A1ehM9yyMjfU
         7nFqDM6g6Z0pNzGJiUbx3FfsaoHLF03A5qxFL/5RiccHI61Yc7VrtNeO6A/F9ZO18w6Q
         aY8Av8cvfv4oSqdoEfY+9HIEekYnLj9Izv821pqPO9QIBu34bdGlI3RCnJYRKG2hRXZt
         pg9A==
X-Gm-Message-State: AOAM533Ne5+SuTpb97OFpJQizZhTFaoqzxiBY6w2tBx1k1aGOvpXN2Gc
        pqyU8PjzNWQucAiOJbDCmyZk8sXk5aN/qtoUpNolFcVeaMelkQ==
X-Google-Smtp-Source: ABdhPJxABc5UXW4in2s8UJsSPUcaq4oOAuUUuvd5smFLRDOyRYY5OppaOYrWw/Wc0F4v8snNQaOM8Rlku8cV1xHbXQ4=
X-Received: by 2002:a67:c787:: with SMTP id t7mr3895407vsk.48.1611655134813;
 Tue, 26 Jan 2021 01:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb@epcas1p3.samsung.com>
 <20210125064355.28545-1-cw9316.lee@samsung.com>
In-Reply-To: <20210125064355.28545-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:58:17 +0100
Message-ID: <CAPDyKFqM+PfzoP8aznomAncAVaFqUXN8SzCVf5rauqes+jGmPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: Exclude unnecessary header file
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Coly Li <colyli@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 Jan 2021 at 07:47, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> From the 4.19 kernel, thread related code has been removed in queue.c.
> So we can exclude unnecessary header file.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c30..c7218da6f17c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -7,7 +7,6 @@
>  #include <linux/module.h>
>  #include <linux/blkdev.h>
>  #include <linux/freezer.h>
> -#include <linux/kthread.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/backing-dev.h>
> --
> 2.29.0
>
