From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] mmc: Add hardware dependencies for sdhci-pxav3 and
 sdhci-pxav2
Date: Tue, 27 Jan 2015 15:34:04 +0100
Message-ID: <1422369244.4499.187.camel@chaos.site>
References: <20150126112328.318da5e7@endymion.delvare>
	 <CAPDyKFo363x7NGEctNwHkpn-6HkAu15qu-ZFtt73mJcWZrce4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo363x7NGEctNwHkpn-6HkAu15qu-ZFtt73mJcWZrce4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Le Tuesday 27 January 2015 =C3=A0 15:06 +0100, Ulf Hansson a =C3=A9crit=
 :
> On 26 January 2015 at 11:23, Jean Delvare <jdelvare@suse.de> wrote:
> > I seem to understand that the sdhci-pxav3 and sdhci-pxav2 drivers a=
re
> > only needed on the MMP architecture. So add a hardware dependency o=
n
> > ARCH_MMP, so that other users don't get to build useless drivers.
>=20
> I would rather see the default option to be N.
> Thus those configurations that needs this driver will have to select =
it.

This is a different question. The purpose of my patch is that people
configuring kernels for systems which just can't have these controllers=
,
are not asked about this driver at all. Changing the default to N would
not achieve that.

That being said, feel free to change the default to N if you want, but
to me (who knows nothing about MMP architecture and not much about MMC)
the current default values look sane.

Thanks,
Jean

> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Chris Ball <chris@printf.net>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> > ---
> > This patch was already sent on:
> >  * 2014-04-23
> >  * 2014-06-16
> >
> >  drivers/mmc/host/Kconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > --- linux-3.19-rc6.orig/drivers/mmc/host/Kconfig        2015-01-26 =
10:30:56.472182636 +0100
> > +++ linux-3.19-rc6/drivers/mmc/host/Kconfig     2015-01-26 11:13:33=
=2E669863314 +0100
> > @@ -228,6 +228,7 @@ config MMC_SDHCI_PXAV3
> >         tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
> >         depends on CLKDEV_LOOKUP
> >         depends on MMC_SDHCI_PLTFM
> > +       depends on ARCH_MMP || COMPILE_TEST
> >         default CPU_MMP2
> >         help
> >           This selects the Marvell(R) PXAV3 SD Host Controller.
> > @@ -240,6 +241,7 @@ config MMC_SDHCI_PXAV2
> >         tristate "Marvell PXA9XX SD Host Controller support (PXAV2)=
"
> >         depends on CLKDEV_LOOKUP
> >         depends on MMC_SDHCI_PLTFM
> > +       depends on ARCH_MMP || COMPILE_TEST
> >         default CPU_PXA910
> >         help
> >           This selects the Marvell(R) PXAV2 SD Host Controller.
> >
> >
> > --
> > Jean Delvare
> > SUSE L3 Support
