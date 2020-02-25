Return-Path: <SRS0=gc8k=4N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB9EC35E04
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5208B2084E
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuGnhr4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgBYOxo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:53:44 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38977 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbgBYOxn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2020 09:53:43 -0500
Received: by mail-vs1-f68.google.com with SMTP id p14so8135646vsq.6
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2020 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWz4wDeiQ+dMtZmMMfMTReHPvDQ7FFlWV1iEIBtaea4=;
        b=SuGnhr4P2blA3x8jlYXg1G0+xqxyloO0I0ugkiAJtHLnx4kXvSifw31EVLq2SK/Imy
         2hdmZhH8m1eQGZW9mUMi4W4fNCztO2ho0S0dXBRKKuz1bPMbFwzhCknrSFHgSOQTc42a
         T5drEFsRvR+NK8V85+HGQ7XeEvAZCym6MS+YPy04fHNBycaAbC3Mzvv6OB0fzvM0da5G
         rIp9QLeu1itsiEtR6gwAZl7hjMp7rK9J17wzW8x+X+Q7Luefyys7cJ1To6wCCPLri6pU
         rHeEaeQNrzcYAyx+IVw9GojNBe/mkc1PMKz0Hjff0SLKcio+KAmnAefTm5bJwBRVYT91
         HW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWz4wDeiQ+dMtZmMMfMTReHPvDQ7FFlWV1iEIBtaea4=;
        b=RNrKjl04yiRv7rJ8DLHj+Rjuad5xMUztTiQdC4zHdkTJfoJy32hRDCkHSPcLuW19UU
         G5737+A+APXLsx49pCOIc02qeV5wa1qW4KScRPn0MBDTooxXOx8k53wOMtfs/jyJdvUs
         mjjMz966DQ+ICR0XnCqrXTHJV7d+9P8vnHO99zFsjjTjtsegXFWsOHsruFKu/WKgjL36
         9oKfGLmz9HLKa7ojiiN5SBBS8PhtYnhwFoCIRQPG88WyR6T0IpVR4frfuZOAjEFK4g7n
         oLMTphBVU4ZL9fJ60vdCqRzPfbXj/qWBjnsvbopIkOdilSGdGOiVnM+ACTNrSdUbRKXl
         NnmQ==
X-Gm-Message-State: APjAAAVs/kkfhqP6ljRmPZzcnxJ6/AysTZ0orWxVkMxZ2krUQgk+WI0t
        9PtVxYKZkNlxJWXHp0BozpXP1SmDBw0Azh/5G4LBDg==
X-Google-Smtp-Source: APXvYqzlsHIb9YP3hCpfGA3Rdvg18zkDRP+rQoidSvkbh7QnCla2LkAkAEyvsQqyTzNbdgy/e8+g60oi0oH2Qq7EHJk=
X-Received: by 2002:a05:6102:757:: with SMTP id v23mr30298970vsg.35.1582642420792;
 Tue, 25 Feb 2020 06:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200224231841.26550-1-digetx@gmail.com> <20200224231841.26550-3-digetx@gmail.com>
In-Reply-To: <20200224231841.26550-3-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Feb 2020 15:53:04 +0100
Message-ID: <CAPDyKFoSwjkOX85jjA-Q-ScdC0aUozroOu3_-FO4yBE8pgtCow@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: block: Add mmc_bdev_to_card() helper
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Feb 2020 at 00:22, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
> parameter, and thus, the partition parser needs to retrieve that EXT_CSD
> value from the block device. This patch introduces new helper which takes
> block device for the input argument and returns corresponding MMC card.

Rather than returning the card, why not return the value you are
looking for instead? That sound more straightforward, but also allows
mmc core code to stay closer to the mmc core.

Kind regards
Uffe

>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/core/block.c | 14 ++++++++++++++
>  include/linux/mmc/card.h |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 663d87924e5e..5d853450c764 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -301,6 +301,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>         return ret;
>  }
>
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
> +{
> +       struct mmc_blk_data *md;
> +
> +       if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
> +               return NULL;
> +
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md)
> +               return NULL;
> +
> +       return md->queue.card;
> +}
> +
>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>         struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 90b1d83ce675..daccb0cc25f8 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -7,6 +7,7 @@
>  #ifndef LINUX_MMC_CARD_H
>  #define LINUX_MMC_CARD_H
>
> +#include <linux/blkdev.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>
> @@ -324,4 +325,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
>  #define mmc_card_sd(c)         ((c)->type == MMC_TYPE_SD)
>  #define mmc_card_sdio(c)       ((c)->type == MMC_TYPE_SDIO)
>
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
> +
>  #endif /* LINUX_MMC_CARD_H */
> --
> 2.24.0
>
