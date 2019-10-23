From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Wed, 23 Oct 2019 16:12:21 +0200
Message-ID: <20191023141221.GA11575@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
 <20191023121458.GB11048@pi3>
 <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Kukjin Kim <kgene@kernel.org>, =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, linux-serial@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux PWM List <linux-pwm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Linux ARM <linux-arm>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 03:17:35PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 23, 2019 at 2:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > > These can be build completely independently, so split
> > > the two Kconfig symbols.
> > >       config DEBUG_S3C_UART0
> > > -             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> > > +             depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
> >
> > How are you going to select DEBUG_S5PV210_UART now?
> 
> I don't see a problem here, the patch should not change the behavior at all.
> 
> The whole entry now looks like:
> 
>         config DEBUG_S3C_UART0
>                 depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>                 select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>                 select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>                 select DEBUG_S3C64XX_UART if ARCH_S3C64XX
>                 select DEBUG_S5PV210_UART if ARCH_S5PV210
>                 bool "Use Samsung S3C UART 0 for low-level debug"
> 
> so this will work as before with any of ARCH_EXYNOS, ARCH_S3C24XX,
> ARCH_S3C64XX and ARCH_S5PV210.
> 
> What am I missing?

Ah, everything is OK, I mixed up removed with added line so it looked
reversed (removal of ARCH_S5PV210).

Looks good.

Best regards,
Krzysztof
