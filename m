Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47825C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 10:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DAA6044F
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 10:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1KDI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Oct 2021 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJ1KDH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2021 06:03:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D31C0613B9
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 03:00:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq11so12353874lfb.10
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zH77Pp44GzU2/mdoe346UbjhRK1B7c5cpEUdWokacgM=;
        b=CleTm/dC2x8A9iZozB6/QHm7oBHfJUuBkh4xpX3f8zr+yQSuORhJjP/bLBZY1wS2Ph
         yC0nWVbOvT/pxpdE/L3nzBfVDjAV0W6+6G/xD8oyPJXQ29SMcfhoT3QqxsbuKKVGIvAP
         /aAPvPFn9U4RD+c7MdVW0d00rICXvVkJ5NkMueIZoqOzwTeyqTy5Vil2V9m1lp+ddGpO
         1ESh2Yz6pxx5q1VmnLIx9Bx4wGiSvI5K9SLlz24CGSXNb1Dc03IVDSEMwOEjWZy0t5o+
         b4NNZm2xMaRpBzYLljmzI9WEaA7l9LYH4cfAI0nOOpn3E+aWbgpAa4iDDCOCPOXSzzc3
         YBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH77Pp44GzU2/mdoe346UbjhRK1B7c5cpEUdWokacgM=;
        b=4FbWm/cxJA+bbSiqqRzI5o+8oJVlRT4PpaUU2Ge4wy0Nmsz30d4Q6gKvKUWGYBmwEb
         qJRhawIgSH+FMokKNwB4X182d0zbbOQLy9XrosgMuGpv2u8GnjMnwmXiSKuQUut7c5Dn
         /g79ywPQ1Do++qsFiIbFjxvOGf8EGty5mvB0foJhRavFM7nlg6KLOmaRYiT31xLyvvUS
         c5odkcl5Yaj48bmTXVBpPt4GrDJF8N1J+Doy91hyVPtVNtLeN6oARD0keSS8ZI7Yzl1Q
         pvgExtXdCdCN/PqJaThol9vnWfY0Rf1LsgrxK8Qo+SKxkIqpdCizhR9SfzGLcTwN3zHn
         H7qw==
X-Gm-Message-State: AOAM530WDXOPBHrMNaKHGvQEq6O3al34EhiNaxJpvqj7eyOnokwy9m0X
        8dYXUxh0+QoC9setfgVT5UZ/bVSkn+OGmPBEsdUC8tl3WSA=
X-Google-Smtp-Source: ABdhPJxHt41HvAzrxD80dsEBaTWUS7K3FBjUXccCtdhuvFUrm7B+4xT6HIt0mETF6V9gmM+/Q+Hmyf0r2uDW3UvTtxY=
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr3302231lfr.358.1635415238498;
 Thu, 28 Oct 2021 03:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211027130812.426373-1-colin.i.king@gmail.com>
In-Reply-To: <20211027130812.426373-1-colin.i.king@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Oct 2021 12:00:01 +0200
Message-ID: <CAPDyKFqXQwfJuU_PPrfeNwh51UkhtVFJzZ71_0R6kcVuSM3bWw@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: dw_mmc: exynos: Fix spelling mistake
 "candiates" -> candidates
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Oct 2021 at 15:08, Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There are several spelling mistakes in variable names and in a dev_warn
> message. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 1f8a3c0ddfe1..c2dd29ef45c6 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -442,14 +442,14 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
>         return sample;
>  }
>
> -static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
> +static s8 dw_mci_exynos_get_best_clksmpl(u8 candidates)
>  {
>         const u8 iter = 8;
>         u8 __c;
>         s8 i, loc = -1;
>
>         for (i = 0; i < iter; i++) {
> -               __c = ror8(candiates, i);
> +               __c = ror8(candidates, i);
>                 if ((__c & 0xc7) == 0xc7) {
>                         loc = i;
>                         goto out;
> @@ -457,7 +457,7 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>         }
>
>         for (i = 0; i < iter; i++) {
> -               __c = ror8(candiates, i);
> +               __c = ror8(candidates, i);
>                 if ((__c & 0x83) == 0x83) {
>                         loc = i;
>                         goto out;
> @@ -466,11 +466,11 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>
>         /*
>          * If there is no cadiates value, then it needs to return -EIO.
> -        * If there are candiates values and don't find bset clk sample value,
> -        * then use a first candiates clock sample value.
> +        * If there are candidates values and don't find bset clk sample value,
> +        * then use a first candidates clock sample value.
>          */
>         for (i = 0; i < iter; i++) {
> -               __c = ror8(candiates, i);
> +               __c = ror8(candidates, i);
>                 if ((__c & 0x1) == 0x1) {
>                         loc = i;
>                         goto out;
> @@ -485,7 +485,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>         struct dw_mci *host = slot->host;
>         struct dw_mci_exynos_priv_data *priv = host->priv;
>         struct mmc_host *mmc = slot->mmc;
> -       u8 start_smpl, smpl, candiates = 0;
> +       u8 start_smpl, smpl, candidates = 0;
>         s8 found;
>         int ret = 0;
>
> @@ -496,18 +496,18 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>                 smpl = dw_mci_exynos_move_next_clksmpl(host);
>
>                 if (!mmc_send_tuning(mmc, opcode, NULL))
> -                       candiates |= (1 << smpl);
> +                       candidates |= (1 << smpl);
>
>         } while (start_smpl != smpl);
>
> -       found = dw_mci_exynos_get_best_clksmpl(candiates);
> +       found = dw_mci_exynos_get_best_clksmpl(candidates);
>         if (found >= 0) {
>                 dw_mci_exynos_set_clksmpl(host, found);
>                 priv->tuned_sample = found;
>         } else {
>                 ret = -EIO;
>                 dev_warn(&mmc->class_dev,
> -                       "There is no candiates value about clksmpl!\n");
> +                       "There is no candidates value about clksmpl!\n");
>         }
>
>         return ret;
> --
> 2.32.0
>
