Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96745C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jul 2022 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiGUQOv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiGUQOb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2022 12:14:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB689A9B
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a9so3513709lfk.11
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJQDQj7m+tyNPXHcfFnOBMZFI7j1KvI1pewW3EgoUmk=;
        b=C0TNNg4/JdD41kHfZTuWDjQI6Bgbb9ZQVuf25P9O06dyd0kmUHcJ3RTR66cPyuik37
         49836HRT6CVYi62Nxph6W2ovBTgPZ6yyMGfoqbNbyDE9OQvPofHzwNwiMAS+Rq0DrTq1
         Ad48MUJ1H8nD6FkXuW16/PLmAjA4GKv/eM3sAwduiky1b2pHUn4KDxD0gE4+FiveY2Br
         FCTPXuni2tZKwq8PTUSQ03tR+V47FvcDx2DjXEtuEbOyfphL+aHxzCQEWMHS8zyN/yD5
         fIj4TblrOlpvRvsMmtNGs/3zKURQRXnMwa9rZRAnEZSWjnzlahS7cP1uolHRgKMt307s
         WNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJQDQj7m+tyNPXHcfFnOBMZFI7j1KvI1pewW3EgoUmk=;
        b=NxcO8AXhBcQFgV+i/B115y9CXFQeIk8GF8tIeHXXkO2zNnnBN43ACYcbpXu09uMiUo
         nhOrOfG12cXxhWYQgoHD6HybgNhVo6VR4o5+fKX6pHXTDNqqhw8pKwDacarq9OAhpg9A
         PQTpL0/ZFs+p8lC1eo4CYLWq1Gvv8DEzxt8Vw4bMMlLz14OZoIxC23PIP9JnT+oEWQkf
         +b5mnK6+nOathk67yNNqFxIZO9XB32Y0ZPrRxcB64shqf0y3zvx0S/DsDD0ZOtMEpKxb
         FWr2HdXz32844Ohzaoabm3Tgmvjkn4t3P8elKFtHUoNT5J3De4aA8AoDWDAfZrNiWVzq
         zWbg==
X-Gm-Message-State: AJIora9/wTzVb9AnrhYiFXVWEXYnakF7UQ1dpbqwyAVdk21s5l08kcBA
        dUVucGd5VjT4mrwavzhK8GEeKCId3ICc2SIMH8Vp5w==
X-Google-Smtp-Source: AGRyM1seh2sk5juA2taeKbmqAwBN/7F97Mr1KwGGyCxEJxMFOW5MVAXbbRpvUkGD4Eow4JJyeH+8OItn/H+udjp6Jt0=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr21603488lfb.184.1658420038432; Thu, 21
 Jul 2022 09:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220720072901.1266-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220720072901.1266-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 18:13:21 +0200
Message-ID: <CAPDyKFqy07jd5VozRN_H6ANnEjoykKpQk2j6iESKLK8enEOKtA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: newer SoCs don't need manual tap correction
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Jul 2022 at 09:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Takeshi Saito <takeshi.saito.xv@renesas.com>
>
> The newest Gen3 SoCs and Gen4 SoCs do not need manual tap correction
> with HS400 anymore. So, instead of checking the SDHI version, add a
> quirk flag and set manual tap correction only for affected SoCs.
>
> Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
> [wsa: rebased, renamed the quirk variable, removed stale comment]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi.h               | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c          | 5 ++---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 ++++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 1a1e3e020a8c..c4abfee1ebae 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -43,6 +43,7 @@ struct renesas_sdhi_quirks {
>         bool hs400_4taps;
>         bool fixed_addr_mode;
>         bool dma_one_rx_only;
> +       bool manual_tap_correction;
>         u32 hs400_bad_taps;
>         const u8 (*hs400_calib_table)[SDHI_CALIB_TABLE_MAX];
>  };
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 55f7b27c3de7..6edbf5c161ab 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -380,8 +380,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
>         sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
>                        priv->scc_tappos_hs400);
>
> -       /* Gen3 can't do automatic tap correction with HS400, so disable it */
> -       if (sd_ctrl_read16(host, CTL_VERSION) == SDHI_VER_GEN3_SDMMC)
> +       if (priv->quirks && priv->quirks->manual_tap_correction)
>                 sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
>                                ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
>                                sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
> @@ -718,7 +717,7 @@ static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_
>         sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
>
>         /* Change TAP position according to correction status */
> -       if (sd_ctrl_read16(host, CTL_VERSION) == SDHI_VER_GEN3_SDMMC &&
> +       if (priv->quirks && priv->quirks->manual_tap_correction &&
>             host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>                 u32 bad_taps = priv->quirks ? priv->quirks->hs400_bad_taps : 0;
>                 /*
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 0ccdbe3010ee..42937596c4c4 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -170,6 +170,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_4tap_nohs400_one_rx = {
>  static const struct renesas_sdhi_quirks sdhi_quirks_4tap = {
>         .hs400_4taps = true,
>         .hs400_bad_taps = BIT(2) | BIT(3) | BIT(6) | BIT(7),
> +       .manual_tap_correction = true,
>  };
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_nohs400 = {
> @@ -182,25 +183,30 @@ static const struct renesas_sdhi_quirks sdhi_quirks_fixed_addr = {
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps1357 = {
>         .hs400_bad_taps = BIT(1) | BIT(3) | BIT(5) | BIT(7),
> +       .manual_tap_correction = true,
>  };
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps2367 = {
>         .hs400_bad_taps = BIT(2) | BIT(3) | BIT(6) | BIT(7),
> +       .manual_tap_correction = true,
>  };
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_r8a7796_es13 = {
>         .hs400_4taps = true,
>         .hs400_bad_taps = BIT(2) | BIT(3) | BIT(6) | BIT(7),
>         .hs400_calib_table = r8a7796_es13_calib_table,
> +       .manual_tap_correction = true,
>  };
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_r8a77965 = {
>         .hs400_bad_taps = BIT(2) | BIT(3) | BIT(6) | BIT(7),
>         .hs400_calib_table = r8a77965_calib_table,
> +       .manual_tap_correction = true,
>  };
>
>  static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
>         .hs400_calib_table = r8a77990_calib_table,
> +       .manual_tap_correction = true,
>  };
>
>  /*
> --
> 2.35.1
>
