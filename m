Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4CFC43219
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiB1RHC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiB1RHA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 12:07:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B886E3A
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s25so18323582lji.5
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gc6ZFlJ3qZd+VgeRQ79wYKtmQCdPSDrZc3tlbcGpdsY=;
        b=f0aN3H1DwqDC8Zwuq8vAg17jHyBd+u0MohL9kpPW9tjobajn1BpYtOmtVj+na6oNlj
         BtahnqNCx1f1QQy6789N3wkofur/tYInlTdw8FvrLnaR9XAUWFJNPP6J+qzb7KJEDfdX
         MppBbNXdSAeU7/kszSeUGI6jW6ljiiydLsSR8UaBvzCd6edo0LlXr+PaGnhHd8jigrVi
         4ow9nVwFmCuHFqxpaxeyTmZqktRI9sElK62U9pd2MmsiqoHlTrgBQ2O3zoemO5254hao
         c0je//1j4v4qFimsCHnSBF649Gme0sY4tiMKVxhnPBfoZ4cq31Rwb3sYcutMBPbKo51D
         bbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc6ZFlJ3qZd+VgeRQ79wYKtmQCdPSDrZc3tlbcGpdsY=;
        b=CkmewASvTwCvoXBsb7dK5DDLgK5rftylkiyLCCQGcw2OcNiDRz9qMGkODA8aZguZoA
         /55qCk7LxevFwn5p5LaYMO5TuH4QLFI4V7zSOoZYvt1FEpfpaVSPr4YcrGnhQy+QlBvc
         ORI7iacsBBWyvqX7PTIcS8Bgss+U3lIgICvQUiR/90w6KTeLIGm9YMY3XAuaRVBbWZqC
         aWWynT/MIogGTlqrbK/nMNfG+GCZcAtVcIclLSwX0R01pbxiZ2IOxNMkEhbm+7JRH891
         WIL9gwtZmZpyOeFg/ANudb49kjvHwHWqFpLSILVJVx+MZtjs4VJpocAVGhNIn4jgzXic
         Mo3Q==
X-Gm-Message-State: AOAM531x8Y3obC0I1/L+6PJzti+pmqUNDM0OaJmUcXpBgnvHwj6gr+Ko
        +1MgOwDv/EuXR1b5qqATHJ4gNafQnX9YyRK4Ba8rtJu6/Y8=
X-Google-Smtp-Source: ABdhPJyHm1HqQ04mXe/pep6vMfFi/IIxyvU1GTcRx+IxndP6xRlwjBmljKqD6gFOuOZlTVPyVims3SmL02o0zgRxUGo=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr14902326ljj.4.1646067978836; Mon, 28 Feb
 2022 09:06:18 -0800 (PST)
MIME-Version: 1.0
References: <68d689c39c769d298b53ee8cb9de0e594a2999b2.1645460780.git.geert+renesas@glider.be>
In-Reply-To: <68d689c39c769d298b53ee8cb9de0e594a2999b2.1645460780.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:05:42 +0100
Message-ID: <CAPDyKFoYcCQqmUusJ_ZVw99d-zwF4o=qtFG0L=N5yM8S0Lg0dQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Simplify division/shift logic
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Feb 2022 at 17:27, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> "a / (1 << b)" == "a >> b".
>
> No change in generated code.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 104dcd702870c423..5f9ebf045b1cb22b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -521,8 +521,7 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
>                 }
>
>                 dev_dbg(dev, "clk %u/%u (%u, 0x%x)\n",
> -                       (best_freq / (1 << (clkdiv + 1))), clk,
> -                       best_freq, clkdiv);
> +                       (best_freq >> (clkdiv + 1)), clk, best_freq, clkdiv);
>
>                 clk_set_rate(host->clk, best_freq);
>                 clkdiv = clkdiv << 16;
> @@ -1012,8 +1011,8 @@ static void sh_mmcif_clk_setup(struct sh_mmcif_host *host)
>                  */
>                 host->clkdiv_map = 0x3ff;
>
> -               host->mmc->f_max = f_max / (1 << ffs(host->clkdiv_map));
> -               host->mmc->f_min = f_min / (1 << fls(host->clkdiv_map));
> +               host->mmc->f_max = f_max >> ffs(host->clkdiv_map);
> +               host->mmc->f_min = f_min >> fls(host->clkdiv_map);
>         } else {
>                 unsigned int clk = clk_get_rate(host->clk);
>
> --
> 2.25.1
>
