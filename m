From: "Y.B. Lu" <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Mon, 10 Apr 2017 08:20:20 +0000
Message-ID: <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Andrian and Uffe,

Do you have any comments on MMC patches?
Could you help to merge the mmc patches if there is no changes requested?

Regarding to the dts patches, I have some more platforms to support.
So I'd like to drop them currently, and send them all to arm mailing list f=
or reviewing.

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Y.B. Lu
> Sent: Thursday, April 06, 2017 4:02 PM
> To: Y.B. Lu; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Adrian
> Hunter; Rob Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: Xiaobo Xie
> Subject: RE: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
>=20
> Hi all,
>=20
> Any comments? Thanks.
>=20
>=20
> Best regards,
> Yangbo Lu
>=20
> > -----Original Message-----
> > From: Yangbo Lu [mailto:yangbo.lu-3arQi8VN3Tc@public.gmane.org]
> > Sent: Monday, March 27, 2017 3:50 PM
> > To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> > kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Adrian Hunter; Rob
> > Herring; Mark Rutland; Catalin Marinas; Will Deacon
> > Cc: Xiaobo Xie; Y.B. Lu
> > Subject: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
> >
> > It's complicated to support SD UHS-I and eMMC HS200 for eSDHC because
> > there're many differences between eSDHC and SD/eMMC spec. Several
> > differences as below must be considered:
> > 1. Peripheral clock must be used instead of platform clock.
> >     - eSDHC could select peripheral clock or platform clock as its
> clock
> >       source. According to RM, UHS-I/HS200 must use peripheral clock
> > since
> >       it supports higher frequency than platform clock.
> >     - Patch 1 and patch 6 is to support this.
> > 2. Signal voltage switching requires a control circuit out of eSDHC.
> >     - eSDHC supports signal voltage switch from 3.3v to 1.8v by
> >       eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
> >       signal SDHC_VS, and there must be a control circuit out of eSDHC
> >       to change the signal voltage according to SDHC_VS output signal.
> >     - Patch 2 is to support this.
> > 3. eSDHC uses tuning block for tuning procedure.
> >     - Tuning clock control register must be configured before tuning.
> >     - Patch 3 is to support this.
> > 4. Delay is needed between tuning cycles for HS200 tuning.
> >     - Once a patch removed mdelay between tuning cycles.
> >       But eSDHC needs it.
> >     - Patch 4 and patch 5 is to support this.
> > 5. UHS-I/HS200 modes could be enabled in dts node.
> >     - Patch 7 is to support this.
> >
> > Please review and merge these patches on mmc git tree if no changes
> > are required.
> >
> > Adrian Hunter (1):
> >   mmc: sdhci: Control the delay between tuning commands
> >
> > Yangbo Lu (6):
> >   mmc: sdhci-of-esdhc: add peripheral clock support
> >   mmc: sdhci-of-esdhc: add support for signal voltage switch
> >   mmc: sdhci-of-esdhc: add tuning support
> >   mmc: sdhci-of-esdhc: add delay between tuning cycles
> >   arm64: dts: ls1046a: add clocks property and compatible for eSDHC
> node
> >   arm64: dts: ls1046ardb: add MMC HS200/UHS-1 modes support
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |   8 ++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    |   3 +-
> >  drivers/mmc/host/sdhci-esdhc.h                    |   7 +
> >  drivers/mmc/host/sdhci-of-esdhc.c                 | 165
> > +++++++++++++++++++++-
> >  drivers/mmc/host/sdhci.c                          |  11 +-
> >  drivers/mmc/host/sdhci.h                          |   2 +
> >  6 files changed, 190 insertions(+), 6 deletions(-)
> >
> > --
> > 2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
