From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date: Sat, 19 Oct 2019 12:09:33 +0200
Message-ID: <CAK8P3a0t-P_w705z0BSXxzj8MmmKVCagLtidiP+NX51zGce0ag@mail.gmail.com>
References: <20191018154052.1276506-1-arnd@arndb.de> <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Oct 19, 2019 at 3:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/18/19 8:40 AM, Arnd Bergmann wrote:
>
> I don't get very far.
>
> $ make-arm pxa_defconfig
> arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
> scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed

>
> Did I pick the wrong tree ?

It seems that one line got lost in a rebase and ended up in a different patch
that was not part of the series. I updated the git tree now.

        Arnd
