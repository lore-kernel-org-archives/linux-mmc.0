Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219BBC432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0966B63305
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhHPOAq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhHPN70 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 09:59:26 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA30C061764
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:57:55 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 67so7595453uaq.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H6rP73O7yrQOghdkMu/kjkj8OVe3TRwlYKLSrAJ8Wgw=;
        b=Ik04A3r/usn4wFR/Cy779M3gm6pntJCNpyLogkzrLvZuaQ2mn0WOUybb2rP8t5QHAk
         SsefQhMLO9FcWFKIDUdZ8+baaZlGmp+fg+0E1u49yuvtj6giVaYSN8PVjFcxXHHQF176
         pmTWZPK9RgunbPKi6yoYVwpcPh8F2xEZmF3ePmRp9bhNtY50bc1NDd/IxJ7W7B351P1a
         g0Mek4AvCxGfWmYvF7zYpp71fwjDWVG1RIiJ1tolvtSVTDja+GFi60o2LHPYMW2wjxOP
         AItFr02JKZnN2xOA3kgrWLWlpVg4PZi2kIrapYrsa9YPkBa3DRNjf+GKAxRj+s9xTXi5
         EB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H6rP73O7yrQOghdkMu/kjkj8OVe3TRwlYKLSrAJ8Wgw=;
        b=o6fi5rfm/WZXXkKhs5kBQ31wRKjMdaGvqYrYG8mzR/jS/T8cRw6Yl8dWk484us+TpU
         2siyeeRdKh8N+a0hILR1DPXhdPULHkIrjciWtgHqkiR6wHs1Vbf5vDm6CX587aX4A8iW
         NfySn9mmSbfdyiId6Rv20vuW/8mzwhBQPEQAm+JE7A172qPvt/hLGAqh55kYwImpkfEI
         oN2ZTGd/CKPDkX9j8AIglO+ERrK6VPjZSrjwqlKrlUMwXN6vEDXvJrnWfG5BKDusOQAk
         ZW3589rBKW0IrxBZIpW5H4bKU6w9wnNHvtBiLvv44t2wTmLn2juxAf1NHNd/Pq5WDkak
         6aBQ==
X-Gm-Message-State: AOAM530KKUiYjBz3E2hhTS6ZSssFxjUV2ty29NKXBNBmjAfzLva+nINr
        RBycl1zd8rnkIV7buBEhyL5mpCDnywFvAnKso3igdA==
X-Google-Smtp-Source: ABdhPJwIzme2MztbsJ2VfP0GDC8BulDXr76VSB6lrBuDSNuQqM5vqFrk8XkBQqCAbTo3YzQyedpRvDH+6keHsl+Hxuc=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr5593566uap.104.1629122274189;
 Mon, 16 Aug 2021 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210816125243.11623-1-marten.lindahl@axis.com>
In-Reply-To: <20210816125243.11623-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:57:18 +0200
Message-ID: <CAPDyKFpLCAvV3VqSiLJYUQJ6eWMJyqA4JpZg_JVYVbcT-gPXyw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: Implement card_busy function
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>, kernel <kernel@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 14:53, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
>
> When switching card voltage to UHS voltage the mmc framework tries to
> check the card busy signal, meaning the card pulling DAT0 line low,
> before the switch is made. Drivers that does not implement the card_busy
> function will manage to do the switch anyway, but the framework will
> print a warning about not being able to verify the voltage signal.
>
> Implement card_busy function.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> ---
>
> v2:
>  - Update commit message, since interface limitation for checking DAT
>    lines is not valid for this fix.
>  - Skip check of SCLKDIVEN bit, and skip check of DAT3 line since SD
>    specification only points out checking DAT0 for busy signal.
>  - Update comment about card_busy callback.
>
>  drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
>  include/linux/mmc/host.h      |  2 +-

The change looks good to me, but I would be even happier if you could
split this into two patches. Would you mind?

Kind regards
Uffe

>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index b9b79b1089a0..b5ab133e9add 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1186,6 +1186,15 @@ static int usdhi6_sig_volt_switch(struct mmc_host =
*mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> +static int usdhi6_card_busy(struct mmc_host *mmc)
> +{
> +       struct usdhi6_host *host =3D mmc_priv(mmc);
> +       u32 tmp =3D usdhi6_read(host, USDHI6_SD_INFO2);
> +
> +       /* Card is busy if it is pulling dat[0] low */
> +       return !(tmp & USDHI6_SD_INFO2_SDDAT0);
> +}
> +
>  static const struct mmc_host_ops usdhi6_ops =3D {
>         .request        =3D usdhi6_request,
>         .set_ios        =3D usdhi6_set_ios,
> @@ -1193,6 +1202,7 @@ static const struct mmc_host_ops usdhi6_ops =3D {
>         .get_ro         =3D usdhi6_get_ro,
>         .enable_sdio_irq =3D usdhi6_enable_sdio_irq,
>         .start_signal_voltage_switch =3D usdhi6_sig_volt_switch,
> +       .card_busy =3D usdhi6_card_busy,
>  };
>
>  /*                     State machine handlers                          *=
/
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0abd47e9ef9b..ff1a251bb0bc 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -153,7 +153,7 @@ struct mmc_host_ops {
>
>         int     (*start_signal_voltage_switch)(struct mmc_host *host, str=
uct mmc_ios *ios);
>
> -       /* Check if the card is pulling dat[0:3] low */
> +       /* Check if the card is pulling dat[0] low */
>         int     (*card_busy)(struct mmc_host *host);
>
>         /* The tuning command opcode value is different for SD and eMMC c=
ards */
> --
> 2.20.1
>
