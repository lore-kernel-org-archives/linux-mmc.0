Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0447C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 10:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiGLK5T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiGLK5S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 06:57:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0753AE569
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 03:57:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w17so7848697ljh.6
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haJtaBg9iJ7nUU8NyVLm6SPXfQl/TvLT88BBTucdy5M=;
        b=agUpPvt8q/piTx49RLWIj8ofUY2vjIMGpP3lbcGdETZFSkhEYtT5UxKcA8dFWzzgfk
         n06npNPXOagYdM5UH3VrdrSII0Sz+FCYi19CRg+XRZNAwi3GNwjGL4VKs3ayAh+T63c5
         OqGMg5uaSkJb5SqVSchX34psYkfFEYGdnHAHCr7bINjpY+oZcWusbUF9H1LfXSGRocDX
         +Y4ArIRLEXgi9s5lzfnMUeV8RStEt/RurEibti8HQZs9O1Awluj/N+c3fn9pHPvFORLI
         jcOyQchqzJ946Wr083jlWj3qeK/QtAcBQMoxUmHcP2To7i6ISUnRTRwzohZ3UZH7vN2b
         Fufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haJtaBg9iJ7nUU8NyVLm6SPXfQl/TvLT88BBTucdy5M=;
        b=1uOlo1s13trAk5zskt+EPmRpWCxMuAOUZWCQcTcwPeJDic2jR72hPQ6wBhIhVXGPwf
         NdEFf4IdT7z86Vx/Hcn+FPULaNWmV5bA+9XcNQwA83QBv1YPMIsIa8sGt4M9FdewYSVI
         SgKFQWKXme5GW4f9ZIPUt14NowkWXvB4YQ/4hxXkmKDg0g1cY73Ye8BPPqgwHeKbcuq0
         QQwibiqij2owuQDagHOb0E4+FmCPaycNsTFHLTUvgTXMIkrDhm8JbniHMWp5cI0V4zv7
         cWPF5HURBnuhtyPkeI2TmmHQm4y6DIDWZRNByG2TROhNVUs6cA7ID+HVPp6ZFbJ3vLoG
         qMJw==
X-Gm-Message-State: AJIora+mm0mmjd9BcYhQ42S0cVol2bY3FV4d2Asg4XrX7mOAcJu0mh6B
        U9Y9NxuueSy2CGjnZcz7h3A0bSbeonQVtGnxVWM0YA==
X-Google-Smtp-Source: AGRyM1tFIFOwDqnJk5IXBL9wN5qLMB2NWlDmWHobMdtt7RQc8J/Wd8Sk3QtdvOH3kt4Rpi9D6SISiu336cOuQYnYiyw=
X-Received: by 2002:a2e:bd11:0:b0:25d:4f94:ac79 with SMTP id
 n17-20020a2ebd11000000b0025d4f94ac79mr12751057ljq.4.1657623435169; Tue, 12
 Jul 2022 03:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3@epcas1p2.samsung.com>
 <20220705015729.14455-1-sh043.lee@samsung.com>
In-Reply-To: <20220705015729.14455-1-sh043.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 12:56:39 +0200
Message-ID: <CAPDyKFodLj7McOsT1ObGFU03g0iBLaydo-E5QV=hy+0tOi846A@mail.gmail.com>
Subject: Re: [PATCH] mmc: use mmc_card_* macro and add it for sd_combo
To:     Seunghui Lee <sh043.lee@samsung.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, Avri.Altman@wdc.com, shawn.lin@rock-chips.com,
        adrian.hunter@intel.com, grant.jung@samsung.com,
        jt77.jang@samsung.com, dh0421.hwang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        cw9316.lee@samsung.com, sh8267.baek@samsung.com,
        wkon.kim@samsung.com, seunghwan.hyun@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 5 Jul 2022 at 03:25, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> add mmc_card_sd_combo() macro for sd combo type card and
> use mmc_card_* macro to simplify instead of comparing card->type
>
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>

Nice cleanup! I minor thing though, see below.

> ---
>  drivers/mmc/core/block.c  |  4 ++--
>  drivers/mmc/core/bus.c    |  4 ++--
>  drivers/mmc/core/sd.c     |  2 +-
>  drivers/mmc/core/sdio.c   | 16 ++++++++--------
>  drivers/mmc/host/mxcmmc.c |  2 +-

Please split this patch into two. One for the core and one for the
mxcmmc driver.

Otherwise this looks good to me!

Kind regards
Uffe

