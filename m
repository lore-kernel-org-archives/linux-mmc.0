From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 RESEND] gpio: fix warning of 'struct gpio_chip' declaration
Date: Thu, 17 Jan 2013 15:10:15 +0100
Message-ID: <CACRpkdbwokgBh55nFcDMc50CYmyuGd6AQF88Md=Le-UxJ=p6rg@mail.gmail.com>
References: <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
	<1358431402-29701-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:62519 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3AQOKP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 09:10:15 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so439028iaa.36
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jan 2013 06:10:15 -0800 (PST)
In-Reply-To: <1358431402-29701-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 17, 2013 at 3:03 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The struct gpio_chip is only defined inside #ifdef CONFIG_GPIOLIB,
> but it's referenced by gpiochip_add_pin_range() and
> gpiochip_remove_pin_ranges() which are outside #ifdef CONFIG_GPIOLIB.
> Thus, we see the following warning when building blackfin image, where
> GPIOLIB is not required.
>
>   CC      arch/blackfin/kernel/bfin_gpio.o
>   CC      init/version.o
> In file included from arch/blackfin/include/asm/gpio.h:321,
>                  from arch/blackfin/kernel/bfin_gpio.c:15:
> include/asm-generic/gpio.h:298: warning: 'struct gpio_chip' declared inside parameter list
> include/asm-generic/gpio.h:298: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm-generic/gpio.h:304: warning: 'struct gpio_chip' declared inside parameter list
>
> Move pinctrl trunk into #ifdef CONFIG_GPIOLIB to fix the warning,
> since it appears that pinctrl gpio range support depends on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, patch applied to devel (for-next)

Let's see if something explodes!

Yours,
Linus Walleij
