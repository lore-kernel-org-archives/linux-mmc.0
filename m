Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A1FC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jan 2022 16:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiAaQO5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbiAaQO5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 11:14:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DDDC061714
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:14:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bx31so8412706ljb.0
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8hJ+b/S6oDD8opxH+BCjcxxD51acaIbT9j2/yd5ncc=;
        b=CQ3sqssCFwEUVItVX0VdSHh9VGjFqOFxf7WjBe2ocgb/ROK/uNOOqJc146vSqMMYZR
         iAA5ydHzd1XNkdBv5gt8pAK1/upAhmWVzLP+SsZtoA1C3NgTjt08dXIbX7NNYhI14hda
         vrwZZiCJZsfsY3DsxOEaveAkc97+x0azhR+NPR5fkMvm56AWSr+XPS0FbEu0lTq9mBuF
         SVUdGP2hQejJDusWt7XeX4FIP3XDLthUxiTpnXiccAthbGIsn7s55i2m/pDivwnxm0cp
         TiZ396xPWL8eS2gZP8MNrHjlPabOAdZgg69RdhYDO/irlw0ebWpSuhOMpNNfZ4JtTyuN
         kqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8hJ+b/S6oDD8opxH+BCjcxxD51acaIbT9j2/yd5ncc=;
        b=AfuR0MxhGkaGj0dD+S2hk8qtDM1ken62OnQRZZv+zkFmcXdtOR5wgY4VfhIrF9W7TK
         u8zZU/9XS3RWOhNaMv7t8SLty0ocIIY+Sug7NzWHX3gMxSsgO6aHah1FQ8KHhvVFgZ/+
         pZFChOV0D/32h0fNTjMZnF+IX1j+4XpWxhVASM6uXxEQpmixI2nf2rVpAUNNZkXZPhXk
         6YOjDeMgzw+uyE4LPE4vJo2IAJXtE8qzuDuEjnKwBR4fqJRUBU8zWMl2nHg9tVr0twGQ
         d0dw3XhwbvsVqo2rxJ02HLG8sv4feMX8GfJHEU01/RdUc2PDjESV5Nrc+UuviAuLNe2W
         90wA==
X-Gm-Message-State: AOAM530/S2AQyU35+Y7nVEx5rblgguZwxwvZEnjTtOd/R7sCuSRG/gkC
        aLU5NeZ57nFIVP7dKUXdaVZUCJEkQ0aoeqfMGeXGcZ1kfiXnYg==
X-Google-Smtp-Source: ABdhPJxG0oUeWh5Ez9bFaqi2jteFhhcQ06lp0xXCfsTfB53DpUeafa1P4fk6+O04CRcbSyUtEe1BQP2QnFXLm9yjkmM=
X-Received: by 2002:a05:651c:179c:: with SMTP id bn28mr13949832ljb.4.1643645695036;
 Mon, 31 Jan 2022 08:14:55 -0800 (PST)
MIME-Version: 1.0
References: <b0d9cdda-33f3-1eb0-a76e-26125089e5c5@omp.ru>
In-Reply-To: <b0d9cdda-33f3-1eb0-a76e-26125089e5c5@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 17:14:18 +0100
Message-ID: <CAPDyKFpCH_0Hiq_FhmoUdgY0BXfnK0=jdB+zHQ8e16WKFNJfjA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: use sysfs_emit() in #define sdio_info_attr()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 Jan 2022 at 22:01, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> sprintf() (still used in #define sdio_info_attr()) is vulnerable to the
> buffer overflow.  Use the new-fangled sysfs_emit() instead.
>
> While at it, add spaces around the minus sign...
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Thanks for fixing this!

However, rather than applying these piece by piece, would you mind
squashing these "sysfs_emit" fixes into one patch for the mmc core? It
would be easier for me to handle - and it should still be an easy
backport, I think.

Kind regards
Uffe

>
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
>
> Changes in version 2:
> - added the same macro change in drivers/mmc/corfe/sdio[_bus].c;
> - updated the patch subject.
>
>  drivers/mmc/core/sd.c       |    4 ++--
>  drivers/mmc/core/sdio.c     |    4 ++--
>  drivers/mmc/core/sdio_bus.c |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> Index: mmc/drivers/mmc/core/sd.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/sd.c
> +++ mmc/drivers/mmc/core/sd.c
> @@ -735,9 +735,9 @@ static ssize_t info##num##_show(struct d
>                                                                                                 \
>         if (num > card->num_info)                                                               \
>                 return -ENODATA;                                                                \
> -       if (!card->info[num-1][0])                                                              \
> +       if (!card->info[num - 1][0])                                                            \
>                 return 0;                                                                       \
> -       return sprintf(buf, "%s\n", card->info[num-1]);                                         \
> +       return sysfs_emit(buf, "%s\n", card->info[num - 1]);                                    \
>  }                                                                                              \
>  static DEVICE_ATTR_RO(info##num)
>
> Index: mmc/drivers/mmc/core/sdio.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/sdio.c
> +++ mmc/drivers/mmc/core/sdio.c
> @@ -40,9 +40,9 @@ static ssize_t info##num##_show(struct d
>                                                                                                 \
>         if (num > card->num_info)                                                               \
>                 return -ENODATA;                                                                \
> -       if (!card->info[num-1][0])                                                              \
> +       if (!card->info[num - 1][0])                                                            \
>                 return 0;                                                                       \
> -       return sprintf(buf, "%s\n", card->info[num-1]);                                         \
> +       return sysfs_emit(buf, "%s\n", card->info[num - 1]);                                    \
>  }                                                                                              \
>  static DEVICE_ATTR_RO(info##num)
>
> Index: mmc/drivers/mmc/core/sdio_bus.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/sdio_bus.c
> +++ mmc/drivers/mmc/core/sdio_bus.c
> @@ -52,9 +52,9 @@ static ssize_t info##num##_show(struct d
>                                                                                                 \
>         if (num > func->num_info)                                                               \
>                 return -ENODATA;                                                                \
> -       if (!func->info[num-1][0])                                                              \
> +       if (!func->info[num - 1][0])                                                            \
>                 return 0;                                                                       \
> -       return sprintf(buf, "%s\n", func->info[num-1]);                                         \
> +       return sysfs_emit(buf, "%s\n", func->info[num - 1]);                                            \
>  }                                                                                              \
>  static DEVICE_ATTR_RO(info##num)
>
