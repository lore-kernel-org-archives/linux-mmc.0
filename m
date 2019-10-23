From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Wed, 23 Oct 2019 15:17:35 +0200
Message-ID: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191023121458.GB11048@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023121458.GB11048@pi3>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?B?Q2zDqW1lbnQgUMOp
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 2:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > These can be build completely independently, so split
> > the two Kconfig symbols.
> >       config DEBUG_S3C_UART0
> > -             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> > +             depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>
> How are you going to select DEBUG_S5PV210_UART now?

I don't see a problem here, the patch should not change the behavior at all.

The whole entry now looks like:

        config DEBUG_S3C_UART0
                depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
                select DEBUG_EXYNOS_UART if ARCH_EXYNOS
                select DEBUG_S3C24XX_UART if ARCH_S3C24XX
                select DEBUG_S3C64XX_UART if ARCH_S3C64XX
                select DEBUG_S5PV210_UART if ARCH_S5PV210
                bool "Use Samsung S3C UART 0 for low-level debug"

so this will work as before with any of ARCH_EXYNOS, ARCH_S3C24XX,
ARCH_S3C64XX and ARCH_S5PV210.

What am I missing?

     Arnd
