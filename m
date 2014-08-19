From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/29] drivers/input/touchscreen/cyttsp4_core.c:1218:1:
 warning: 'cyttsp4_irq' uses dynamic stack allocation
Date: Tue, 19 Aug 2014 09:19:53 +0200
Message-ID: <CAPDyKFrqQuTrrg2im=hMtSjRrJb0Lq4M1u7C6C-13cZLXdwZ1w@mail.gmail.com>
References: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
	<CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:56921 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaHSHTy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 03:19:54 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so5629316qga.36
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2014 00:19:54 -0700 (PDT)
In-Reply-To: <CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On 18 August 2014 19:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 18, 2014 at 11:39 AM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>
>> tree:   git://git.linaro.org/people/ulf.hansson/mmc next
>> head:   612b2c14449ba90b633f51fcfba83dd66614697a
>> commit: f907645be3f76558c3eb89bdd72e3451a762059c [17/29] mmc: select GPIOLIB for MMC support
>> config: make ARCH=s390 allmodconfig
>>
>> All warnings:
>>
>> warning: (ARCH_REQUIRE_GPIOLIB && MMC && PINCTRL_AT91 && PINCTRL_NOMADIK && MFD_TC6393XB && FB_VIA) selects GPIOLIB which has unmet direct dependencies (ARCH_WANT_OPTIONAL_GPIOLIB || ARCH_REQUIRE_GPIOLIB)
>>    drivers/input/touchscreen/cyttsp4_core.c: In function 'cyttsp4_irq':
>>>> drivers/input/touchscreen/cyttsp4_core.c:1218:1: warning: 'cyttsp4_irq' uses dynamic stack allocation
>
> This error comes from selecting something that is optional.
>
> Grrr should I use "depends on GPIOLIB" for MMC instead?

Not sure that will be any better.

>
> Or maybe even do the second approach of putting stubs in slot-gpio.h
> for !GPIOLIB...

Hmm, that doesn't sound the proper solution either.

Currently there are already stubs for the "gpiod" API in
gpio/consumer.h. I think the original error was that the "GPIOD_IN"
flag couldn't be found for !GPIOLIB.
So, how about actually move these flags and it's corresponding defines
to be available for !GPIOLIB as well. That should solve this problem
for other subsytems using gpiod API as well, right?

Kind regards
Uffe
