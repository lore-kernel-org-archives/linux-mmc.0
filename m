From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Sun, 24 Oct 2010 06:02:07 +0200
Message-ID: <201010240602.07704.marek.vasut@gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <201010231950.31707.marek.vasut@gmail.com> <AANLkTinp-0sgNO8q-4jrCyKY-R1qq7Y2Eu75NqChnKq2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51113 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0JXECN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Oct 2010 00:02:13 -0400
Received: by bwz11 with SMTP id 11so1543962bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 23 Oct 2010 21:02:12 -0700 (PDT)
In-Reply-To: <AANLkTinp-0sgNO8q-4jrCyKY-R1qq7Y2Eu75NqChnKq2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, "eric.y.miao" <eric.y.miao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

Dne Ne 24. =F8=EDjna 2010 05:26:38 zhangfei gao napsal(a):
> On Sun, Oct 24, 2010 at 1:50 AM, Marek Vasut <marek.vasut@gmail.com> =
wrote:
> > Dne So 23. =F8=EDjna 2010 18:47:10 zhangfei gao napsal(a):
> >> On Sat, Oct 23, 2010 at 10:24 PM, Marek Vasut <marek.vasut@gmail.c=
om>=20
wrote:
> >> >> +/*************************************************************=
******
> >> >> *** *** ****\ + *
> >> >>         * + * Device probing/removal
> >> >>              * + *
> >> >>                   *
> >> >> +\*************************************************************=
******
> >> >> *** ** *****/ +
> >> >> +static int __devinit sdhci_pxa_probe(struct platform_device *p=
dev)
> >> >> +{
> >> >> +     struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_d=
ata;
> >> >> +     struct device *dev =3D &pdev->dev;
> >> >> +     struct sdhci_host *host =3D NULL;
> >> >> +     struct resource *iomem =3D NULL;
> >> >> +     struct sdhci_pxa *pxa =3D NULL;
> >> >> +     int ret, irq;
> >> >> +
> >> >> +     irq =3D platform_get_irq(pdev, 0);
> >> >> +     if (irq < 0) {
> >> >> +             dev_err(dev, "no irq specified\n");
> >> >> +             return irq;
> >> >> +     }
> >> >> +
> >> >> +     iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> >> +     if (!iomem) {
> >> >> +             dev_err(dev, "no memory specified\n");
> >> >> +             return -ENOENT;
> >> >> +     }
> >> >> +
> >> >> +     host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci=
_pxa));
> >> >> +     if (IS_ERR(host)) {
> >> >> +             dev_err(dev, "failed to alloc host\n");
> >> >> +             return PTR_ERR(host);
> >> >> +     }
> >> >> +
> >> >> +     pxa =3D sdhci_priv(host);
> >> >> +     pxa->host =3D host;
> >> >> +     pxa->pdata =3D pdata;
> >> >> +     pxa->clk_enable =3D 0;
> >> >> +
> >> >> +     pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
> >> >> +     if (IS_ERR(pxa->clk)) {
> >> >> +             dev_err(dev, "failed to get io clock\n");
> >> >> +             ret =3D PTR_ERR(pxa->clk);
> >> >> +             goto out;
> >> >> +     }
> >> >> +
> >> >> +     pxa->res =3D request_mem_region(iomem->start,
> >> >> resource_size(iomem), +             mmc_hostname(host->mmc));
> >> >> +     if (!pxa->res) {
> >> >> +             dev_err(&pdev->dev, "cannot request region\n");
> >> >> +             ret =3D -EBUSY;
> >> >> +             goto out;
> >> >> +     }
> >> >> +
> >> >> +     host->ioaddr =3D ioremap(iomem->start, resource_size(iome=
m));
> >> >> +     if (!host->ioaddr) {
> >> >> +             dev_err(&pdev->dev, "failed to remap registers\n"=
);
> >> >> +             ret =3D -ENOMEM;
> >> >> +             goto out;
> >> >> +     }
> >> >> +
> >> >> +     host->hw_name =3D "MMC";
> >> >> +     host->ops =3D &sdhci_pxa_ops;
> >> >> +     host->irq =3D irq;
> >> >> +     host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA |
> >> >> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL; +
> >> >=20
> >> > Maybe check if these aren't already set in pdata and warn user ?
> >>=20
> >> Here pdata->quirks only provide specific quirk like
> >> SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device, the common q=
uirk
> >> is provided above.
> >=20
> > Right, but what if the user also provides such a quirk? It's unnece=
ssary
> > ... and in case the quirk was removed from here later, it'd have to=
 be
> > removed from user's code too ...
>=20
> What do you mean 'in case the quirk was removed from here later'.

I mean ... if setting the quirk was removed from the driver source, it'=
d have to=20
be removed from user code that uses the driver as well -- in case user =
also set=20
such a quirk in pdata->quirks. So it might be a good idea to warn user =
that he's=20
setting something that's getting set elsewhere (in the driver) anyway.

> SDHCI_QUIRK_* is just move from drivers/mmc/host/sdhci.h to
> include/linux/mmc/sdhci.h, so code in arch/arm could access them
> directly.
>=20
> We also consider use one flag here, like sdhci-s3c.c.
> Code like this,
> if (pdata->flags & PXA_FLAG_CARD_PERMENT)
>      host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>=20
> If SDHCI_QUIRK_* not permitted to access, it would be better to use t=
his
> method.
>=20
> >> In sdhci-s3c, host->quirks is modified here via pdata->cd_type, wh=
ich
> >> is also a good method.
> >> Here we transfer SDHCI_QUIRK_BROKEN_CARD_DETECTION directly from p=
data
> >> since it already move to include folder.
> >>=20
> >> >> +     if (pdata->quirks)
> >> >> +             host->quirks |=3D pdata->quirks;
> >> >> +
> >> >> +     ret =3D sdhci_add_host(host);
> >> >> +     if (ret) {
> >> >> +             dev_err(&pdev->dev, "failed to add host\n");
> >> >> +             goto out;
> >> >> +     }
> >> >> +
> >> >> +     if (pxa->pdata->max_speed)
> >> >> +             host->mmc->f_max =3D pxa->pdata->max_speed;
> >> >=20
> >> > What happens otherwise ?
> >>=20
> >> Otherwise, host->mmc->f_max =3D host->max_clk set in sdhci_add_hos=
t,
> >> host->max_clk is 50M in 2.0 controller, and 200M in 3.0 controller=
, if
> >> controller does not need to provide get_max_clock.
> >> it's better add defalut value in else condition.
> >=20
> > Thanks for clearing this
> >=20
> >> Thanks Marek for review.
> >>=20
> >> >> +
> >> >> +     platform_set_drvdata(pdev, host);
> >> >> +
> >> >> +     return 0;
> >> >> +out:
> >> >> +     if (host) {
> >> >> +             clk_put(pxa->clk);
> >> >> +             if (host->ioaddr)
> >> >> +                     iounmap(host->ioaddr);
> >> >> +             if (pxa->res)
> >> >> +                     release_mem_region(pxa->res->start,
> >> >> +                                     resource_size(pxa->res));
> >> >> +             sdhci_free_host(host);
> >> >> +     }
> >> >> +
> >> >> +     return ret;
> >> >> +}
> >> >> +
> >> >=20
> >> > Thanks!
> >> >=20
> >> > Cheers
