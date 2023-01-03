Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB56BC3DA7D
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Jan 2023 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjACPhI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Jan 2023 10:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbjACPgc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2023 10:36:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4711055B
        for <linux-mmc@vger.kernel.org>; Tue,  3 Jan 2023 07:36:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b2so32926430pld.7
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jan 2023 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTxPOKdpEoz6HN4iFRndX+VKS3JI7R42cOkbmgdXEGE=;
        b=Y70x8fnqA5aBFOwuGPbX07BbDlfQXVGSXFEEetqWIYr927lLD4KhzktSzobNfCyS7Q
         tBO04fAdYQUAOCU4r/yoYHIkbVyg7/RB12B47EYxzLmEhOMNfgeG1fPa+YPg/qWmoC9+
         H/mp2+NI5MkhPOUjy3ijslueXp5yYBWS7ey/V+m0va/ZfF20If8qaaKljEfiR0BkuFPL
         dYal5vRqU6N09E9RLjtfptExLOm1bkVNg9ZalHrHigv8Q8iCliHEl+8JlZoHHmpT3JlM
         nWhaxJrYwAHIItBpKyaSwsmFXFWr7iZXeTY22fy5yYI/xpFamzyxB7hCsK1dOt8irqpG
         B7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTxPOKdpEoz6HN4iFRndX+VKS3JI7R42cOkbmgdXEGE=;
        b=aPR1bfcESX5od+jbonmwqTMiT+EW2TwdUfW0w1kvugRUCulL187s+qI1cSyuQofD63
         4YLXgReBpTbaJ5cxhBczyXRBHOzgRWAslbiSB5cbrqJH6bObe0GLW9VgD5oOSkjGLJD4
         vB1Bzz8yxzNnoVcFUjdZau1hHPn9FIr8H6XzrMSTzfUfjWE+g+nkCrgsbC/koxUh3NjN
         McDAkLnfQEXJ2AYJXJnF2Mq69K1hpESLGdneFxEwbp1BZAfMiCRkC379FFME/3S+o0hJ
         Pa/NyNCQd4yNriXU+NHzbrseT93LbpdcgiE5sCBqGLZmCxul9l6r5y/kWQkrDyk7mMmA
         z5rQ==
X-Gm-Message-State: AFqh2kqlELkd3yVHiPLLAIMYonCVKqpiSU6asqw8ucKcj2eOO7mxaNkc
        Jss3RvZ0sZ4FJ9mXTLeENs74KgeQArRlHgKWs9RDoaHBEx+UzjZr
X-Google-Smtp-Source: AMrXdXvvoxJjjDvq6ZLgQ+rMzIrYEwCUwqx2X+23NXeoHxWElIi9bz3Cm5s2CzDAeOmSggPkW7VWPaeJweCTk7D/Rys=
X-Received: by 2002:a17:90a:be18:b0:226:60cc:d0 with SMTP id
 a24-20020a17090abe1800b0022660cc00d0mr825550pjs.164.1672760190665; Tue, 03
 Jan 2023 07:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20221213141403.1734718-1-yangyingliang@huawei.com>