>  include/linux/mmc/card.h  |  1 +
>  6 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index bda6c67ce93f..4d7ae8fc2901 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2987,7 +2987,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>          * Don't enable runtime PM for SD-combo cards here. Leave that
>          * decision to be taken during the SDIO init sequence instead.
>          */
> -       if (card->type != MMC_TYPE_SD_COMBO) {
> +       if (!mmc_card_sd_combo(card)) {
>                 pm_runtime_set_active(&card->dev);
>                 pm_runtime_enable(&card->dev);
>         }
> @@ -3014,7 +3014,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>                 mmc_blk_part_switch(card, md->part_type);
>                 mmc_release_host(card->host);
>         }
> -       if (card->type != MMC_TYPE_SD_COMBO)
> +       if (!mmc_card_sd_combo(card))
>                 pm_runtime_disable(&card->dev);
>         pm_runtime_put_noidle(&card->dev);
>         mmc_blk_remove_req(md);
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 58a60afa650b..d8762fa3d5cd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -85,7 +85,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>                         return retval;
>         }
>
> -       if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
> +       if (mmc_card_sdio(card) || mmc_card_sd_combo(card)) {
>                 retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
>                                         card->cis.vendor, card->cis.device);
>                 if (retval)
> @@ -107,7 +107,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>          * SDIO (non-combo) cards are not handled by mmc_block driver and do not
>          * have accessible CID register which used by mmc_card_name() function.
>          */
> -       if (card->type == MMC_TYPE_SDIO)
> +       if (mmc_card_sdio(card))
>                 return 0;
>
>         retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c5f1df6ce4c0..f0186bdf2025 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -793,7 +793,7 @@ static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
>              attr == &dev_attr_info2.attr ||
>              attr == &dev_attr_info3.attr ||
>              attr == &dev_attr_info4.attr
> -           ) && card->type != MMC_TYPE_SD_COMBO)
> +           ) &&!mmc_card_sd_combo(card))
>                 return 0;
>
>         return attr->mode;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 25799accf8a0..b589df1c35e0 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -335,7 +335,7 @@ static int sdio_disable_4bit_bus(struct mmc_card *card)
>  {
>         int err;
>
> -       if (card->type == MMC_TYPE_SDIO)
> +       if (mmc_card_sdio(card))
>                 goto out;
>
>         if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
> @@ -360,7 +360,7 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
>         err = sdio_enable_wide(card);
>         if (err <= 0)
>                 return err;
> -       if (card->type == MMC_TYPE_SDIO)
> +       if (mmc_card_sdio(card))
>                 goto out;
>
>         if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) {
> @@ -415,7 +415,7 @@ static int sdio_enable_hs(struct mmc_card *card)
>         int ret;
>
>         ret = mmc_sdio_switch_hs(card, true);
> -       if (ret <= 0 || card->type == MMC_TYPE_SDIO)
> +       if (ret <= 0 || mmc_card_sdio(card))
>                 return ret;
>
>         ret = mmc_sd_switch_hs(card);
> @@ -441,7 +441,7 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
>                 max_dtr = card->cis.max_dtr;
>         }
>
> -       if (card->type == MMC_TYPE_SD_COMBO)
> +       if (mmc_card_sd_combo(card))
>                 max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
>
>         return max_dtr;
> @@ -689,7 +689,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>             mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
>                 card->type = MMC_TYPE_SD_COMBO;
>
> -               if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
> +               if (oldcard && (!mmc_card_sd_combo(oldcard) ||
>                     memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
>                         err = -ENOENT;
>                         goto mismatch;
> @@ -697,7 +697,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>         } else {
>                 card->type = MMC_TYPE_SDIO;
>
> -               if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
> +               if (oldcard && !mmc_card_sdio(oldcard)) {
>                         err = -ENOENT;
>                         goto mismatch;
>                 }
> @@ -754,7 +754,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>         /*
>          * Read CSD, before selecting the card
>          */
> -       if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
> +       if (!oldcard && mmc_card_sd_combo(card)) {
>                 err = mmc_sd_get_csd(card);
>                 if (err)
>                         goto remove;
> @@ -827,7 +827,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>
>         mmc_fixup_device(card, sdio_fixup_methods);
>
> -       if (card->type == MMC_TYPE_SD_COMBO) {
> +       if (mmc_card_sd_combo(card)) {
>                 err = mmc_sd_setup_card(host, card, oldcard != NULL);
>                 /* handle as SDIO-only card if memory init failed */
>                 if (err) {
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 613f13306433..2cf0413407ea 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -923,7 +923,7 @@ static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
>          * One way to prevent this is to only allow 1-bit transfers.
>          */
>
> -       if (is_imx31_mmc(mxcmci) && card->type == MMC_TYPE_SDIO)
> +       if (is_imx31_mmc(mxcmci) && mmc_card_sdio(card))
>                 host->caps &= ~MMC_CAP_4_BIT_DATA;
>         else
>                 host->caps |= MMC_CAP_4_BIT_DATA;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 37f975875102..156a7b673a28 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -348,5 +348,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
>  #define mmc_card_mmc(c)                ((c)->type == MMC_TYPE_MMC)
>  #define mmc_card_sd(c)         ((c)->type == MMC_TYPE_SD)
>  #define mmc_card_sdio(c)       ((c)->type == MMC_TYPE_SDIO)
> +#define mmc_card_sd_combo(c)   ((c)->type == MMC_TYPE_SD_COMBO)
>
>  #endif /* LINUX_MMC_CARD_H */
> --
> 2.29.0
>
