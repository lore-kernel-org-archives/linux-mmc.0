From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date: Fri, 18 Oct 2019 18:02:57 -0700
Message-ID: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
References: <20191018154052.1276506-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 10/18/19 8:40 AM, Arnd Bergmann wrote:
> 
> Hi PXA maintainers,
> 
> I'm in the process of getting the old ARM platforms to all build
> in a single kernel. The largest part of that work is changing all
> the device drivers to no longer require mach/*.h header files.
> 
> This series does it for arch/pxa/.
> 
> As with the omap1 and s3c24xx series I sent before, I don't
> expect this all to be correct in the first version, though
> a lot of the patches are fairly simple and I did exhaustive
> compile-time testing on them.
> 
> Please test if you have the hardware, or review!
> 

I don't get very far.

$ make-arm pxa_defconfig
arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed
make[1]: *** [pxa_defconfig] Error 1
Makefile:567: recipe for target 'pxa_defconfig' failed
make: *** [pxa_defconfig] Error 2
$ git describe
v5.4-rc3-52-gfcc4181cd625

Also:

$ git grep plat-pxa
Documentation/arm/marvel.rst:   arch/arm/plat-pxa
Documentation/arm/marvel.rst:   arch/arm/plat-pxa
Documentation/arm/marvel.rst:   directory. The plat-pxa/ would therefore disappear.
arch/arm/Kconfig:source "arch/arm/plat-pxa/Kconfig"
arch/arm/mach-mmp/Makefile:ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-pxa/include
drivers/gpio/gpio-pxa.c: *  linux/arch/arm/plat-pxa/gpio.c
drivers/soc/pxa/mfp.c: * linux/arch/arm/plat-pxa/mfp.c

Did I pick the wrong tree ?

Guenter

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
