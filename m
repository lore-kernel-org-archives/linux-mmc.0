Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA26EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 11:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFTLUy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjFTLUv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 07:20:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C621727
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:20:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bd5f20508f2so4451741276.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687260048; x=1689852048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAMIK24encDTI1g69sp+l1ThW8cRAMfdfGme8cPPKCg=;
        b=F+isGuB0Fui0b94SqwRApJe8Bxz7TTWeft2R4yV/BnJ0F8bfwPyWoMiRWaK2mASOBB
         yEkjwyfBaY1pH5RzKwm6b5roj+A2Q61R0got0j7AKcnoCqvExiMhTg1torMZsiGjclHa
         Hd7RMFlJFaZJi3zQL9/tVtf5iadfZxz2UL+LeDhxmaWa98YLY71zUE0OxhUGXH+PSiGU
         EmnVN8yxFRYf29JZn07bsZ7HO2s3m7+WVN+XLi3QEAjWW/msaHRsS14Fvq2sblnUamzm
         XjNP/dNeLLPP7j/JdUh9l3ZomRvWQ8X48kbgihjcP9tZb0tdjSGXK8+ESaZ3xmJowrrK
         LhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260048; x=1689852048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAMIK24encDTI1g69sp+l1ThW8cRAMfdfGme8cPPKCg=;
        b=BK0G3DpdX4XvfVLwmO5ft4LA9WAahbaTImDnzT4Sir7oXY5zeOWSb2Hemi5j7tcwdG
         KvUVQLx9W37WsDhMK5wEYuWdGFmlkwVk20D4NJE2dGi3pvG/xGKnDFzINm/lmkh89hXL
         m1ruPKbca0R2vP2Vtv/Px3dDG9KFQ9UUh8ZYz5mIX06+H+hOztlU6mMgCalnKD9ftoVJ
         zGuapN9MMOfI0NFz9KphC/quoX88KvrrAMPUVYLtvs7iedG6QFXX0iSmvy5cI9DkUxR1
         GFiYZXRwwNILa2yuggFCJBvq5ZwHammDDw4fnyXQ9y4Fq9+414LlsaEIo8qJgE63MH0l
         CY3w==
X-Gm-Message-State: AC+VfDzmxuX3x2Vj3NfsZb2TmX6Ono3NgBP+KO468GCP7GDPZ8nhE1Vc
        vlkXIhXOewmqbtAMEre5mCtOo6jQNdr7jSJNvpqAbw==
X-Google-Smtp-Source: ACHHUZ4psVO5wZPKKS4xsolyqhc1+9pX4cWQeNSH2VAHcVKUZao3GGqVOeHfwFXIqX5aLfArGOaYpZOfdmgqWl8NtH4=
X-Received: by 2002:a25:6641:0:b0:bd5:4e6d:9167 with SMTP id
 z1-20020a256641000000b00bd54e6d9167mr8043731ybm.28.1687260048625; Tue, 20 Jun
 2023 04:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230620102713.7701-1-marex@denx.de>
In-Reply-To: <20230620102713.7701-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 13:20:13 +0200
Message-ID: <CAPDyKFq8+sAKGv=eqXyD6c0HJfi7JgVgM_Zgx=um+iHRZyJzyQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas
 Go Plus from 11/2019
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Brian Norris <briannorris@chromium.org>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Liang He <windhl@126.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Xander Li <xander_li@kingston.com.tw>,
        Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Jun 2023 at 12:27, Marek Vasut <marex@denx.de> wrote:
