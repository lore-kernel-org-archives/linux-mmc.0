Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311EEE49A0
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Aug 2023 12:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjHWMl3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Aug 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjHWMl2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Aug 2023 08:41:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B6E45
        for <linux-mmc@vger.kernel.org>; Wed, 23 Aug 2023 05:41:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a1ebb85f99so4060767b6e.2
        for <linux-mmc@vger.kernel.org>; Wed, 23 Aug 2023 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692794486; x=1693399286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/f7T3FZf5QGSLEO262NyuWeijF0vG1zwz/aiGhEhO0=;
        b=sr8rx74L1zfe5NRH3/c1LNcfCpc1f8v2uvrU94iCS9tu5m4puB6UFiog6hf29WcVOL
         fWPjolJMZ8q/OrmRrs3XtWYMVXD43Hzye8A0YgH0Z4+8uub6URQ0BFy4kXsrYfMAUYO4
         U+Osy05eZffzhbonC5XyLYPoSdD6+dmhf0eUjYyOv4ufmc56b1cVeML3pX3MaSTdAiq0
         R84zBhoO4GWpBQ56nhP1hXX+3eguE8UrV26FiWotpz6QcHiiXVCBvTQJwrZ1xQGeRLN4
         iVCuldTdO13IcvOP6ca19/MuwLYdVUyFxw2RuZvqU5H0fCnd/4Iy0cpIg7R1fthThHRS
         /8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692794486; x=1693399286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/f7T3FZf5QGSLEO262NyuWeijF0vG1zwz/aiGhEhO0=;
        b=OLIj0PlmZ0T+UhlGS5DIBlYJi6UbG+8sJjqiDBHsiJKQCe10Zk3hzPHi7wZiTGA3Ra
         CrR5ARHQp4v8RKIT60zVb0s+QRWP8n2+Yz1MKfCrgFGRArQ1cnrB2KXNc7x/1WAnrDS/
         QUEHbkIEvR+PS4HwFa0+W7Ig0ev5DU6oamiNAgw4zOVohPAKpkt8qH38PE6io90MyHH0
         AS0XkeqUWaE9o+UXkYQdXuvoqm6a/2pPEInSWzXx/hRh90QOFs1E0B6PYm1nJzhhl69+
         /B9GBnkTCVXMMUQ8IevMTMJdXW7+iB8Ck8ExKrF93IPjjcsl2PJRYyL8YNAOFMhwo93u
         uF9A==
X-Gm-Message-State: AOJu0Yzh6f3Nqqco31tMds33qB9H/E/iY4ekwmC+JsldS7UOCSO4ZrVP
        qOysDHg7ZR0CyG7GFoR3cf9vOruKq4Owj5OQ52aFnw==
X-Google-Smtp-Source: AGHT+IGEVmJslUpD3TVQwsDHcK7stA8pSL9fmRj2QDvtZ9ZXvOFRcGwz5G+dkmi/efeD5ViaafkbJuoJhokEz4S2QrQ=
X-Received: by 2002:a05:6358:33a2:b0:135:99fa:a125 with SMTP id
 i34-20020a05635833a200b0013599faa125mr12763757rwd.1.1692794485931; Wed, 23
 Aug 2023 05:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com> <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 14:41:14 +0200
Message-ID: <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Balamanikandan,

thanks for your patch!

On Wed, Aug 23, 2023 at 12:40=E2=80=AFPM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> The polarity of the card detection gpio is handled by the "cd-inverted"
> property in the device tree. Move this inversion logic to gpiolib to avoi=
d
> reading the gpio raw value.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
(...)
>  drivers/gpio/gpiolib-of.c    |  7 +++++++

Patching here is the right approach!

> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +       if (of_device_is_compatible(np->parent, "atmel,hsmci") &&
> +           !strcmp(propname, "cd-gpios")) {
> +               active_high =3D of_property_read_bool(np, "cd-inverted");
> +               of_gpio_quirk_polarity(np, active_high, flags);
> +       }
> +#endif
>         for (i =3D 0; i < ARRAY_SIZE(gpios); i++) {
>                 if (of_device_is_compatible(np, gpios[i].compatible) &&
>                     !strcmp(propname, gpios[i].gpio_propname)) {

This duplicates the code right below. Can't you just add an entry to the
existing gpios[] array?

I would imagine:

    static const struct {
        const char *compatible;
        const char *gpio_propname;
        const char *polarity_propname;
    } gpios[] =3D {
#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
        { "atmel,hsmci", "cd-gpios", "cd-inverted" },
#endif
(...)


Yours,
Linus Walleij
