Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B83C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 11:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiDDLzN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiDDLzL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 07:55:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF123DA53
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 04:53:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y32so1498251lfa.6
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2022 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqg0JG2bYMOlD6F3+AHo1Qsj61f1ApR+ao40cjbbIVI=;
        b=lzYDOAj3hgO3n6rtww73HeOYSeHxdj0u+oYgtLKMWGTstT9aPEtIPRsPSFvtYMEm0Q
         eg2sheiYil9u1Zt3GtsePYCFPstXmCjQrgqbOx+mBZAbC5ewfPssr8Ii6ph3PhGHmD71
         1Fsg05cEqzqnNE/WKKBlx8D4z9JRiK0HwU4JWJi8ZZ4oj82MMkJed2m7x9wm1LHVbDZZ
         nmi8vLnGBqAK2a3KFID6Qpmdk/q1kL6Hjtv8FLVck0AZDbdgJgy2IzwFrIlSYk4rIdPb
         fSLb+mccXXUbdsC/OZGbqbKAmyVaq/SjlJlWj415mxGzl3YcyKk1gC/6ae0YlQKAGLgi
         VysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqg0JG2bYMOlD6F3+AHo1Qsj61f1ApR+ao40cjbbIVI=;
        b=SjDBIS1QGKLLoqilhlLFmyf5LGIYWXbC1UJMgTO4yVnrKu2LK6fj5GRb+zElJtXP7A
         V3ccg2S9V1e2CB6P10n+OtyLuwkHDea/UyEwIeK54eJI1cy8/APbJNDNAO0PNpRvE+hm
         rpeGEuwDYDlqr/z1xfl6y4Msrm6Ivzrxlcf5c/Y1bkCAn3HgJR3hQb/Xbov6VThLslXa
         G+2jJebKaSArIMz1VBF11guDvJ9k5+nVWq/4ooWXmP0fFbqhgDYK4yqNKZdw8Eo5KRAv
         O5ZDuavmpec81QvqtDgxjEJ9pYDjZPnyJW2kLSm39EGPJ/07t3NvppceCHwNLRh+Nl7M
         XBMQ==
X-Gm-Message-State: AOAM530p5+JX3ckcst4nnXi4oNfEHrldhvB06QxUxrV43OdpfjU3g/MW
        Dl3fTWNqNDOsLjRrhy3vJf5tjD1JrP0Ojo1WE9DvSg==
X-Google-Smtp-Source: ABdhPJwoUF8BRiRIT5vjDQ5OByUaXROoJfEbVkEjoIjq+z5nOG2IHwFJWAdY05shxB+DEwdorbi5llik2IIbz51LdHg=
X-Received: by 2002:a05:6512:108b:b0:44a:6dc2:ffeb with SMTP id
 j11-20020a056512108b00b0044a6dc2ffebmr22844986lfg.184.1649073193182; Mon, 04
 Apr 2022 04:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <cc3178c2ff60f640f4d5a071d51f6b0b1db37656.1648822020.git.geert+renesas@glider.be>
In-Reply-To: <cc3178c2ff60f640f4d5a071d51f6b0b1db37656.1648822020.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 13:52:37 +0200
Message-ID: <CAPDyKFp9gq8-4V26Ujz82CRwZ=T1T9L13atmSjnGTspRLsSLyw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Add missing checks for the presence of quirks
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Apr 2022 at 16:09, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> When running on an system without any quirks (e.g. R-Car V3U), the
> kernel crashes with a NULL pointer dereference:
>
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000002
>     ...
>     Hardware name: Renesas Falcon CPU and Breakout boards based on r8a779a0 (DT)
>     Workqueue: events_freezable mmc_rescan
>     ...
>     Call trace:
>      renesas_sdhi_internal_dmac_start_dma+0x54/0x12c
>      tmio_process_mrq+0x124/0x274
>
> Fix this by adding the missing checks for the validatity of the
> priv->quirks pointer.
>
> Fixes: dce2ba8b2ee8cef6 ("mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk")
> Fixes: d4bfa17a655c6de2 ("mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 6dd5ade3851b2ba8..90048f74e6221add 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -374,7 +374,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
>         struct scatterlist *sg = host->sg_ptr;
>         u32 dtran_mode = DTRAN_MODE_BUS_WIDTH;
>
> -       if (!priv->quirks->fixed_addr_mode)
> +       if (!(priv->quirks && priv->quirks->fixed_addr_mode))
>                 dtran_mode |= DTRAN_MODE_ADDR_MODE;
>
>         if (!renesas_sdhi_internal_dmac_map(host, data, COOKIE_MAPPED))
> @@ -382,7 +382,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
>
>         if (data->flags & MMC_DATA_READ) {
>                 dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
> -               if (priv->quirks->dma_one_rx_only &&
> +               if (priv->quirks && priv->quirks->dma_one_rx_only &&
>                     test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
>                         goto force_pio_with_unmap;
>         } else {
> --
> 2.25.1
>
