Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE9C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D150610C7
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhHXO5o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhHXO5m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10FC061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:56:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c12so38228458ljr.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BaKMMftaKC5YhKTtM5Bz4f0qWZAv1dZSHl+9yvVw0ew=;
        b=AUuhGkE/oyDh7CtWwCt5f/4o5tKkXCIhIN4OpnhKYZAzl0Mp/9tWKDHaks6KT1gVwg
         24HkwVZGhnfm9kLx8EeO7FjPjfY07L5QO2GDp7E0JCapxDBR7RGM8BHQOLToew+szZ74
         C5/2N3xYewGKWnTtQnS/A7Ojz6FRFxs+1G91aPYq+3W+pHubZtR76ZCD6jRnjC4HmHyt
         3C3xe1hFBSjPR65vKCAJ6bcHJLKFsrLPcBlGuhFNqkDu5h86Vh2dZYLqsP9Hs13POJfX
         ZE5qYtV1DW4xPC598y8sR9Mofj/E/mj7NlPJWccJNCtCw+7yHHmzfQ/z3VljxyuTwRLy
         fJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BaKMMftaKC5YhKTtM5Bz4f0qWZAv1dZSHl+9yvVw0ew=;
        b=KEYo/P8m5OoirSS1Iek6p0tKshE3Sr/LKbB0yxz6zvOJBwx2li8nqFufDMUAgsVQ3C
         3544+/9R76MOjCrRzzmOjO9VbBa8VUl/aiHygmpYxoI1yVuHbUbW4GGpFq0WthtTuxoy
         E6ic/S5PRBNmL5LSSvGboCYpRM1NT+eurZO0nV7M4vCmMJtpuO924nnF0kui07flJcSL
         ZYFW490507XChsrO37BJkgQa9Rayq3i98Vnns+1bxSaUfi7CN5Hc5VN2Z10Jm4C6r20f
         wnPFlyl0SFZLuRsPBCPz9Tsehhj/mgdLLZOqmB4JZiYsh1gVjGuUnn3X5YqrCyhNmVVB
         6DXw==
X-Gm-Message-State: AOAM531RZFWpvZ5B3eSU5EYKttjVtdOj6LG+FYqLOHqE3n9zPhCbnSdp
        hqbKNp705mE6AFgfIcQsAzJj5iJNPfkhKyD3RWwGEQ==
X-Google-Smtp-Source: ABdhPJx5sU85/aP6QNujApIBYstitB0UrqtX4lrnhN2KQ2qsSd1RxCqzYoZ7ymE4DQ0PitzckKsIusXW/xsO4Jwq9Ps=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr32647933ljq.341.1629817016972;
 Tue, 24 Aug 2021 07:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210816142314.1168-1-marten.lindahl@axis.com>
In-Reply-To: <20210816142314.1168-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:19 +0200
Message-ID: <CAPDyKFqbbuScNGzVLQG1pY0+tP-sQUxwV0iafKkLASeJTLBG=A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: usdhi6rol0: Implement card_busy function
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

On Mon, 16 Aug 2021 at 16:23, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
>  - Update commit message, since interface limitation for checking DAT
>    lines is not valid for this fix.
>  - Skip check of SCLKDIVEN bit, and skip check of DAT3 line since SD
>    specification only points out checking DAT0 for busy signal.
>  - Update comment about card_busy callback.
>
> v3:
>  - Split header file change into separate patch.
>
>  drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
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
> --
> 2.20.1
>
