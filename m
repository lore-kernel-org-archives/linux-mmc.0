Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F66C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1167B61942
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 01:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2BUT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Mar 2021 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhC2BTs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 21:19:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A047C061762
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:19:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so16861138ejc.10
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTJmlPXK9Et5rO0omoD1ZFN/iK1wPaRQINj5TjeHtqQ=;
        b=lYiiziRBmj2GB+IbKZlbmM9RX2WNr44mGVjf31mYHMeckiXJmv45Kudaf2dzpdNCjZ
         wZ6MRjv6ftUGjzL0AXJ7lrqY3+vVZeMvz1imVpT+DJOKu+M0LGS35eJTDAOoQPTIee/8
         Boc+gAFxtWEOqVF8C3FD+KREqeiCMHX/Gz+iDXIktn5TH8kbCJsexe+mY49KWZ39Lsl3
         gsR/Er3LcL3QbGv9BWpbmuYDjfDau2aiwZ0LClhsC+B3Pifg8eLrCcM4rAS9/3JKlRHU
         Via8Daz2h03vS9Vg0fjtW4GehHNIpmla/zKRYj0+fVh2/RfSdyVIZgWH71G92DdBEZkl
         QkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTJmlPXK9Et5rO0omoD1ZFN/iK1wPaRQINj5TjeHtqQ=;
        b=H3FlXrjmAayhxzBHVM4ckC4JdrflTbyvkVsl1Lfoi+ojO8tVKazcIN4YrdqLvIszxd
         a/3xNWUQSswEgq6L7FUUPXNJXLKYgJacKfdzizpZrVJ9tOAQ1wA+NqHaaoSATMQHUw2d
         nNx6qrBpdoTv5G1LikvsT5Yar2lHn9R/VuX+qLEJIq3bchza/8UotyyUQUUchl8LxTnY
         BUpYxXbrduo/jnTq4hgfk5NfTngU+IEw30yTx9DVMgK4CEAbCwwcIcBRGQfCY1dpIsae
         VQdjbRJ2f39jokfJ2dNBMJUTNsfx775QFh0Vc2et7D6FA9YNd2kD9rpENFgIpdj7o32J
         TDZA==
X-Gm-Message-State: AOAM5333D4xEej1Wyj0Dmp7p2vFctaJoVS1ALvwc1IQOUApnVqhX+Byc
        5ug4DIyjNpwoenIjz/leoKIqsk0a7d6w20y5V39skw==
X-Google-Smtp-Source: ABdhPJxUCgM9piyX/k7qbNVhsdRINxGdhoMnzDUbCOh+nLKRCALtdIKcq2Gil/lEH55ZxVLoJTsGdlPCF5JPUuvU/Jo=
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr26022772ejn.172.1616980786565;
 Sun, 28 Mar 2021 18:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
In-Reply-To: <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 28 Mar 2021 18:19:35 -0700
Message-ID: <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
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

On Sun, Mar 7, 2021 at 11:21 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:
> >
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
>
> > +config GPIO_ELBA_SPICS
> > +       bool "Pensando Elba SPI chip-select"
>
> Can't it be a module? Why?

All Elba SoC based platforms require this driver to be built-in to boot and
removing the module would result in a variety of exceptions/errors.

> > +       depends on ARCH_PENSANDO_ELBA_SOC
> > +       help
> > +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver
>
> Please give more explanation what it is and why users might need it,
> and also tell users how the module will be named (if there is no
> strong argument why it can't be a  module).
>
Fixed the typo.

> > +#include <linux/of.h>
>
> It's not used here, but you missed mod_devicetable.h.

Removed <linux/of.h>.  There is no dependency on mod_devicetable.h.

> ...
>
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
>
> ...
>
> > +struct elba_spics_priv {
> > +       void __iomem *base;
> > +       spinlock_t lock;
>
> > +       struct gpio_chip chip;
>
> If you put it as a first member a container_of() becomes a no-op. OTOH
> dunno if there is any such container_of() use in the code.
>

There is no use of container_of()

> > +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
>
> Hmm... Is it really acceptable error code here?
>
> > +static int elba_spics_direction_input(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
>
> Ditto.
>
Changed both to -ENOTSUPP.

> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       p->base = devm_ioremap_resource(&pdev->dev, res);
>
> p->base = devm_platform_ioremap_resource(pdev, 0);

Implementation follows devm_ioremap_resource() example in lib/devres.c.

> > +       if (IS_ERR(p->base)) {
>
> > +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
>
> Duplicate noisy message.
>
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

Cleaned this up in patchset v2.
