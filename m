From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/29] drivers/input/touchscreen/cyttsp4_core.c:1218:1:
 warning: 'cyttsp4_irq' uses dynamic stack allocation
Date: Wed, 20 Aug 2014 10:17:23 +0200
Message-ID: <CAPDyKFpLHZuxTRnF81+aHQS-=giK3vbsdfD8NGoktwiw-L-eFA@mail.gmail.com>
References: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
	<CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
	<CAPDyKFrqQuTrrg2im=hMtSjRrJb0Lq4M1u7C6C-13cZLXdwZ1w@mail.gmail.com>
	<CACRpkda1=2EZLe-eOw2n-sPWEDi_S31rjRxKFWxu47NeatZRpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:39456 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaHTIRY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Aug 2014 04:17:24 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so7468408qcx.35
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2014 01:17:24 -0700 (PDT)
In-Reply-To: <CACRpkda1=2EZLe-eOw2n-sPWEDi_S31rjRxKFWxu47NeatZRpQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On 19 August 2014 19:06, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Aug 19, 2014 at 2:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 18 August 2014 19:13, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> Or maybe even do the second approach of putting stubs in slot-gpio.h
>>> for !GPIOLIB...
>>
>> Hmm, that doesn't sound the proper solution either.
>>
>> Currently there are already stubs for the "gpiod" API in
>> gpio/consumer.h. I think the original error was that the "GPIOD_IN"
>> flag couldn't be found for !GPIOLIB.
>> So, how about actually move these flags and it's corresponding defines
>> to be available for !GPIOLIB as well. That should solve this problem
>> for other subsytems using gpiod API as well, right?
>
> Yeah you're right, I've sent such a patch now, I will queue this for
> fixes so we can rely on it in the development trees.

Great! Please keep me on cc on the PR to easier follow the progress.

>
> But I still think it's kind of awkward that slot-gpio is compiled into
> the MMC core even if GPIOLIB is not available on the machine :-/
> it simply doesn't make much sense, since it never will add anything.

Actually there a bit of mix for how such situations are handled in the
mmc subsystem. For example, we have stubs for the mmc regulator
functions (mmc_regulator_get_ocrmask() and mmc_regulator_set_ocr()),
but we don't for DT parsing (mmc_of_parse()) and for slot-gpio.

Implementation wise, I would prefer to not have stubs unless it's
explicitly needed. Still one may argue that a built kernel binary
should have the smallest possible footprint, which means stubs should
be added.

Do you know if there are common understanding among maintainers of how
this should be done?

Kind regards
Uffe

> But this path should get us to the situation where everything
> just compiles nicely atleast. I will try it on zeroday builds.
>
> Yours,
> Linus Walleij
