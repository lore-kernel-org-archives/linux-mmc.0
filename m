From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: fix warning of 'struct gpio_chip' declaration
Date: Thu, 17 Jan 2013 14:30:01 +0100
Message-ID: <CACRpkdaKhLcS9p9JOhViCkUcMVH1ByBR3v5A4+wOJnQUcuQrVg@mail.gmail.com>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
	<1358239056-703-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37536 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab3AQNaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 08:30:03 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so4660982ieb.17
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jan 2013 05:30:01 -0800 (PST)
In-Reply-To: <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 15, 2013 at 9:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote=
:

> The struct gpio_chip is only defined inside #ifdef CONFIG_GPIOLIB,
> but it's referenced by gpiochip_add_pin_range() and
> gpiochip_remove_pin_ranges() which are outside #ifdef CONFIG_GPIOLIB.
> Thus, we see the following warning when building blackfin image, wher=
e
> GPIOLIB is not required.
>
>   CC      arch/blackfin/kernel/bfin_gpio.o
>   CC      init/version.o
> In file included from arch/blackfin/include/asm/gpio.h:321,
>                  from arch/blackfin/kernel/bfin_gpio.c:15:
> include/asm-generic/gpio.h:298: warning: =91struct gpio_chip=92 decla=
red inside parameter list
> include/asm-generic/gpio.h:298: warning: its scope is only this defin=
ition or declaration, which is probably not what you want
> include/asm-generic/gpio.h:304: warning: =91struct gpio_chip=92 decla=
red inside parameter list
>
> Move pinctrl trunk into #ifdef CONFIG_GPIOLIB to fix the warning,
> since it appears that pinctrl gpio range support depends on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Shawn can you please try to repost this with something that does not
turn into quoted-printable? Look:

MIME-Version: 1.0
Content-Type: text/plain; charset=3D"UTF-8"
Content-Transfer-Encoding: quoted-printable
(...)
@@ -212,6 +212,43 @@ extern void gpio_unexport(unsigned gpio);
=3D20
 #endif	/* CONFIG_GPIO_SYSFS */
=3D20
+#ifdef CONFIG_PINCTRL

I can't apply that.

Second: if this is not an immediate regression I'd prefer to put it
for-next now, as touching this file always brings down something.

OK?

Yours,
Linus Walleij
