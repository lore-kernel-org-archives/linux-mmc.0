From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/28] drivers/mmc/core/slot-gpio.c:311:57:
 error: 'GPIOD_IN' undeclared
Date: Mon, 18 Aug 2014 16:57:09 +0200
Message-ID: <CAPDyKFoAnZNSQVA_FSR9=fpDhrXpakZpxAaAjxC0UqjQm6NhZg@mail.gmail.com>
References: <53f20237.LSFm2PWR7C/z6hrc%fengguang.wu@intel.com>
	<CACRpkdZNmNpTzJQ5Bh=ZvYN_pTNwfnz9JwC7btPiDrSGPQWGew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:64835 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaHRO5P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 10:57:15 -0400
Received: by mail-qg0-f41.google.com with SMTP id z107so1183953qgd.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 07:57:10 -0700 (PDT)
In-Reply-To: <CACRpkdZNmNpTzJQ5Bh=ZvYN_pTNwfnz9JwC7btPiDrSGPQWGew@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On 18 August 2014 16:21, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 18, 2014 at 8:40 AM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>
>>    drivers/mmc/core/slot-gpio.c: In function 'mmc_gpiod_request_cd':
>>>> drivers/mmc/core/slot-gpio.c:311:57: error: 'GPIOD_IN' undeclared (first use in this function)
>>      desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>>                                                             ^
>
> This is because we now require GPIOLIB.
>
> I have two ways to solve this:
>
> - Make CONFIG_MMC select CONFIG_GPIOLIB
>
> - Make slot-gpio optional by introducing stubs in <linux/mmc/slot-gpio.h> if
>   CONFIG_GPIOLIB is not set and not compile slot-gpio.c if GPIOLIB
>   is not selected.
>
> Which one would the MMC maintainers prefer?
>
> I don't think we have a system using some legacy GPIO API without
> GPIOLIB so we should enforce this somehow.

Let's try "CONFIG_MMC select CONFIG_GPIOLIB".

If you are fine with it, I can fold in such a change into the commit,
no need to send a v2.

Kind regards
Uffe
