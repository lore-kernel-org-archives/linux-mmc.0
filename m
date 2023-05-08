Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2FC77B7F
	for <linux-mmc@archiver.kernel.org>; Mon,  8 May 2023 15:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjEHPRg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 May 2023 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjEHPRd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2023 11:17:33 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6703AAA
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 08:17:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 71d38cae-edb3-11ed-b3cf-005056bd6ce9;
        Mon, 08 May 2023 18:17:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 8 May 2023 18:17:28 +0300
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs
Message-ID: <ZFkSiM9GRfN5n7n4@surfacebook>
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fri, May 05, 2023 at 01:16:57PM +0200, Linus Walleij kirjoitti:
> The platform devices on the Nokia 770 is using some
> board-specific IRQs that get statically assigned to platform
> devices in the boardfile.
> 
> This does not work with dynamic IRQ chip bases.
> 
> Utilize the NULL device to define some board-specific
> GPIO lookups and use these to immediately look up the
> same GPIOs, convert to IRQ numbers and pass as resources
> to the devices. This is ugly but should work.

...

> +static struct gpiod_lookup_table nokia770_irq_gpio_table = {
> +	.dev_id = NULL,
> +	.table = {
> +		/* GPIO used by SPI device 1 */
> +		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
> +			    GPIO_ACTIVE_HIGH),
> +		/* GPIO used for retu IRQ */
> +		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
> +			    GPIO_ACTIVE_HIGH),
> +		/* GPIO used for tahvo IRQ */
> +		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
> +			    GPIO_ACTIVE_HIGH),

Missing terminator.

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko


