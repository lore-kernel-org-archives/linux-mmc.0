From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: core: Add DT bindings for card detect debounce time
Date: Wed, 9 Jul 2014 21:28:15 +0900
Message-ID: <CAAVeFu+v=4d8juT8G0J8V8GUkUzOw3wn4QrDgzYj9Hv_Y3Ub4g@mail.gmail.com>
References: <1399649837-27286-1-git-send-email-balajitk@ti.com>
 <CAPDyKFoZ=zjKg5bUMnK_X2XOatT=XSAnBDpYqu0Q2VOkM7hOOA@mail.gmail.com>
 <CAAVeFu+CW0DSbqc6k145APao2r907sAyMw0+W=hQXxO6LoQx-g@mail.gmail.com> <CACRpkda7s_AgPx4a6qu2=FGhfoPyJiZBCJDbd9iWL5qE3DPtXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:60172 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbaGIM2g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 08:28:36 -0400
In-Reply-To: <CACRpkda7s_AgPx4a6qu2=FGhfoPyJiZBCJDbd9iWL5qE3DPtXQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Balaji T K <balajitk@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Jul 8, 2014 at 12:12 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Jun 21, 2014 at 9:22 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>
>>> I have added Linus Walleij and Alexandre Courbot, the maintainers of
>>> gpio. Let's see if they can point us in a direction.
>>
>> I agree it would be nice if the debounce value could be handled by the
>> GPIO framework.
>
> I agree too.
>
>> I just wonder what would be the correct way of doing
>> it? Contrary to ACTIVE_LOW and other flags which can be specified with
>> the GPIO phandle, debounce is a numeric value. Maybe using a different
>> property, e.g.:
>>
>> cd-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
>> cd-gpios-debounce = <10>;
>>
>> When looking up a GPIO through gpiod_get(), the GPIO framework could
>> then check for -debounce property and set the debounce time
>> accordingly. At first sight I'd say that would work and could be used
>> for MMC and all other subsystems that need something similar.
>
> Yes, but we also need to write generic debounce handling into
> the gpiolib, so it doesn't matter if the GPIO driver can or cannot
> handle this itself. Some hardware has the capability to debounce
> lines in *hardware*.
>
> Right now a call to gpiod_set_debounce() will fail unless the
> hardware has a debounce option.
>
> What we should really do is make gpiod_set_debounce() always
> work, put the debounce value into the gpio_desc, and move some
> logic similar to what exists in drivers/input/keyboard/gpio_keys.c
> into the gpiolib, then get rid of any local implementations like
> in gpio_keys.
>
> Then we can rely on the gpiolib handling this at all times, and also
> to get the debounce config from DT.
>
> Dmitry, opinions on this?
>
> Anyone up for implementing the timer in gpiolib and moving the
> keyboard driver over to using the gpiolib debounce set?

If this can wait a bit for the Grand GPIO Refactoring and concurrent
GPIO consumers to be done, I don't mind giving this a shot next. If
someone else wants/needs it faster, please feel free to take over of
course.
