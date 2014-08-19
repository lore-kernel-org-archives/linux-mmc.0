From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/29] drivers/input/touchscreen/cyttsp4_core.c:1218:1:
 warning: 'cyttsp4_irq' uses dynamic stack allocation
Date: Tue, 19 Aug 2014 12:06:33 -0500
Message-ID: <CACRpkda1=2EZLe-eOw2n-sPWEDi_S31rjRxKFWxu47NeatZRpQ@mail.gmail.com>
References: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
	<CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
	<CAPDyKFrqQuTrrg2im=hMtSjRrJb0Lq4M1u7C6C-13cZLXdwZ1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41159 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbaHSRGe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 13:06:34 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so3353093obc.37
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2014 10:06:33 -0700 (PDT)
In-Reply-To: <CAPDyKFrqQuTrrg2im=hMtSjRrJb0Lq4M1u7C6C-13cZLXdwZ1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On Tue, Aug 19, 2014 at 2:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 August 2014 19:13, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Or maybe even do the second approach of putting stubs in slot-gpio.h
>> for !GPIOLIB...
>
> Hmm, that doesn't sound the proper solution either.
>
> Currently there are already stubs for the "gpiod" API in
> gpio/consumer.h. I think the original error was that the "GPIOD_IN"
> flag couldn't be found for !GPIOLIB.
> So, how about actually move these flags and it's corresponding defines
> to be available for !GPIOLIB as well. That should solve this problem
> for other subsytems using gpiod API as well, right?

Yeah you're right, I've sent such a patch now, I will queue this for
fixes so we can rely on it in the development trees.

But I still think it's kind of awkward that slot-gpio is compiled into
the MMC core even if GPIOLIB is not available on the machine :-/
it simply doesn't make much sense, since it never will add anything.
But this path should get us to the situation where everything
just compiles nicely atleast. I will try it on zeroday builds.

Yours,
Linus Walleij
