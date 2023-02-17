Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46BC05027
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBQKaL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQKaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:30:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344D5972F
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:30:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y2so803873pjd.5
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sja09N9fvMpK74dIaBQgQVymO3+vghxtOTVPe1KPssI=;
        b=cHT/wqUJ2urpwnBJ2g6PrVkh5VkuGIWB+enRorqzC5keYCC5YFvnBGPfbsOvLmKqiX
         2tmiVhvFowig0FqvtV2BMiD+E/NhlbXYZCTI4rw4KZT2b5KQsIVFDvcELixOrdhUVhCY
         E0xrTa4/OWhchduObz3O6mnABZxhgUEVy4VCqFv3X/gnHBsv/9z0EPL1CFRFY5WfypxT
         7hysTBNwbNQ7/Adku+LEsm4sZFRugPRjUlCKe+TQ/YlVjbQVY9YLZl+40mCiwmNrCJlG
         Sial1lmqgTT8cTlZ6E+CMD+aRn3kyc4ZAJtYz9jETbr93Oyh5CGEjn8Aq+e5gDM8WOej
         CHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sja09N9fvMpK74dIaBQgQVymO3+vghxtOTVPe1KPssI=;
        b=LaU+UfKc1twJW76gKLy8I/LCfi/wqPMD4Uwp3mrpfII30PSqNcnxQatGuJs8PxdRQk
         OIw9tkoegkCs30qg+SWkIwXJdC1HYXi3b5LZ5EoeboPOjwxiROHLsX6hcdB33rIdMrvm
         qmE8ROgQGgtngxLlLp+N7uXA2nTTQeWylqWemKoD7RjMeOFeJiS3tyxgzS8LwdY0+Du/
         qyDivgsZfTk9LUNgfcSoYJqMtALOGlAyFzj1dr44CNGO9JaBFuoOBwv9ZV5qjPyNj7p9
         HTuf92RhB5tBJZ//v/NxrtjJK3pa0J8+fTUkwCRUDJOFosCvd5Xev8BF+o5njZA22K4J
         LVdw==
X-Gm-Message-State: AO0yUKWw0KeHYdZNybQJBITAA8Y4Tuqo6UwIxtoSEDZmNmozBs6EJHgs
        iyQ3d1l41ahgLd6oo4rY1e/6o0AW++aKbkDlYnOpPchn+hye/g==
X-Google-Smtp-Source: AK7set/oF5twMgPws2I+LJXa9SIdR39wHnxhlYHEIptId41IAbe34yp/jDLAm20p71jkytR/qbxdeIKbWTzB/pBsG5s=
X-Received: by 2002:a17:90b:280d:b0:230:ae51:1cdc with SMTP id
 qb13-20020a17090b280d00b00230ae511cdcmr1346340pjb.120.1676629806345; Fri, 17
 Feb 2023 02:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20230217024333.4018279-1-yangyingliang@huawei.com>
In-Reply-To: <20230217024333.4018279-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:29:28 +0100
Message-ID: <CAPDyKFqyF5cb4R8u0mwoCyfpvtGtXKQ2wh72Sia3SARV_pTZ=A@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: fix return value check in devm_mmc_alloc_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Feb 2023 at 03:44, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_alloc_host() returns NULL pointer not PTR_ERR(), if it
> fails, so replace the IS_ERR() check with NULL pointer check.
>
> In commit 418f7c2de133 ("mmc: meson-gx: use devm_mmc_alloc_host"),
> it checks NULL pointer not PTR_ERR, if devm_mmc_alloc_host() fails,
> so make it to return NULL pointer to keep same with mmc_alloc_host(),
> the drivers don't need to change the error handle when switch to
> use devm_mmc_alloc_host().
>
> Fixes: 80df83c2c57e ("mmc: core: add devm_mmc_alloc_host")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 6a7475ad7685..096093f7be00 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -599,12 +599,12 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
>
>         dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
>         if (!dr)
> -               return ERR_PTR(-ENOMEM);
> +               return NULL;
>
>         host = mmc_alloc_host(extra, dev);
> -       if (IS_ERR(host)) {
> +       if (!host) {
>                 devres_free(dr);
> -               return host;
> +               return NULL;
>         }
>
>         *dr = host;
> --
> 2.25.1
>
