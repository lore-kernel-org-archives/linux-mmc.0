From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/6] mmc: slot-gpio: Record GPIO descriptors instead of
 GPIO numbers
Date: Fri, 14 Mar 2014 10:06:12 +0100
Message-ID: <CACRpkdaHRsASr1jxPcUb+8G25BpOO0kB9mXFi_gocJ9cWmYDDw@mail.gmail.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
	<1394456564-13783-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:40172 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbaCNJGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 05:06:13 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so2320617oag.32
        for <linux-mmc@vger.kernel.org>; Fri, 14 Mar 2014 02:06:12 -0700 (PDT)
In-Reply-To: <1394456564-13783-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, Mar 10, 2014 at 2:02 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> In preparation for adding a descriptor-based CD GPIO
> API, switch from recording GPIO numbers to recording
> GPIO descriptors.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Certainly this makes things look better from a GPIO POV
so Acked-by.

However:

(...)
> +       ctx->ro_gpio = gpio_to_desc(gpio);
(...)
> +       ctx->cd_gpio = gpio_to_desc(gpio);

How much harder would it be to switch the platforms using this
MMC driver to pass GPIO descriptors using the gpiod_lookup_table
in affected platforms (or device tree or ACPI) and then use
devm_gpiod_get[_index]() in probe()?

This can certainly be step 2, but that is where we want to go with
the GPIO clean-up work in the long run.

Yours,
Linus Walleij
