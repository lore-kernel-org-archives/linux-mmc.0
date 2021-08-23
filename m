Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1288C4320E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1C96135A
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhHWBLP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhHWBLO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:11:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C2C06175F
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:10:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so8607203ejf.13
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WpSLT/7mvQ0ddiub005tUp0P5hRLIeXnnTQ1S0shMs=;
        b=s3xm8mzSflJhA7DLhHG0BDMFRU4hpe+uocF9gcVx7xNGhAMWbe/WjJUeIzUx5QaejL
         +SqM3MUb7wlpsSuhnUNpGkgFf1T7nZHK/Cl0eagk2Flvh4RxkTxkfkZl+LGkMSbsKnDK
         0mWIkOcazsClJAKIteA3RIWRHlzfKT24IXQbbFoO280Okc2uw5kO3UBohXqQ/zvfYLP/
         0CSAARIGVOXsq2qEHSr5sl2PxxvxqHAvkFLjK6Pb/by65FaYLU3biakM2ojHvEJJ8Z95
         K5gHLsteQ9HAMrEQpo9SheV2gMbTfmciQU3iHzwuISsQxwxQNerdw0UxpPUQ8A3J1zqU
         +2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WpSLT/7mvQ0ddiub005tUp0P5hRLIeXnnTQ1S0shMs=;
        b=YtmQLoreaSg4pwUq7VRtBMJi7v9MMNKGLIuXe8YmrLviYOYlk3N4xMIy/gWT65xurQ
         VhRXDWDpcka2UEs9R8BPuR1fPr+53x6sRzNubbG3ypOKY95kdwF+2D0PIjWKIvHTItDv
         KpeEKHTD65CAeRLutWhWhGH9jVlhUr1WoDxhXWD200PI/452lQoNBi3exdXWmOS/+EHy
         kFmr+cHjgTC/E3UUxAHINV9iuZ+VPziV3cXttBbPbP7zT95a/hDoF0dyXBmzZjeNuoGw
         M5mTZnlJ3i9OleNndetmc4dymysc/DSAra6rgNZm97Wsx4WfDf1G4rG3FL0fHMvd8oWb
         3SBQ==
X-Gm-Message-State: AOAM530oFhmylv0yVVcQypNdX5yEwxJ4vT0NcpV3bF6dxCyrSKQS/lym
        EF0+u2yxUyLogLLDrq+hAlmKRZoXbN8RH+an3F0K6w==
X-Google-Smtp-Source: ABdhPJwoUhTy7MVM+JzeHkwt6ZjUT1Elkvq3lKIh0CVbdlBKuysswcQBu6QWowS6l3a9c2D870aLZs6VYegUJyeZ+6w=
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr32915513eje.425.1629681027447;
 Sun, 22 Aug 2021 18:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
In-Reply-To: <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:10:16 -0700
Message-ID: <CAK9rFnxgdyxM11n6PaqG_phuDMXnHYWSm+Xaqg89dMYCF3CN8g@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Andy,

On Sun, Mar 7, 2021 at 11:21 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:
> >
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
>
> I will try to avoid repeating otheris in their reviews, but my comments below.
>
> ...
>
> > +config GPIO_ELBA_SPICS
> > +       bool "Pensando Elba SPI chip-select"
>
> Can't it be a module? Why?
>
> > +       depends on ARCH_PENSANDO_ELBA_SOC
> > +       help
> > +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver
>
> Please give more explanation what it is and why users might need it,
> and also tell users how the module will be named (if there is no
> strong argument why it can't be a  module).
>
> ...
>
> > +#include <linux/of.h>
>
> It's not used here, but you missed mod_devicetable.h.

Based on the feedback I realized this should not be a loadable module.
I should be using builtin_platform_driver(elba_spics_driver).
Currently I have this for gpio/Kconfig

config GPIO_ELBA_SPICS
        def_bool y
        depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST

> > +/*
> > + * pin:             3            2        |       1            0
> > + * bit:         7------6------5------4----|---3------2------1------0
> > + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > + *                ssi1            |             ssi0
> > + */
> > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
>
> > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
>
> Isn't it easier to define as ((value) << (2 * (pin) + 1) | BIT(2 * (pin)))

Both are functionally correct.  I don't have a preference, do you want
this change?

> > +struct elba_spics_priv {
> > +       void __iomem *base;
> > +       spinlock_t lock;
>
> > +       struct gpio_chip chip;
>
> If you put it as a first member a container_of() becomes a no-op. OTOH
> dunno if there is any such container_of() use in the code.

There is no use of container_of() for this structure

> > +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
>
> Hmm... Is it really acceptable error code here?

No it's not, thanks.  Changed to -ENOTSUPP as gpio output direction
only is supported.

> > +static int elba_spics_direction_input(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
>
> Ditto.

Changed to ENOTSUPP

> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       p->base = devm_ioremap_resource(&pdev->dev, res);
>
> p->base = devm_platform_ioremap_resource(pdev, 0);

Changed to single call to devm_platform_ioremap_resource(pdev, 0)

> > +       if (IS_ERR(p->base)) {
>
> > +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
>
> Duplicate noisy message.

Removed extra log message

> > +               return PTR_ERR(p->base);
> > +       }
>
> > +       ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "unable to add gpio chip\n");
>
> > +               return ret;
> > +       }
> > +
> > +       dev_info(&pdev->dev, "elba spics registered\n");
> > +       return 0;
>
> if (ret)
>   dev_err(...);
> return ret;

Yes, made this change and will include in v3 patchset

--- a/drivers/gpio/gpio-elba-spics.c
+++ b/drivers/gpio/gpio-elba-spics.c
@@ -91,13 +91,9 @@ static int elba_spics_probe(struct platform_device *pdev)
        ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
-       if (ret) {
+       if (ret)
                dev_err(&pdev->dev, "unable to add gpio chip\n");
-               return ret;
-       }
-
-       dev_info(&pdev->dev, "elba spics registered\n");
-       return 0;
+       return ret;

Regards,
Brad
