Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9432C43219
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbiKRJrf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiKRJqc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:46:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC797DEF9
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:46:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 130so4554055pgc.5
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXOumLJ43+wHt0Ks89gP3+HnLdzTwUgwx0AnITt0/hA=;
        b=oT7nvrdWnORm65mro1inLFtTKysgb9hUYsn3dD2fORwFQPDN7RpRQUxFByyXJc9d1g
         AKsZT5J2+O8IkiiwPzZj/WEZI9/hLepx23+WaFPJtzK0vO2AmCvTmCU2sFMatJixKIUg
         IB4+f/bKfED6TiELEHoVBVmI6OLSVzfkeip4P/3vvsTyQ8X//aEGTu3Sx9ERcO/lYPsn
         0A0T880XVGIZyZOL6j65wNTB+slgC7TGzBG3/1YDXEEJ9xzB3s00HFCiinilILWxpwGa
         BQXyMXLeltFQGUDKnSGT0oBOcaHNh1nbhcXjejj/fbZ615C1msJGtby6x1PA+nMxrRLA
         mI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXOumLJ43+wHt0Ks89gP3+HnLdzTwUgwx0AnITt0/hA=;
        b=rziOaeXOmHqvMN7cjHT3+Y+pTBXSqFIZWApo9/N8uOTIqS630EV29yTdcCklZCDWc+
         3WLMxxoF+clomFQKkeS10rGFHTqN+7p/a6JJJRBPcHfhrbVkyJA2dlgKW3VGYrF/cVuv
         5mbedAOjH4OH3aoX7zLyuS3v1oBrw7C8QyOcfq1IPgZdaiObuOoS03YO7TEO9WeUWHsA
         E/eYeEOmk2jfYfxggsYWDwyC7nBOjP3VNl4JmUvIhaeNcuMnmkTuRVoNH12Zidh1DMWH
         SNNv2Ew6QuNwinu64AFnlfgq10jSeKE4avyEYmXT2+VIeAJXQ2zGDqU61+l0RqtJFdxF
         pr1g==
X-Gm-Message-State: ANoB5pktGW4hUNORCoctSxssOEcuc/fEEXamYl6XY3/NzHfJX28Uqe1r
        zw1siuwzX2ZOerL0PXWVudzIXdXOu+cS+suhRIqHgA==
X-Google-Smtp-Source: AA0mqf7EYABEVgb+jYlDRzh/+351nHBKK9PN7gQy32WEjMJGx8rYiFeyW+PAP12gDHaLkMpXnyM5DP70IwylqI4tjaM=
X-Received: by 2002:a65:588e:0:b0:470:18d5:b6a3 with SMTP id
 d14-20020a65588e000000b0047018d5b6a3mr5736805pgu.541.1668764769539; Fri, 18
 Nov 2022 01:46:09 -0800 (PST)
MIME-Version: 1.0
References: <11376b5714964345908f3990f17e0701@hyperstone.com>
In-Reply-To: <11376b5714964345908f3990f17e0701@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:32 +0100
Message-ID: <CAPDyKFrcZW9wePBKgBYarvcstTvp5x6JJazpNz00f=oChuBcTw@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: core: Fix ambiguous TRIM and DISCARD arg
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Nov 2022 at 15:42, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Clean up the MMC_TRIM_ARGS define that became ambiguous with
> DISCARD introduction.
> While at it fix one usage where MMC_TRIM_ARGS falsely included
> DISCARD, too.
>
> Fixes: b3bf915308ca ("mmc: core: new discard feature support at eMMC v4.5=
")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> -v2: Avoid line break
> Previously submitted as mmc: core: Do not require secure trim for discard
>  drivers/mmc/core/core.c | 9 +++++++--
>  include/linux/mmc/mmc.h | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..77d4dba462a2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1478,6 +1478,11 @@ void mmc_init_erase(struct mmc_card *card)
>                 card->pref_erase =3D 0;
>  }
>
> +static bool is_trim_arg(unsigned int arg)
> +{
> +       return (arg & MMC_TRIM_OR_DISCARD_ARGS) && arg !=3D MMC_DISCARD_A=
RG;
> +}
> +
>  static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
>                                           unsigned int arg, unsigned int =
qty)
>  {
> @@ -1760,7 +1765,7 @@ int mmc_erase(struct mmc_card *card, unsigned int f=
rom, unsigned int nr,
>             !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
>                 return -EOPNOTSUPP;
>
> -       if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
> +       if (mmc_card_mmc(card) && is_trim_arg(arg) &&
>             !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
>                 return -EOPNOTSUPP;
>
> @@ -1790,7 +1795,7 @@ int mmc_erase(struct mmc_card *card, unsigned int f=
rom, unsigned int nr,
>          * identified by the card->eg_boundary flag.
>          */
>         rem =3D card->erase_size - (from % card->erase_size);
> -       if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) && (nr > rem)) {
> +       if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr >=
 rem) {
>                 err =3D mmc_do_erase(card, from, from + rem - 1, arg);
>                 from +=3D rem;
>                 if ((err) || (to <=3D from))
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 9c50bc40f8ff..6f7993803ee7 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -451,7 +451,7 @@ static inline bool mmc_ready_for_data(u32 status)
>  #define MMC_SECURE_TRIM1_ARG           0x80000001
>  #define MMC_SECURE_TRIM2_ARG           0x80008000
>  #define MMC_SECURE_ARGS                        0x80000000
> -#define MMC_TRIM_ARGS                  0x00008001
> +#define MMC_TRIM_OR_DISCARD_ARGS       0x00008003
>
>  #define mmc_driver_type_mask(n)                (1 << (n))
>
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
