From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/36] ARM: exynos: stop selecting PLAT_SAMSUNG
Date: Wed, 23 Oct 2019 14:43:36 +0200
Message-ID: <CAK8P3a2k0nZCJu-DCC7unMM_rOU7edmBOnb7dTKw_mAsi5sUuA@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-8-arnd@arndb.de> <20191023105717.GF10630@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191023105717.GF10630@pi3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Olof Johansson <olof@lixom.net>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Sascha Hauer <s.hauer@pengutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 12:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:52PM +0200, Arnd Bergmann wrote:
> > @@ -1022,7 +1022,7 @@ choice
> >                 by the boot-loader before use.
> >
> >       config DEBUG_S3C_UART2
> > -             depends on PLAT_SAMSUNG
> > +             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> >               select DEBUG_EXYNOS_UART if ARCH_EXYNOS
> >               select DEBUG_S3C24XX_UART if ARCH_S3C24XX
> >               select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> > @@ -1034,7 +1034,7 @@ choice
> >                 by the boot-loader before use.
> >
> >       config DEBUG_S3C_UART3
> > -             depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
> > +             depends on ARCH_EXYNOS || ARCH_S5PV210
>
> You need to keep PLAT_SAMSUNG because of additional architectures, so
> follow pattern from DEBUG_S3C_UART2.

Are you sure? I think my version is correct: for UART2, the
"PLAT_SAMSUNG || ARCH_EXYNOS" is equivalent to "s3c24xx || s3c64xx ||
s5pv210 || exynos", which keeps the existing behavior unchanged.

For UART3, the "PLAT_SAMSUNG && ..." is redundant, this is already
limited to "s5pv210 || exynos", which my patch keeps. Changing it to
"PLAT_SAMSUNG || ..." would allow selecting the symbol on s3c24xx
and s3c64xx, which presumably is not valid.

      Arnd
