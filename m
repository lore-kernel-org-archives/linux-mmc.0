Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7020C433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 10:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiDGKwn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiDGKwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 06:52:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18EC054B
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 03:50:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g9so8856966ybf.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TySKIjPSj/26zImOFZFRX5P+kH16cuqo+d2bY9GL/jE=;
        b=sDi6+LYW3GQ815U4o+QsBKbPRStQ55Jp+2afvDxBuD8uHNobxa/rMbKWiHJN5jKJpK
         de9RYkpleTJGc01iClyP4kXpQ9Dausi/kVmz8b+TANzv3y+JASYLdgNnMv/oKD8GoBgf
         pVtVxhwa3UH/CXzfWqbQbxfORSYHT7VVwyklQuJnN1R3eiPuc0vvMR0XpmCruSDte8Q+
         U2BuWgdQQmwEdmG4sf4iKUAgvYZ9WyGRlaGLeC812jxPr5+VAPYvPDMkmjJ1t6AAmo3B
         k7VGjls6tVh40KE1bEivj6SbA77LVFeVhymUcf9bnfr0cnsUoaqbz/Tfd+n1uOU/O0Ck
         cJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TySKIjPSj/26zImOFZFRX5P+kH16cuqo+d2bY9GL/jE=;
        b=wWVxJ2ksOYyJdZ9QS5N/fmKAbNKuI177VocvhIakhxbnTZZ9G8VMtn7qmCuWywB/PP
         /4ro5HHu/FT0adNc7YeD+dQ9SF29QworBtPhlqC7ckoCThMwIQVSU8/2F1gNw3kspIwB
         0N4ialAbxCpSG3K9J9Mc/hqgU0E/AQP6H/R331L0GVTzegOaQ4Uyz4onbjPYw1CDhwrJ
         kcQBrY+7SMLkYxyG/0/jrlCm1DlqrcdOwpZaTNvdk9+e1KwI+vX0QcI7Gb7XIdLfSwtQ
         f7fOvNLquLSJmws7k/a1TsKjwa187Gh3vI/1Qur5WmKldtOg9lvema/TlLTsJmKzDJoi
         dXQQ==
X-Gm-Message-State: AOAM530I8HXRW043kzrovBPTvzoX9lTv0BARLkR8JFrB5h4BmElI/2WQ
        U3wEDjVn4raplDLGkVfX0PmwOBNUMEyHD6j3LicWW/PSyI0=
X-Google-Smtp-Source: ABdhPJzuBD862kdaPvyksHZYhwRWe3mGONoTotSTBfyiEfUFjfH124D9rzHq4d+IcMj5sSUSUsPZz0zanwoh8HnWjBE=
X-Received: by 2002:a25:8244:0:b0:63d:a262:c1f3 with SMTP id
 d4-20020a258244000000b0063da262c1f3mr9323520ybn.397.1649328628742; Thu, 07
 Apr 2022 03:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220404114902.12175-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220404114902.12175-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Apr 2022 12:49:52 +0200
Message-ID: <CAPDyKFoL1ew7wNXu_XjCMxQ4kTR05fdHqvwKVtfnDSFrpL4qOA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: don't overwrite TAP settings when
 HS400 tuning is complete
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Apr 2022 at 13:49, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When HS400 tuning is complete and HS400 is going to be activated, we
> have to keep the current number of TAPs and should not overwrite them
> with a hardcoded value. This was probably a copy&paste mistake when
> upporting HS400 support from the BSP.
>
> Fixes: 26eb2607fa28 ("mmc: renesas_sdhi: add eMMC HS400 mode support")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>
> Lightly tested with a Renesas R-Car M3N SoC. I think I can't really test
> it because my TAPs are usually stable in my environment. The fix should
> be obvious, though. Shimoda-san, are you happy with it?
>
>  drivers/mmc/host/renesas_sdhi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 89d21231ec5f..4404ca1f98d8 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -394,10 +394,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
>                         SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
>                         sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
>
> -       /* Set the sampling clock selection range of HS400 mode */
>         sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
>                        SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
> -                      0x4 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
> +                      sd_scc_read32(host, priv,
> +                                    SH_MOBILE_SDHI_SCC_DTCNTL));
>
>         /* Avoid bad TAP */
>         if (bad_taps & BIT(priv->tap_set)) {
> --
> 2.30.2
>
