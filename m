From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Tue, 22 Oct 2019 16:01:12 +0200
Message-ID: <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 11, 2019 at 7:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > These can be build completely independently, so split
> > the two Kconfig symbols.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'd mention the two symbols' names you're working on in the commit log.
> I guess it's about PLAT_SAMSUNG and ARCH_S5PV210. And I wouldn't call it
> "split" which IMHO suggests there was only one symbol before.
>
> Maybe:
>
>         Don't imply PLAT_SAMSUNG if ARCH_S5PV210 is enabled
>
> would be a better subject line?

Ok, changed to

ARM: s5pv210: don't imply CONFIG_PLAT_SAMSUNG

> > @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)              += spear
> >  # by CONFIG_* macro name.
> >  plat-$(CONFIG_ARCH_OMAP)     += omap
> >  plat-$(CONFIG_ARCH_S3C64XX)  += samsung
> > -plat-$(CONFIG_ARCH_S5PV210)  += samsung
>
> Would it make more sense to make this
>
>         plat-$(PLAT_SAMSUNG) += samsung
>
> (in a separate patch)? Hmm, it seems there is no plat-y for
> PLAT_S3C24XX=y builds. Is this intended? If yes, the directory name
> containing "samsung" suggests something that seems untrue.

By the end of the series, the plat-samsung directory is completely
removed (folded into mach-s3c), so that would only add more
churn for the same result I think.

     Arnd
