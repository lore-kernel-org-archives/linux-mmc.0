Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC6C4708E
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjABPH6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjABPHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:07:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71C95BB
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g16so20102885plq.12
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Py+mEqQrMGrkTWxmxdenUzEXoKA3++r71/dyBxZERsw=;
        b=XqAPGNKYWKsdaCjTLnL19DjUzyvHU1zDCW+L9YztruS26V5NLRL+50aGaQ0+n4MPfH
         qipaSASdXYBD80SNIVtmnM6eaTylCiYgyg1aO0KBSXzpYp3biaY32Ij0wynLb/ypdHyJ
         C74mNjYFAJFiBEfm2rINUile4beFOFRNp0EB7FD9ZU64HIKoYuTJQhYMG1B7c5To2MLv
         qENvQUSxOT2OZXLmPA6b6B4Xy6NptV0rLcYLIArt47DQJBTZP9rNvbMUHhQWyzW3LJrn
         /lcGBkXao5Xr8s0NSyz6XskOSD1PR+WNN0EU+oWzz+6xjX8yGgBv/s7Fp6imMzA/7GDJ
         l1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py+mEqQrMGrkTWxmxdenUzEXoKA3++r71/dyBxZERsw=;
        b=rFYSAElgV1Eav/+Clt1w1+q+X+GT1EX6+mVnXLzLBacw6uS++zr8zzOr2ayJaqfL2j
         +wo0PiKwTbnKSrUuQzNtcX3/QotMR+IwHR5qRQIEMrbNtLZ9MReNXKwZFprJfNO+52Gb
         8paYFeyIE3L5+vV/LTikgrFSeYCpTRdB5JHWpAYtM0mbuEztLeKbRjkJk6pIK0HMAjbW
         YRBnks6vcbDjB1meLQdmcwIvyc7B0PrTSsH05crRXnF1IvOFKEUr9ly5B4u+G0J6abBD
         KayyeAKs9Dsqe54rj/kOfK1FTs9/6ZdgltIyjzDESKGKZZcB7+UHGF1laoiik1IlSuoV
         2zDg==
X-Gm-Message-State: AFqh2kpmHsOCcMvayJMKaJdGMUjCIiA4Fs5AXLjSoN+HXoie07LO1bvF
        BgPiXp10NRaRMc4563r9bgj6qX8nujypEOleaWgvJw==
X-Google-Smtp-Source: AMrXdXsb/89JOjMTTfy2Q3dneSOnFo/ez0oRGNhv5+8eBCdxAb2lUwf/bIShv7DuOj+vHcfQTv5jcLFKZG+LBoqY5GM=
X-Received: by 2002:a17:902:b902:b0:190:e27b:b554 with SMTP id
 bf2-20020a170902b90200b00190e27bb554mr2443908plb.148.1672672062362; Mon, 02
 Jan 2023 07:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
 <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com> <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
In-Reply-To: <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:06 +0100
Message-ID: <CAPDyKFqRF=X755_H9418i1WZ4W-PxMwkzFnkcRco9mmycYHiPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hari.prasathge@microchip.com, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Dec 2022 at 01:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Balamanikandan,
>
> thanks for your patch!
>
> On Mon, Dec 26, 2022 at 8:39 AM Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com> wrote:
>
> > Replace the legacy GPIO APIs with gpio descriptor consumer interface.
> >
> > To maintain backward compatibility, we rely on the "cd-inverted"
> > property to manage the invertion flag instead of GPIO property.
> >
> > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
>
> Overall this looks really nice! I thought about converting this driver
> but was a bit afraid of doing mistakes since it was a bit elaborate.
> Nice that you use fwnode accessors!
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Linus, thanks for helping out by reviewing this!

>
> Improvement to consider (can also be a separate patch):

I tried to apply the $subject patch as is, but it failed. It needs to
be rebased on top of my latest next branch. Please re-spin and if
possible, consider incorporating Linus's suggestions too as part of
the series.

Kind regards
Uffe



>
> > +       if (slot->detect_pin) {
> > +               present = !(gpiod_get_raw_value(slot->detect_pin) ^
> >                             slot->detect_is_active_high);
>
> Normally we contain all this active low/high mess in mmc_of_parse(),
> but I guess this doesn't work here because the of node is different
> from the device :P
>
> Since the code says *explicitly* "active high" not "inverted" as the
> core code parses it, could you try just push this to gpiolib like
> we usually do, by deleting the detect_is_active_high stuff and
> just apply a patch like this?
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4fff7258ee41..5979c9a75cf9 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -199,7 +199,9 @@ static void of_gpio_set_polarity_by_property(const
> struct device_node *np,
>                 { "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" },
>                 { "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" },
>  #endif
> -
> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +               { "atmel,hsmci", "cd-gpios", "cd-inverted" },
> +#endif
>                 /*
>                  * The regulator GPIO handles are specified such that the
>                  * presence or absence of "enable-active-high" solely controls
>
> (It's fine to include in your MMC patch if some GPIO maintainer like
> me ACK it.)
>
> Yours,
> Linus Walleij
