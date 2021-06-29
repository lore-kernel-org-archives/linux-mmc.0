Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A327C11F67
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 13:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3C861DC2
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 13:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhF2N7W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhF2N7V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 09:59:21 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C1C061766
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 06:56:54 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 68so12146707vsu.6
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRjCooLYilzJ+86PT7RBF3IhZiQw722G45jtFqebBys=;
        b=dOJWoZT9SqF072Ql/5/LhWw4wuuUsQTVkxqXTuAZmN7g4yc8SS4lFzTBqKQyR90uqN
         UuYi6bLlH4tSttoXjyPrz78bREGoQEnWu8xafvylu/HvfR2rm03zLsZCFgnDHR4OgvZ+
         Eww0qIoCnTbMOTMr5WlfrAVMdPYCc8+jxTA6uZTEIthf8oKa+GPXsRoZW9j89p2S9lCT
         QlLUaB8cvUH6iQLdLiXNwDXn+Z0ui5ZFQgtdpu3iUvI42ka9F+Jz81GTz/V4XaTNl1op
         MLtRz0KV1kXg+Gz+zK0YqyFA0ToG64rpXemN525Q+RtRQhRNPh3c1dcSkoxajx25zQOR
         Ycow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRjCooLYilzJ+86PT7RBF3IhZiQw722G45jtFqebBys=;
        b=MR3t12umo5L6ebBjmWQzWJdAD2Xjirf7cUdOb7x97P0Upjh56HSJveRV8ZNlVbSJkG
         j0dCMx6BEAoQBwrcbWQ+rmXDCwEazTodE3SdlH98n1vS4iPHxdYLPp+eEIRKIPlAHVYW
         wn0R0JHQasDFPUs3VOYLksS4hvOV/LHtogavZhJfTy16HboSDBrTUsOeMTO+i2Pb3pJV
         U+IuabJQn670V90RF8KkqQWnL7IRCfb+AMQekcoPA13jzzAPQ4bvxR/YBMOlfwi1KDQh
         pGKdxKhriAzs8LCKu7uG/VhCZCX6rm+X8EzuXKHfp5KUMlJqxS2WGEykig4sriBYxqWp
         dBvA==
X-Gm-Message-State: AOAM533IqTgXHvD0g8zVq4BF/pAsc0ildFh78qdMOapwxGPn9jg5lScU
        uNqNIIXvNEWA8dnpOyQlOEV0oeicZESmLz7KioRWAg==
X-Google-Smtp-Source: ABdhPJzwGBN7eht/gaPI0ydnMFYvvl60Ydxd5nrARGcvaRyJhRbjQ100UWHgLSDIOTZ8DNmePwl9IANYfTq6JAFrtp0=
X-Received: by 2002:a67:6a85:: with SMTP id f127mr23505652vsc.34.1624975013300;
 Tue, 29 Jun 2021 06:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
In-Reply-To: <20210628232955.3327484-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 15:56:17 +0200
Message-ID: <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, phone-devel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>, newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Jun 2021 at 01:32, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Some boot partitions on the Samsung 4GB KLM4G1YE4C "4YMD1R" card appear
> broken when accessed randomly. CMD6 to switch back to the main partition
> randomly stalls after CMD18 access to the boot partition 1, and the card
> never comes back online. The accesses to the boot partitions work several
> times before this happens.
>
> I tried using only single blocks with CMD17 on the boot partitions with the
> result that it crashed even faster.
>
> The card may survive on older kernels, but this seems to be because recent
> kernel partition parsers are accessing the boot partitions more, and we get
> more block traffic to the boot partitions during kernel startup.
>
> My only conclusion is that the boot partitions are somehow broken on this
> card, and we add a quirk for this.

You may very well be right on the above conclusion. However, I would
prefer some more details before I am ready to apply this. For example,
more exactly, what happens when the stall is triggered? Can you
provide some more debug info, perhaps with the sequence of commands
that triggers the error?

Moreover, it would be nice to know exactly where in the code the stall
happens. Could it be that it's the mmc_wait_for_cmd() that never
returns in __mmc_switch(), when sending the CMD6 to switch the
partition?

My main worry is that we should not set a card quirk for an eMMC that
could be working fine (on some other platforms), that's why I want us
to be sure.

>
> After applying this patch, the main partition can be accessed and mounted
> without problems.
>
> This eMMC card is found in the Samsung GT-S7710 mobile phone.
>
> Cc: phone-devel@vger.kernel.org
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Reported-by: newbyte@disroot.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c  | 6 ++++++
>  drivers/mmc/core/quirks.h | 7 +++++++
>  include/linux/mmc/card.h  | 1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..e6cde68cda0e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2621,6 +2621,12 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
>                                 card->part[idx].name);
>                         if (ret)
>                                 return ret;
> +               } else if((card->part[idx].area_type & MMC_BLK_DATA_AREA_BOOT) &&
> +                         (card->quirks & MMC_QUIRK_BROKEN_BOOT_PARTITIONS)) {
> +                       pr_info("%s: skipping broken boot partition %s\n",
> +                               mmc_hostname(card->host),
> +                               card->part[idx].name);
> +                       continue;
>                 } else if (card->part[idx].size) {
>                         ret = mmc_blk_alloc_part(card, md,
>                                 card->part[idx].part_cfg,
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index d68e6e513a4f..aa4060c10aa9 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -99,6 +99,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Some Samsung eMMCs have broken boot partitions, accessing them
> +        * randomly will make the device lock up and crash.
> +        */
> +       MMC_FIXUP("4YMD1R", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_BOOT_PARTITIONS),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9ad35dd6012..4006736f59dd 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -259,6 +259,7 @@ struct mmc_card {
>                                                 /* for byte mode */
>  #define MMC_QUIRK_NONSTD_SDIO  (1<<2)          /* non-standard SDIO card attached */
>                                                 /* (missing CIA registers) */
> +#define MMC_QUIRK_BROKEN_BOOT_PARTITIONS (1<<3)        /* Disable broken boot partitions */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)                /* SDIO card has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD   (1<<5)          /* disconnect CD/DAT[3] resistor */
>  #define MMC_QUIRK_INAND_CMD38  (1<<6)          /* iNAND devices have broken CMD38 */
> --
> 2.31.1
>
