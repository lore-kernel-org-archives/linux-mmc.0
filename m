Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B26C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbiEDKli (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiEDKlg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E82982C
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu29so1640227lfb.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hz2JT0Y66JwO+O7z/3riatkMgFmDBjhZZnw+6wr0nDU=;
        b=B6BnBHWx7aPR8vkrGgx0QR9P+tAKxG1J+7DVaMCN5lDlbdTmjfEkp4yYbJAMaXF6ot
         GoR6XyNw+iIfXQgXV/bTHeQK5KJm2oaGpMAm38+Dn+5uVeb2EN4mjsEu2s3b41WpJ6+w
         /HR5DRX3jO5cAWDnEOF64aWCTdWZ2mgpq6XKxI7DWnW5u2ql4EVUIR7N7GxV2qTXyoPD
         BLnL6wjNxiiRLu6C6PZNY0O06b5ypr2XaV9JQZUx+cb1rUnX/TJh8yWtHd99UXLQ42SI
         JNS7subNRPWNu4W9cARVB9Z0ZYyaQN+HSL2DRcWgS9KTb1iLGoEWprOAPz3xqzVFOlDE
         PitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hz2JT0Y66JwO+O7z/3riatkMgFmDBjhZZnw+6wr0nDU=;
        b=ByADYETj77WT+0fS0f07SOUGZmUuVLZBJxu2WsHsTTNGK/VjJ8el5Z5SkUZDLtZ7OH
         H/lo5hYmD0MF3M5p3QnvTqbm0nQPVBRyuh6C3tdCLXGjvqYvClDyrj228JBQEKGgHU1N
         o5LYeOA8atTL5Clj8krsPMCp2/dNkKfvHaoPxFKtH8PJcFPSpQDFfS6rS8bN/1H6aiwM
         g6kAMuZ2SbhL53U7Hx11y4uu46RsI00iedcK8do7Ctk3dRWvNjbiFby9YqpJXJxfIIJN
         1qugXTS9wdo+OItLMzLt/MaJyWnJ8c0UJTjVbpAJ1AGmva3dNuPl5RRvsFenTtR38btg
         Grlg==
X-Gm-Message-State: AOAM53380hMLAffhJIcOkg759lWm7coUIhyaSyUM/kRFdOIRuOOikErX
        wKbmbOpBwSihYmLnwf5LoW7HOIFF9KiaNsjQXNxBOQ==
X-Google-Smtp-Source: ABdhPJzffJi2WxI72pnoBTPmIBBRSL7VDCNLLj4ucIPRQm9TAVtT1e6kobqBKWRLvwh7qoaz/IMaD3uO9mTQuMjw6Z8=
X-Received: by 2002:a05:6512:2627:b0:44a:f55c:ded9 with SMTP id
 bt39-20020a056512262700b0044af55cded9mr14018771lfb.373.1651660679081; Wed, 04
 May 2022 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220427120310.838843-1-wanjiabing@vivo.com>
In-Reply-To: <20220427120310.838843-1-wanjiabing@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:22 +0200
Message-ID: <CAPDyKFoCTX3E-D2OW_YMp0EJ2y872e+Nd-0XtinBD0vmwHjSZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Simplify if(chan) and if(!chan)
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Apr 2022 at 14:03, Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Use if(!host->dma.chan) instead of if(chan) and if(!chan) to make
> code better.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 807177c953f3..91d52ba7a39f 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1122,13 +1122,12 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
>         }
>
>         /* If we don't have a channel, we can't do DMA */
> -       chan = host->dma.chan;
> -       if (chan)
> -               host->data_chan = chan;
> -
> -       if (!chan)
> +       if (!host->dma.chan)
>                 return -ENODEV;
>
> +       chan = host->dma.chan;
> +       host->data_chan = chan;
> +
>         if (data->flags & MMC_DATA_READ) {
>                 host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
>                 maxburst = atmci_convert_chksize(host,
> --
> 2.35.3
>
