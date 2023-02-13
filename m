Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C487C6379F
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBMXtD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBMXtA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:49:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF001814F
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:57 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n2so9070337pfo.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDqwTjGNi/CfZCnn+u+4A52DbrFFa23PP5WE9fHHI90=;
        b=nFgwbkM78tpnhoMw0E7cf/fZ56pPtwJqvFI7W/TAzekQpcdJ5Unh+4hIVtrtBQUeOg
         zOq/FoYOrO3rug+bhextYN0X8GopMBoFvuJmQI2SyzfK1lUPxWlmPV2/CndkuNmBVXIG
         M3T9zvjjfWEXpe0mep1b9bnNOoyn03joygQdfnz4nF7N+zSH2yVo2tpndp76OW9e5roL
         yev1kMtXvx1xKjLfRPayJJ7DPm0/Ng67DpqHuVmiMTo1PaD3xA1KpI5y7vaAc4ZYSDCv
         CECBOrWZoap+LuTvKj5va4GucvmTg+DfZt7Y4MwdlurWhe3tkQxBxhqh18hltZOpzhtI
         CoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDqwTjGNi/CfZCnn+u+4A52DbrFFa23PP5WE9fHHI90=;
        b=OmxRScO+rtD5oQZgzl6pvALOfV3UNt2kZ1yaYQbgacuibnrfHWaoK8FbTbconSM+gq
         syZgzK4cwFvliWwAHTXWb9T30bwNN6577RuVlTkYANVzkxdDHwKjNDq2LcToRyIpW7Qc
         6SZd6UiaxKOEFqz54k/FkevFODRxL/J+p5dYtDhs8F+t5dGi2kgWWK6CuSyzA9N0/XL1
         k/s6VDhLM40ZGv6grflK8lDxpT1lTVnPOk6YRUQbBpRjQF5sqtSOQhOgmSnUtyjF/aLJ
         ypf1z8UTDprbPk2rRz0WyZlBW3Z/tGi9gucW4VfWQ5UX+90oRq8S4wDY1VpwjpekH7/Y
         fQsw==
X-Gm-Message-State: AO0yUKUgTgGmbIZRYjwnHLFWv4kfY99kR9DLM3sqrXDpyOVlYNZj/cm5
        IKiweqZp+SzIhernJF0Rsk7vX/s+Qc8oHighz6kSYw==
X-Google-Smtp-Source: AK7set+KFKTinMEbcu/3/wbgZ1vDfwQ8KmHuD1GXl8C5Rctb15fuvN7fHixuVna/JX2sJa/CyxhqUOgIsphsAq4dXcU=
X-Received: by 2002:aa7:9e84:0:b0:5a8:925b:f68e with SMTP id
 p4-20020aa79e84000000b005a8925bf68emr47339pfq.28.1676332137097; Mon, 13 Feb
 2023 15:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20230130125808.3471254-1-yangyingliang@huawei.com>
In-Reply-To: <20230130125808.3471254-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:20 +0100
Message-ID: <CAPDyKFpC8Ru3n7ruJcJ=JAAihR70CmpJCLTXgwbREvs72+Nauw@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdio: fix possible resource leaks in some error paths
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 Jan 2023 at 13:58, Yang Yingliang <yangyingliang@huawei.com> wrote:
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
> it can keep the get/put function be balanced.
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
> Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v5 -> v6:
>   Remove a fix tag.
>   Call get/put_device() without checking MMC_QUIRK_NONSTD_SDIO.
>
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
>  drivers/mmc/core/sdio_bus.c | 17 ++++++++++++++---
>  drivers/mmc/core/sdio_cis.c | 12 ------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index babf21a0adeb..f191a2a76f3b 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -294,6 +294,12 @@ static void sdio_release_func(struct device *dev)
>         if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
>                 sdio_free_func_cis(func);
>
> +       /*
> +        * We have now removed the link to the tuples in the
> +        * card structure, so remove the reference.
> +        */
> +       put_device(&func->card->dev);
> +
>         kfree(func->info);
>         kfree(func->tmpbuf);
>         kfree(func);
> @@ -324,6 +330,12 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
>
>         device_initialize(&func->dev);
>
> +       /*
> +        * We may link to tuples in the card structure,
> +        * we need make sure we have a reference to it.
> +        */
> +       get_device(&func->card->dev);
> +
>         func->dev.parent = &card->dev;
>         func->dev.bus = &sdio_bus_type;
>         func->dev.release = sdio_release_func;
> @@ -377,10 +389,9 @@ int sdio_add_func(struct sdio_func *func)
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
> --
> 2.25.1
>
