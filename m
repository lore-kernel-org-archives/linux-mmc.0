From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 17/29] drivers/input/touchscreen/cyttsp4_core.c:1218:1:
 warning: 'cyttsp4_irq' uses dynamic stack allocation
Date: Mon, 18 Aug 2014 12:13:21 -0500
Message-ID: <CACRpkdbJ=qLr5-jiJrtOKA-qaV1XrXs0uYQ+9NdgO42vAo0GMA@mail.gmail.com>
References: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38440 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaHRRNW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 13:13:22 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so2263138obc.9
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 10:13:21 -0700 (PDT)
In-Reply-To: <53f22c36.qbCHWEfTMJdv7qIU%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <fengguang.wu@intel.com>

On Mon, Aug 18, 2014 at 11:39 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:

> tree:   git://git.linaro.org/people/ulf.hansson/mmc next
> head:   612b2c14449ba90b633f51fcfba83dd66614697a
> commit: f907645be3f76558c3eb89bdd72e3451a762059c [17/29] mmc: select GPIOLIB for MMC support
> config: make ARCH=s390 allmodconfig
>
> All warnings:
>
> warning: (ARCH_REQUIRE_GPIOLIB && MMC && PINCTRL_AT91 && PINCTRL_NOMADIK && MFD_TC6393XB && FB_VIA) selects GPIOLIB which has unmet direct dependencies (ARCH_WANT_OPTIONAL_GPIOLIB || ARCH_REQUIRE_GPIOLIB)
>    drivers/input/touchscreen/cyttsp4_core.c: In function 'cyttsp4_irq':
>>> drivers/input/touchscreen/cyttsp4_core.c:1218:1: warning: 'cyttsp4_irq' uses dynamic stack allocation

This error comes from selecting something that is optional.

Grrr should I use "depends on GPIOLIB" for MMC instead?

Or maybe even do the second approach of putting stubs in slot-gpio.h
for !GPIOLIB...

Yours,
Linus Walleij
