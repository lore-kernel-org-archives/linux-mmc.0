Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F945C433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiDGLIR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiDGLHc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 07:07:32 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491F2AD6
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 04:05:30 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2eb888cf7e7so56968697b3.13
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/+jxG7/qC+HL736ZI+dB9DYm99UjY4OY9p5MrCz8WU=;
        b=zUJs9vdyKV13W0O1CHtk8d0X0BexhnkEkl4ALjD1Ssj5GLKkh2OReJswhB5KngtGbx
         YVc9DIgY0ilBj5Iik8QLMtAAgKu4XJQ9+K+IU2FDSFfvrrNf54V6HoWGzWGu/F1o/Mdi
         0VH54RkVT+dr95OqpkhMJjDHO072s9AxKr7dASSI4suX59X9yNROi61NYB+Fmr2xCz6y
         bAYkmhYKy8BWHQKPq838Sk1iPBouJmF295Dwdr56J8/Pxbk0k0zl/Gd7u7mKqhN7Pz4O
         E/pheejYvP5zJC4j9PCDZI/IIsylBvQlxWzsHL3zDyj20znVvDHvCabl7QAm+LTFCrMl
         pD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/+jxG7/qC+HL736ZI+dB9DYm99UjY4OY9p5MrCz8WU=;
        b=IB9Js7baJbITPYn4psqEQAq0IXxGcrnD99c1KuoLg94klRPFm0Ci0NDBe2CjdQMyDk
         i/1NrwruS4gwrfVqS/jWOa5pdo28xSC2o1RsEg2HDcMDisoiEihflwfy2Uw9kF3XT/TW
         8tsu8kN+j/66aTAwoNo0iw6bxZf0a91j7zJP6UHFONRdRMrNVgqOL5NwzT1Xaq63JUeI
         WRki4Ju6TATzFLLcoK6UX+QlBoGPPx/cuoeQoAA9224A3xpCA11Kt+vQggyl9cMo6TKx
         xGxWL/64NukOONYkwSexbDWg1KiByurp9FUD78nfwAkSkVElbZY7pBw3TUctuJApOBPl
         ewPw==
X-Gm-Message-State: AOAM532/8jsoXUfi9mvWGAgyhmeufUN2QfyEIjcFEGUh2abeJ81YjuXV
        +Gq2s83ljfqcLnerZvTO2eVRFS88dY8wUOe88nxnZg==
X-Google-Smtp-Source: ABdhPJxZ6YM6G3M31cWEljzgHmn5I3outlGo+FMn1fOs8TaGGByBjHyy6dnjKVKdZu3TEhMox9BkaKwu12P6dtKoeJc=
X-Received: by 2002:a81:3a52:0:b0:2d7:549a:50fc with SMTP id
 h79-20020a813a52000000b002d7549a50fcmr11205845ywa.85.1649329529640; Thu, 07
 Apr 2022 04:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220404123404.16289-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220404123404.16289-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Apr 2022 13:04:53 +0200
Message-ID: <CAPDyKFqmsGsPFgvg0SAMGsOVTiPS5WM57CGVjUxnZD7Xr=J=Og@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: R-Car V3H ES2.0 gained HS400 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Apr 2022 at 14:34, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The hardware evolved, so we only need to disable HS400 support on ES1.*
> revisions. Update the code.
>
> Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
> [wsa: refactored to top-of-tree]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Another HS400 update for a specific SoC. Builds fine. But I can't test
> because of no HW. Reviews from Geert and/or Shimoda-san would be much
> appreciated.
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 2cd81d22c3c3..c9585c4fd812 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -215,6 +215,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
>         { .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
>         { .soc_id = "r8a7796", .revision = "ES1.[12]", .data = &sdhi_quirks_4tap_nohs400 },
>         { .soc_id = "r8a7796", .revision = "ES1.*", .data = &sdhi_quirks_r8a7796_es13 },
> +       { .soc_id = "r8a77980", .revision = "ES1.*", .data = &sdhi_quirks_nohs400 },
>         { /* Sentinel. */ }
>  };
>
> @@ -265,7 +266,6 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
>         { .compatible = "renesas,sdhi-r8a77965", .data = &of_r8a77965_compatible, },
>         { .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
> -       { .compatible = "renesas,sdhi-r8a77980", .data = &of_rcar_gen3_nohs400_compatible, },
>         { .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
>         { .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
>         { .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
> --
> 2.30.2
>
