Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F3C43381
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E1860249
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 08:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhCDIax (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbhCDIa0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 03:30:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD742C061760
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 00:29:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so41797341lfu.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 00:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/YunITDzSj54Y4k2da7IIbwcZOzFgpMcTcXrvSJIsY=;
        b=JaUPYLR7xkZXBatHr7s2xfITNdM0H4Jctt/Fw2uA9rVTPRXS2ypGfQgeG9h77/gY5y
         7R8yulF7mLSY0OgIKuT6J/Ojr06v7NT7A6N5Nkq6CnoaP8Yr0tttUmgXRo9RzzIK0UnP
         UVtLZe4POq614g7G8HEaMlTlNd/edz0pZ/qrLnEd/fMjim5WibSx3ajwVPMfR0eZ2ABR
         f02UlJEuLJBHeRh0WEyp58aIIIxQeyyyLJX8vDD1h13rv3fk1tJqBy+UArpvwCFZt+GW
         WZgE6/MLDaJg5nIEm/9E9KW4ILP0L+viXBuImxX4kz7o8HLReWKq8Y/Pv7jUdUKfuVSr
         3rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/YunITDzSj54Y4k2da7IIbwcZOzFgpMcTcXrvSJIsY=;
        b=K563/5QQ/lF5cXFFJk4vbdFJPZRSDRL92q4jADKh7WZBQmseJ+v22uQcIfCPZ2kHvm
         kzMQXq9XesUz/nnXRaypd23fYs2A3eax84g0OMVmazWhg8k6wCUxDWkPGK7jq5Oj8tC0
         qxHxuoY3Na9wAFrMxH1YgJMyPxokttK5t94Wz9o2mY9f2NDrWtjE8W5mlkcuXLII6Iqp
         WUVjccMMi6wcrhKoyDJ4eSugKbFYm2oQio7jBQSMtnbG3nSp4g3+rfVxMagjsq1udnZY
         Ho7hEM/ILEGeEenqe4FMiy1fQmgMxbW6+05oB/iwK+uU5bsCT1kYsQri15eEdMWa8Dd3
         Jt1A==
X-Gm-Message-State: AOAM530Spgt62kDj63vvHQRkVG4j3QuJtfmmGkwI4vVsoL4/Jo5qP1ke
        YpSdcNf0QGWYW6PI0+dhuxAoeBfCENpD5D623jH5iQ==
X-Google-Smtp-Source: ABdhPJy5zH9v2taHTbOivNt/jHFRx+P8htUtEtdRjWfaZYj8ZCyXiyfzifW75rVWQfROIBOwLzH5JMbjd+5Vk4a/t7c=
X-Received: by 2002:a05:6512:10d1:: with SMTP id k17mr1556851lfg.649.1614846584130;
 Thu, 04 Mar 2021 00:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
In-Reply-To: <20210304034141.7062-2-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:29:33 +0100
Message-ID: <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
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

Hi Brad,

thanks for your patch!

On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:

> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
(...)

> +#include <linux/gpio.h>

Use this in new drivers:
#include <linux/gpio/driver.h>

> + * pin:             3            2        |       1            0
> + * bit:         7------6------5------4----|---3------2------1------0
> + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> + *                ssi1            |             ssi0
> + */
> +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))

So 2 bits per GPIO line in one register? (Nice doc!)

> +struct elba_spics_priv {
> +       void __iomem *base;
> +       spinlock_t lock;
> +       struct gpio_chip chip;
> +};
> +
> +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> +{
> +       return -ENXIO;
> +}

Write a comment that the chip only supports output mode,
because it repurposes SPI CS pins as generic GPIO out,
maybe at the top of the file?

I suppose these systems also actually (ab)use the SPI cs
for things that are not really SPI CS? Because otherwise
this could just be part of the SPI driver (native chip select).

> +static const struct of_device_id ebla_spics_of_match[] = {
> +       { .compatible = "pensando,elba-spics" },

Have you documented this?

Other than that this is a nice and complete driver.

Yours,
Linus Walleij
