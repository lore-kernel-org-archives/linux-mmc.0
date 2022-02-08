Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE91C4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbiBHPNP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379716AbiBHPNN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 10:13:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B4C0612BB
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 07:13:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z7so24940445ljj.4
        for <linux-mmc@vger.kernel.org>; Tue, 08 Feb 2022 07:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heLzqVDOK6HwMtmoRVw+9RNvlkqhz9htMWHePzxmYjo=;
        b=hKhX7L8oYy7og7qYwMi3qsEPm3uInjbXGnODC9R5+llBoYIGxgQ6GZHSWBv9u5wLni
         +4mlfjS2VQihCFBHX69yag89m8AG1IF1WA3SeMfdVbSXIyxQFB3JD5yNnPp85typ4aoq
         BAkU0jyMNxAd0CrjLFAtwzE9Qe2i4xqBx/Tzu01Sy6zi2rg/l3jaYeLIJHboZgvwarCj
         uebDEh54YagSMtB2NCsUx2El+DAOshJgprkuAEBC2naLDQF3d+JRwZmJPDSyOg0UE2da
         XY1wjy5f2qsLpZI/vPD3iUbznB4s2YdAd0h5tg/NdqC4NEFyTS/1ePmGj8M4SUZpHNsL
         wZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heLzqVDOK6HwMtmoRVw+9RNvlkqhz9htMWHePzxmYjo=;
        b=gwilgOyQV++WJvVL5Ae+xFeBgAZL6Fx45t6gEtgz7HOhGBNnjPD3LOtjzhdS8Q3YWl
         cqXhqweIHHaisIg2FGw2vws8jUwTgonMzhbkZGkWTzqW/ap1l/unZXFXUwpTYHejJPEA
         zLpli5vVnFd98IPi0Lce01IiCN773JXUUZ5zDsp/GWfYLwmcjMxEJ4x3DFMKP4+DXjbB
         WXK2H0ZqzsxaGDO32XgbGB+gxl0x6wT1CWtAzepXKjxqQEbCqbP9094b3BKYna6IiARV
         BDdgRtLuBiQD0lBcxZWlUohsoixeldbww+zJoxXHLsr+DuhB03aid4whv+LTR35leUC3
         hmHg==
X-Gm-Message-State: AOAM531bwHRbSX/G+f/Gtn0PWsf57QaMOsykuYUBTP8vi/wH8skkh8Na
        thW8IFcNDoT8VWXg2B6I3S2aHmpyUS0eThZLTUsxzw==
X-Google-Smtp-Source: ABdhPJxH8zHLKvEyDd2e4kyIwhWxYtY+SngUFkJBaJxg5QxptxcnKFYWeQYxK+RJkbjKpzZvOyDDVprGkJ6q5/pkeeE=
X-Received: by 2002:a2e:8790:: with SMTP id n16mr3026510lji.273.1644333185574;
 Tue, 08 Feb 2022 07:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20220203015112.12008-1-samuel@sholland.org> <20220203015112.12008-2-samuel@sholland.org>
In-Reply-To: <20220203015112.12008-2-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:28 +0100
Message-ID: <CAPDyKFpvstn6bvVZhLR3_ByNw72GYfAc6RTYzm1Howz-cZmknA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sunxi-mmc: Add D1 MMC variant
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Feb 2022 at 02:51, Samuel Holland <samuel@sholland.org> wrote:
>
> D1's MMC controllers are unique in that they have the DMA address shift
> (like A100) with a 13-bit descriptor size field (like sun4i). Add the
> compatible and parameters for this new variant.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sunxi-mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2702736a1c57..c62afd212692 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1167,6 +1167,14 @@ static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
>         .can_calibrate = false,
>  };
>
> +static const struct sunxi_mmc_cfg sun20i_d1_cfg = {
> +       .idma_des_size_bits = 13,
> +       .idma_des_shift = 2,
> +       .can_calibrate = true,
> +       .mask_data0 = true,
> +       .needs_new_timings = true,
> +};
> +
>  static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
>         .idma_des_size_bits = 16,
>         .clk_delays = NULL,
> @@ -1205,6 +1213,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
>         { .compatible = "allwinner,sun8i-a83t-emmc", .data = &sun8i_a83t_emmc_cfg },
>         { .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
> +       { .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
>         { .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>         { .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
>         { .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
> --
> 2.33.1
>
