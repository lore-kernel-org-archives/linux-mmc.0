From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/28] drivers/mmc/core/slot-gpio.c:311:57:
 error: 'GPIOD_IN' undeclared
Date: Mon, 18 Aug 2014 09:21:43 -0500
Message-ID: <CACRpkdZNmNpTzJQ5Bh=ZvYN_pTNwfnz9JwC7btPiDrSGPQWGew@mail.gmail.com>
References: <53f20237.LSFm2PWR7C/z6hrc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:55803 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaHROVo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 10:21:44 -0400
Received: by mail-oi0-f49.google.com with SMTP id u20so3563339oif.36
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 07:21:43 -0700 (PDT)
In-Reply-To: <53f20237.LSFm2PWR7C/z6hrc%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On Mon, Aug 18, 2014 at 8:40 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:

>    drivers/mmc/core/slot-gpio.c: In function 'mmc_gpiod_request_cd':
>>> drivers/mmc/core/slot-gpio.c:311:57: error: 'GPIOD_IN' undeclared (first use in this function)
>      desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>                                                             ^

This is because we now require GPIOLIB.

I have two ways to solve this:

- Make CONFIG_MMC select CONFIG_GPIOLIB

- Make slot-gpio optional by introducing stubs in <linux/mmc/slot-gpio.h> if
  CONFIG_GPIOLIB is not set and not compile slot-gpio.c if GPIOLIB
  is not selected.

Which one would the MMC maintainers prefer?

I don't think we have a system using some legacy GPIO API without
GPIOLIB so we should enforce this somehow.

Yours,
Linus Walleij
