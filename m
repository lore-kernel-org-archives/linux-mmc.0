Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98118C4320E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9826135E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhHWBF7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhHWBF7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:05:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF2C061760
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:05:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cq23so23582638edb.12
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I+jvIuGkrYC7w12Jy77CUvwauedMrIdRwXtD/swi0U=;
        b=PJ2lRFHHDJGTdGZgqkx8nm0C86/LsPvaA1plQiLWFsazUABz8Yc1GKrNB1BQebP/Rm
         PZOTpqcjJA3c63TrlvEaSd9Nl4IAAmXXx22NUFr+a1YUH4v/xU8kJS3YhojZFgciqq6c
         3pF3A5e3/flNGz5+xe0wFzOD8qTt9bGjHTA5wa1Fvx0NjEcMhjV1lOqg+y5AZpMs8uRO
         UL8MO/ANO9YNVs/zhJP5dQVnCSFKf/lKw7h+zDwmT/AUdweiArEVhlAbseZHAVwKbAqR
         Gxm//N0qMKiEZdmqBeDtkOLbvh1vfHMW8t3PCN9jiSrZYrm7JleLO/JDGMNpXYlaCBj2
         WZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I+jvIuGkrYC7w12Jy77CUvwauedMrIdRwXtD/swi0U=;
        b=Wxkz2uYGbAcbDWwRKWUH/CxQARxkDX3v9X5CtZ9F1fG4nGC5W8oOc3q00EMNRk6NXZ
         +DVpeHo4lcAu8iqwSHW6Rl1yR8aFK/qAkasktbL00ylZHzRPzPp2vbHgKkCENTv+xdRd
         HLMLENZn2usAT8xqNLPOIBmHRL9/XFKDGoPkOAOY+qFp4L8yJRGSzpcmtv5uJuRzqhQi
         6etiueAKKY9TzrnU/FPauk4FhT793rImXyjHCQt5I5UhPjW7mjN1iY3HhsiUTveaqf8s
         9cjAc5ChYzg207VPVpMPqiv7xT6mcuNfAE3V6pHeuvzRG2cB6V/qyrEyNrCqX9oo65+T
         oz/w==
X-Gm-Message-State: AOAM533DDKVa98sSxl5I80h+cy7V1R4ZhnTMLWpGmkrOd6VES/3W6OSc
        BSXaxbASlgXvE8Uu+DH3adyl6s9fn92bvRDmzi+dWw==
X-Google-Smtp-Source: ABdhPJykJY1zWrWHmNv1qhh0XGc9mZHysTgRPPx0BaMujb9Mx9dYhMjPxl8GGwLIWVx58MUoIp0bAc7SpECJwSg9rjk=
X-Received: by 2002:aa7:c894:: with SMTP id p20mr34410895eds.42.1629680715488;
 Sun, 22 Aug 2021 18:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
In-Reply-To: <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:05:04 -0700
Message-ID: <CAK9rFnyf3WLSPe8A=WWCBUqs3htkAmhDQq0ftcEOq_fnenWQPA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

On Thu, Mar 4, 2021 at 12:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:
>
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
[...]
> > +#include <linux/gpio.h>
>
> Use this in new drivers:
> #include <linux/gpio/driver.h>

The updated patchset will use linux/gpio/driver.h

> > + * pin:             3            2        |       1            0
> > + * bit:         7------6------5------4----|---3------2------1------0
> > + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > + *                ssi1            |             ssi0
> > + */
> > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
>
> So 2 bits per GPIO line in one register? (Nice doc!)
>
> > +struct elba_spics_priv {
> > +       void __iomem *base;
> > +       spinlock_t lock;
> > +       struct gpio_chip chip;
> > +};
> > +
> > +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
> > +}
>
> Write a comment that the chip only supports output mode,
> because it repurposes SPI CS pins as generic GPIO out,
> maybe at the top of the file?

The top of the file will look like this in the updated patchset.

 * Pensando Elba ASIC SPI chip select driver.  The SoC supports output
 * direction only as it uses a generic GPIO pin for SPI CS.

> I suppose these systems also actually (ab)use the SPI cs
> for things that are not really SPI CS? Because otherwise
> this could just be part of the SPI driver (native chip select).

The SPI cs are not used for any other purpose, we needed four chip
selects and native DW supports two.

> > +static const struct of_device_id ebla_spics_of_match[] = {
> > +       { .compatible = "pensando,elba-spics" },
>
> Have you documented this?

Yes as part of patchset v2: [PATCH v2 11/13] dt-bindings: gpio: Add
Pensando Elba SoC support
which documents "pensando,elba-spics" in new file
bindings/gpio/pensando,elba-spics.yaml.

Regards,
Brad