In-Reply-To: <20221213141403.1734718-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jan 2023 16:35:54 +0100
Message-ID: <CAPDyKFqhTdk1n5Gj4aO3vQj7uZ3r+9H0tuBCNgwqvxyg=BNJRQ@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: sdio: fix possible resource leaks in some error paths
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Dec 2022 at 15:17, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If sdio_add_func() or sdio_init_func() fails, sdio_remove_func() can
> not release the resources, because the sdio function is not presented
> in these two cases, it won't call of_node_put() or put_device().
>
> To fix these leaks, make sdio_func_present() only control whether
> device_del() needs to be called or not, then always call of_node_put()
> and put_device().
>
> In error case in sdio_init_func(), the reference of 'card->dev' is
> not get, to avoid redundant put in sdio_free_func_cis(), move the
> get_device() to sdio_alloc_func() and put_device() to sdio_release_func(),
> it can keep the get/put function balanced.
>
> Without this patch, while doing fault inject test, it can get the
> following leak reports, after this fix, the leak is gone.
>
> unreferenced object 0xffff888112514000 (size 2048):
>   comm "kworker/3:2", pid 65, jiffies 4294741614 (age 124.774s)
>   hex dump (first 32 bytes):
>     00 e0 6f 12 81 88 ff ff 60 58 8d 06 81 88 ff ff  ..o.....`X......
>     10 40 51 12 81 88 ff ff 10 40 51 12 81 88 ff ff  .@Q......@Q.....
>   backtrace:
>     [<000000009e5931da>] kmalloc_trace+0x21/0x110
>     [<000000002f839ccb>] mmc_alloc_card+0x38/0xb0 [mmc_core]
>     [<0000000004adcbf6>] mmc_sdio_init_card+0xde/0x170 [mmc_core]
>     [<000000007538fea0>] mmc_attach_sdio+0xcb/0x1b0 [mmc_core]
>     [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]
>
> unreferenced object 0xffff888112511000 (size 2048):
>   comm "kworker/3:2", pid 65, jiffies 4294741623 (age 124.766s)
>   hex dump (first 32 bytes):
>     00 40 51 12 81 88 ff ff e0 58 8d 06 81 88 ff ff  .@Q......X......
>     10 10 51 12 81 88 ff ff 10 10 51 12 81 88 ff ff  ..Q.......Q.....
>   backtrace:
>     [<000000009e5931da>] kmalloc_trace+0x21/0x110
>     [<00000000fcbe706c>] sdio_alloc_func+0x35/0x100 [mmc_core]
>     [<00000000c68f4b50>] mmc_attach_sdio.cold.18+0xb1/0x395 [mmc_core]
>     [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]
>

Thanks for the detailed description, nice!

> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")

This looks wrong, it's not really that commit that introduces the
problem. It existed way before this.

> Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")

Even if the problem is really old, I am worried that we may introduce
other problems if $subject patch gets applied as is, to older stable
kernels that carry the above commit. Did you have a look at this too?

Unless you propose something, I will try to figure out the best way
forward here.

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v4 -> v5:
>   Merge to two pathes in one and add leak reports.
>   Fix wrong check in sdio_remove_func().
>   Move get/put_device() in sdio_alloc/release_func.
>
> v3 -> v4:
>   Drop patch1, keep calling put_device() to free memory,
>   set 'func->card' to NULL to avoid redundant put.
>
> v2 -> v3:
>   Change to call of_node_put() in remove() function to
>   fix node refcount leak.
>
> v1 -> v2:
>   Fix compile error in patch #2.
> ---
>  drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++----
>  drivers/mmc/core/sdio_cis.c | 12 ------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index babf21a0adeb..1ba135cd4caa 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -291,8 +291,14 @@ static void sdio_release_func(struct device *dev)
>  {
>         struct sdio_func *func = dev_to_sdio_func(dev);
>
> -       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO)) {
>                 sdio_free_func_cis(func);
> +               /*
> +                * We have now removed the link to the tuples in the
> +                * card structure, so remove the reference.
> +                */
> +               put_device(&func->card->dev);

In fact, we are relying on the card's struct device itself, even if
the MMC_QUIRK_NONSTD_SDIO is set or not.

More importantly, we are relying on the "card" before device_add()
(that helps us to manage parent/child relationships) is getting called
for the sdio_func's struct device.

Therefore, I think we should call put_device() here, no matter whether
MMC_QUIRK_NONSTD_SDIO is set or not.

> +       }
>
>         kfree(func->info);
>         kfree(func->tmpbuf);
> @@ -324,6 +330,13 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
>
>         device_initialize(&func->dev);
>
> +       /*
> +        * We may link to tuples in the card structure,
> +        * we need make sure we have a reference to it.
> +        */
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))

For the similar reasons as above, we should call get_device() here, no
matter whether MMC_QUIRK_NONSTD_SDIO is set or not.

> +               get_device(&func->card->dev);
> +
>         func->dev.parent = &card->dev;
>         func->dev.bus = &sdio_bus_type;
>         func->dev.release = sdio_release_func;
> @@ -377,10 +390,9 @@ int sdio_add_func(struct sdio_func *func)
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> -       if (!sdio_func_present(func))
> -               return;
> +       if (sdio_func_present(func))
> +               device_del(&func->dev);
>
> -       device_del(&func->dev);
>         of_node_put(func->dev.of_node);
>         put_device(&func->dev);
>  }
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index a705ba6eff5b..afaa6cab1adc 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -403,12 +403,6 @@ int sdio_read_func_cis(struct sdio_func *func)
>         if (ret)
>                 return ret;
>
> -       /*
> -        * Since we've linked to tuples in the card structure,
> -        * we must make sure we have a reference to it.
> -        */
> -       get_device(&func->card->dev);
> -
>         /*
>          * Vendor/device id is optional for function CIS, so
>          * copy it from the card structure as needed.
> @@ -434,11 +428,5 @@ void sdio_free_func_cis(struct sdio_func *func)
>         }
>
>         func->tuples = NULL;
> -
> -       /*
> -        * We have now removed the link to the tuples in the
> -        * card structure, so remove the reference.
> -        */
> -       put_device(&func->card->dev);
>  }
>

Kind regards
Uffe
