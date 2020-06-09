Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DBC433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0936A207F9
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dssBi8/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFIKCV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgFIKCU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 06:02:20 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39AC05BD1E
        for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2020 03:02:20 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y123so11582282vsb.6
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2020 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOXr7nsca37iiptugzIdql/m6OOhx4OtKtMb7kRPm1s=;
        b=dssBi8/fZQlcH6Zx/hiX5vpqwbn7JG7n2fZ8rQk8601As0FuOAOMpi32y3obdFiOye
         SbQGgiyN4azsymqUeYBQckHQWaEIYRfP6NB3Yf1w6KReSNDRkXGbzt3ZmsyYRLhKnItJ
         RplgyEPrNauDZBwFxqEYpo3K6873h0OfhArHROMggm6+4HJjPCfvdrFZt6sZPzqHtoIM
         sQxj0H6TcljV3Ngt6cY7S+1e87cotL1DywMhdHsPY7xcu2J4Wd0hxj0vRV+RR9j+GFls
         LpmlcrSrCBC8gfSyzBfQjqjRq0RlYW/7dGxmJq7GAf7d+xRwMQ49te074RdnLN5xDqqp
         0aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOXr7nsca37iiptugzIdql/m6OOhx4OtKtMb7kRPm1s=;
        b=Dfe5a4tVUvaj6A1BY9NJqAVbmn+WrnoHp4XW4IQ2faWlXRufr6Q4lGYNk8BEMB/ks8
         hyKDYEXlU/bl3Mry9+9hv40H3I/kNwXmjBc3CnziWW/XyEnlMHSF2FVsomq3rVK0NKQO
         6Srwzk7JLjZ8Ed83XsoT/GB6/BRROuojk2tgKpRsmKm08ueMsymiXdt47iarAaKeOQtf
         0g/S276DVZ24XFqfWxm3SRGm9SKPHir0HNxFQi2U13fWoydQluev020TO4CgAEOhS+5p
         z80i3YCriw2Lu/UZ4mFnj3p+6WgTEiJWaxM9vL8/0UN04UYmdiRypjBczIl+NWLCbeP/
         9omw==
X-Gm-Message-State: AOAM530pW+dTL92V+5ODN77ESx1HEUeAWmQvFLxWK1BPWVYnbr5EtHpX
        2R0kg+LZERnIvVdWrSv8xQUSuc8WX6UHDjxFLBJaXw==
X-Google-Smtp-Source: ABdhPJwN1YIVs5G9p/I0Ss5PinWxQSjST7esl7c/LesaOMO8JE43NwYVoy/kC4JxyhD2rnFnrRF/230yq4iXU5eoYvA=
X-Received: by 2002:a67:db88:: with SMTP id f8mr2051190vsk.165.1591696939065;
 Tue, 09 Jun 2020 03:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200609081431.6376-1-zbestahu@gmail.com>
In-Reply-To: <20200609081431.6376-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Jun 2020 12:01:42 +0200
Message-ID: <CAPDyKFr+NKoQVLqK9J-gmW9E7pwfZKeJQ8JEdx792jDA1kYKiA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Fix 1-bit mode for SD-combo cards during suspend
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        huyue2@yulong.com, zhangwen@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Jun 2020 at 10:14, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Commit 6b5eda369ac3 ("sdio: put active devices into 1-bit mode during
> suspend") disabled 4-bit mode during system suspend. After this patch,
> commit 7310ece86ad7 ("mmc: implement SD-combo (IO+mem) support") used
> new sdio_enable_4bit_bus() instead of sdio_enable_wide() to support
> SD-combo cards, also for card resume. However, no corresponding support
> added during suspend. That is not correct. Let's fix it.

I believe the change makes sense to me.

However, the commit 6b5eda369ac3 that you refer to is from v2.6.34,
which is more than ten years ago. That makes me wonder, are these
cards really being used?

Did you test this with a combo card?

>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/mmc/core/sdio.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ebb387a..2d2ae35 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -285,6 +285,27 @@ static int sdio_disable_wide(struct mmc_card *card)
>         return 0;
>  }
>
> +static int sdio_disable_4bit_bus(struct mmc_card *card)
> +{
> +       int err;
> +
> +       if (card->type == MMC_TYPE_SDIO)
> +               goto out;
> +
> +       if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
> +               return 0;
> +
> +       if (!(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4))
> +               return 0;
> +
> +       err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
> +       if (err)
> +               return err;
> +
> +out:
> +       return sdio_disable_wide(card);
> +}
> +
>
>  static int sdio_enable_4bit_bus(struct mmc_card *card)
>  {
> @@ -960,7 +981,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>         mmc_claim_host(host);
>
>         if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
> -               sdio_disable_wide(host->card);
> +               sdio_disable_4bit_bus(host->card);
>
>         if (!mmc_card_keep_power(host)) {
>                 mmc_power_off(host);
> --
> 1.9.1
>

Kind regards
Uffe
