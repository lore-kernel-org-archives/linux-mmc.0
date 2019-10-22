From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Tue, 22 Oct 2019 17:53:07 +0200
Message-ID: <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
 <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
 <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>Linux ARM <linu>
List-Id: linux-mmc@vger.kernel.org

Hello,

On Tue, Oct 22, 2019 at 04:01:12PM +0200, Arnd Bergmann wrote:
> > > @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)              +=3D sp=
ear
> > >  # by CONFIG_* macro name.
> > >  plat-$(CONFIG_ARCH_OMAP)     +=3D omap
> > >  plat-$(CONFIG_ARCH_S3C64XX)  +=3D samsung
> > > -plat-$(CONFIG_ARCH_S5PV210)  +=3D samsung
> >
> > Would it make more sense to make this
> >
> >         plat-$(PLAT_SAMSUNG) +=3D samsung
> >
> > (in a separate patch)? Hmm, it seems there is no plat-y for
> > PLAT_S3C24XX=3Dy builds. Is this intended? If yes, the directory name
> > containing "samsung" suggests something that seems untrue.
> =

> By the end of the series, the plat-samsung directory is completely
> removed (folded into mach-s3c), so that would only add more
> churn for the same result I think.

fine for me. The background of my question was me wondering if builds
for PLAT_S3C24XX=3Dy (before your patch series) don't need plat-samsung.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