>
> This microSD card never clears Flush Cache bit after cache flush has
> been started in sd_flush_cache(). This leads e.g. to failure to mount
> file system. Add a quirk which disables the SD cache for this specific
> card from specific manufacturing date of 11/2019, since on newer dated
> cards from 05/2023 the cache flush works correctly.
>
> Fixes: 08ebf903af57 ("mmc: core: Fixup support for writeback-cache for eMMC and SD")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: ChanWoo Lee <cw9316.lee@samsung.com>
> Cc: Liang He <windhl@126.com>
> Cc: Seunghui Lee <sh043.lee@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Xander Li <xander_li@kingston.com.tw>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: linux-mmc@vger.kernel.org
> ---
> V2: Drop the unnecessary bail out points
> ---
>  drivers/mmc/core/card.h   | 30 +++++++++++++++++++++++-------
>  drivers/mmc/core/quirks.h | 13 +++++++++++++
>  drivers/mmc/core/sd.c     |  2 +-
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index cfdd1ff40b865..4edf9057fa79d 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -53,6 +53,10 @@ struct mmc_fixup {
>         unsigned int manfid;
>         unsigned short oemid;
>
> +       /* Manufacturing date */
> +       unsigned short year;
> +       unsigned char month;
> +
>         /* SDIO-specific fields. You can use SDIO_ANY_ID here of course */
>         u16 cis_vendor, cis_device;
>
> @@ -68,6 +72,8 @@ struct mmc_fixup {
>
>  #define CID_MANFID_ANY (-1u)
>  #define CID_OEMID_ANY ((unsigned short) -1)
> +#define CID_YEAR_ANY ((unsigned short) -1)
> +#define CID_MONTH_ANY ((unsigned char) -1)
>  #define CID_NAME_ANY (NULL)
>
>  #define EXT_CSD_REV_ANY (-1u)
> @@ -81,17 +87,21 @@ struct mmc_fixup {
>  #define CID_MANFID_APACER       0x27
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
> +#define CID_MANFID_KINGSTON_SD 0x9F
>  #define CID_MANFID_NUMONYX     0xFE
>
>  #define END_FIXUP { NULL }
>
> -#define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,       \
> -                  _cis_vendor, _cis_device,                            \
> -                  _fixup, _data, _ext_csd_rev)                         \
> +#define _FIXUP_EXT(_name, _manfid, _oemid, _year, _month,      \
> +                  _rev_start, _rev_end,                        \
> +                  _cis_vendor, _cis_device,                    \
> +                  _fixup, _data, _ext_csd_rev)                 \
>         {                                               \
>                 .name = (_name),                        \
>                 .manfid = (_manfid),                    \
>                 .oemid = (_oemid),                      \
> +               .year = (_year),                        \
> +               .month = (_month),                      \
>                 .rev_start = (_rev_start),              \
>                 .rev_end = (_rev_end),                  \
>                 .cis_vendor = (_cis_vendor),            \
> @@ -103,8 +113,8 @@ struct mmc_fixup {
>
>  #define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,    \
>                       _fixup, _data, _ext_csd_rev)                      \
> -       _FIXUP_EXT(_name, _manfid,                                      \
> -                  _oemid, _rev_start, _rev_end,                        \
> +       _FIXUP_EXT(_name, _manfid, _oemid, CID_YEAR_ANY, CID_MONTH_ANY, \
> +                  _rev_start, _rev_end,                                \
>                    SDIO_ANY_ID, SDIO_ANY_ID,                            \
>                    _fixup, _data, _ext_csd_rev)                         \
>
> @@ -118,8 +128,9 @@ struct mmc_fixup {
>                       _ext_csd_rev)
>
>  #define SDIO_FIXUP(_vendor, _device, _fixup, _data)                    \
> -       _FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,                        \
> -                   CID_OEMID_ANY, 0, -1ull,                            \
> +       _FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY, CID_OEMID_ANY,         \
> +                  CID_YEAR_ANY, CID_MONTH_ANY,                         \
> +                  0, -1ull,                                            \
>                    _vendor, _device,                                    \
>                    _fixup, _data, EXT_CSD_REV_ANY)                      \
>
> @@ -264,4 +275,9 @@ static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
>  }
>
> +static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 29b9497936df9..bf7fb72ab8b57 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> +        * This has so far only been observed on cards from 11/2019, while new
> +        * cards from 2023/05 do not exhibit this behavior.
> +        */
> +       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> +
>         /*
>          * Some SD cards reports discard support while they don't
>          */
> @@ -209,6 +218,10 @@ static inline void mmc_fixup_device(struct mmc_card *card,
>                 if (f->of_compatible &&
>                     !mmc_fixup_of_compatible_match(card, f->of_compatible))
>                         continue;
> +               if (f->year != CID_YEAR_ANY && f->year != card->cid.year)
> +                       continue;
> +               if (f->month != CID_MONTH_ANY && f->month != card->cid.month)
> +                       continue;
>
>                 dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
>                 f->vendor_fixup(card, f->data);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 72b664ed90cf6..246ce027ae0aa 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1170,7 +1170,7 @@ static int sd_parse_ext_reg_perf(struct mmc_card *card, u8 fno, u8 page,
>                 card->ext_perf.feature_support |= SD_EXT_PERF_HOST_MAINT;
>
>         /* Cache support at bit 0. */
> -       if (reg_buf[4] & BIT(0))
> +       if ((reg_buf[4] & BIT(0)) && !mmc_card_broken_sd_cache(card))
>                 card->ext_perf.feature_support |= SD_EXT_PERF_CACHE;
>
>         /* Command queue support indicated via queue depth bits (0 to 4). */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c726ea7812552..daa2f40d9ce65 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -294,6 +294,7 @@ struct mmc_card {
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
> +#define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> --
> 2.39.2
>
