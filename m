Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA3C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9273761090
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhJZPnI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbhJZPnG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2021 11:43:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD9C061745
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d13so15830584ljg.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItgExoYqlNj3swvnfxRqQ18/rOr30eXhqCwMzDpXG68=;
        b=LnjtN0p2eUty/ikiFfktaZhFPLhY8Fly8QgFp+bISr/exeelLmHp4cjaTiadctXvte
         X/2VtG7Ez/brFsIzFIpUtMw4ix29WQ4XKiuWc5s70XrXtXurE6qpVBY3DeXtsVPMRP40
         tnIuy2TVD+9O2Czm4Vws4LdRttwJCkZkh6hfXRWmh1G6zgyPFxb1/yrQmmpOh+SBv68s
         YJTygBeeiMDbFFryh/jsvXahFoFydya4t6odiutY3TU6OcxmBIzNWcq7j/sTR7P4FRER
         FncYpktUklnPpfljMZ6oBr01Pl9MBBxhNHle78VOelsJA+8ZuaI/vjoeEDCKxff9eWMP
         xZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItgExoYqlNj3swvnfxRqQ18/rOr30eXhqCwMzDpXG68=;
        b=f9V3t/iqBaegOpkoldk4AHzUqDGQfLVOWzgvtM2me3Wj2YekC473ee08m/8X1rchra
         rWOEsBgoEV1dRrMmyi/gZAaaKr1kwFn8hs78c+gfCtQJUhWrrKh3YqvUaDfw9rVKCHgN
         UEtBlRZQdhycdc4q/TqiWxgdX/TdTlZ/kWu/laLzevKLtbxJFds8z0+bbYS8jdAxad6X
         T7ZP4vTsD2y45VTHb07O66W4eRZrfiEtWy1nBBsmOprc/l1+NV+cVm1ZCcgaiHrK0zm2
         Svct8Jxlvq2r4FaAe3At5xpNLjfm42vxtIf5MK0PQcHfXugqULKNeN7QtYcyBX0Vj0mm
         8xGQ==
X-Gm-Message-State: AOAM533HzB7WnMtbJdZJi/qeBUwjOYutTwNafB1M+UuRJPhZ9mxBRzY8
        1MsPa6e8F/Kr0L7L2/kcgY4ZTwQfnPqGiTnu1+1pbw==
X-Google-Smtp-Source: ABdhPJwWPwd81h3t/UrROxmVaqOrcvtHoLS5Dv1SamiOKOgZBrLtdMfsFHSVK00A/haUP/rJOdk9ECuKH7HKFe+bb+8=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr28075711ljp.367.1635262840487;
 Tue, 26 Oct 2021 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
 <20211022082106.1557-1-jh80.chung@samsung.com>
In-Reply-To: <20211022082106.1557-1-jh80.chung@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:40:04 +0200
Message-ID: <CAPDyKFqYGGhHDJ14AaT894ExXAV5LtsjcNfSD-iH-hzWGehxxw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample value
To:     Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        christianshewitt@gmail.com, mihailescu2m@gmail.com,
        m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Oct 2021 at 10:20, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> Even though there are candiates value if can't find best value, it's
> returned -EIO. It's not proper behavior.
> If there is not best value, use a first candiate value to work eMMC.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied for fixes and by adding the below tags, thanks!

Cc: stable@vger.kernel.org
Fixes: c537a1c5ff63 ("mmc: dw_mmc: exynos: add variable delay tuning sequence")

Please tell me if that doesn't make sense!

Kind regards
Uffe


> ---
> Changelog V2:
> - Add Marek's Tested-by tag
> - Remove unnecessary code
>
>  drivers/mmc/host/dw_mmc-exynos.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 0c75810812a0..1f8a3c0ddfe1 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -464,6 +464,18 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>                 }
>         }
>
> +       /*
> +        * If there is no cadiates value, then it needs to return -EIO.
> +        * If there are candiates values and don't find bset clk sample value,
> +        * then use a first candiates clock sample value.
> +        */
> +       for (i = 0; i < iter; i++) {
> +               __c = ror8(candiates, i);
> +               if ((__c & 0x1) == 0x1) {
> +                       loc = i;
> +                       goto out;
> +               }
> +       }
>  out:
>         return loc;
>  }
> @@ -494,6 +506,8 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>                 priv->tuned_sample = found;
>         } else {
>                 ret = -EIO;
> +               dev_warn(&mmc->class_dev,
> +                       "There is no candiates value about clksmpl!\n");
>         }
>
>         return ret;
> --
> 2.29.0
>
