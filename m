From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date: Sat, 19 Oct 2019 12:08:35 +0200
Message-ID: <CAK8P3a3gOn6qkvvKaBzqYUzZToMKv3E587_8fQHmaF2u7erd5w@mail.gmail.com>
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
>
> On 10/18/19 8:40 AM, Arnd Bergmann wrote:
> >
> > Hi PXA maintainers,
> >
> > I'm in the process of getting the old ARM platforms to all build
> > in a single kernel. The largest part of that work is changing all
> > the device drivers to no longer require mach/*.h header files.
> >
> > This series does it for arch/pxa/.
> >
> > As with the omap1 and s3c24xx series I sent before, I don't
> > expect this all to be correct in the first version, though
> > a lot of the patches are fairly simple and I did exhaustive
> > compile-time testing on them.
> >
> > Please test if you have the hardware, or review!
> >
>
> I don't get very far.
>
> $ make-arm pxa_defconfig
> arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
> scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed
> make[1]: *** [pxa_defconfig] Error 1
> Makefile:567: recipe for target 'pxa_defconfig' failed
> make: *** [pxa_defconfig] Error 2
> $ git describe
> v5.4-rc3-52-gfcc4181cd625
>
> Also:
>
> $ git grep plat-pxa
> Documentation/arm/marvel.rst:   arch/arm/plat-pxa
> Documentation/arm/marvel.rst:   arch/arm/plat-pxa
> Documentation/arm/marvel.rst:   directory. The plat-pxa/ would therefore disappear.
> arch/arm/Kconfig:source "arch/arm/plat-pxa/Kconfig"
> arch/arm/mach-mmp/Makefile:ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-pxa/include
> drivers/gpio/gpio-pxa.c: *  linux/arch/arm/plat-pxa/gpio.c
> drivers/soc/pxa/mfp.c: * linux/arch/arm/plat-pxa/mfp.c
>
> Did I pick the wrong tree ?
>
> Guenter
