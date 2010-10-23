From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Sat, 23 Oct 2010 19:50:31 +0200
Message-ID: <201010231950.31707.marek.vasut@gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <201010231624.03293.marek.vasut@gmail.com> <AANLkTi=RNDf-A98LN3AH=JdegHXKRjHvtGCDYtkJ5ADg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46965 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0JWRug convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Oct 2010 13:50:36 -0400
Received: by bwz11 with SMTP id 11so1367340bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 23 Oct 2010 10:50:35 -0700 (PDT)
In-Reply-To: <AANLkTi=RNDf-A98LN3AH=JdegHXKRjHvtGCDYtkJ5ADg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, "eric.y.miao" <eric.y.miao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

Dne So 23. =C5=99=C3=ADjna 2010 18:47:10 zhangfei gao napsal(a):
> On Sat, Oct 23, 2010 at 10:24 PM, Marek Vasut <marek.vasut@gmail.com>=
 wrote:
> >> +/****************************************************************=
******
> >> *** ****\ + *
> >>         * + * Device probing/removal
> >>              * + *
> >>                   *
> >> +\****************************************************************=
******
> >> ** *****/ +
> >> +static int __devinit sdhci_pxa_probe(struct platform_device *pdev=
)
> >> +{
> >> +     struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data=
;
> >> +     struct device *dev =3D &pdev->dev;
> >> +     struct sdhci_host *host =3D NULL;
> >> +     struct resource *iomem =3D NULL;
> >> +     struct sdhci_pxa *pxa =3D NULL;
> >> +     int ret, irq;
> >> +
> >> +     irq =3D platform_get_irq(pdev, 0);
> >> +     if (irq < 0) {
> >> +             dev_err(dev, "no irq specified\n");
> >> +             return irq;
> >> +     }
> >> +
> >> +     iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +     if (!iomem) {
> >> +             dev_err(dev, "no memory specified\n");
> >> +             return -ENOENT;
> >> +     }
> >> +
> >> +     host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_px=
a));
> >> +     if (IS_ERR(host)) {
> >> +             dev_err(dev, "failed to alloc host\n");
> >> +             return PTR_ERR(host);
> >> +     }
> >> +
> >> +     pxa =3D sdhci_priv(host);
> >> +     pxa->host =3D host;
> >> +     pxa->pdata =3D pdata;
> >> +     pxa->clk_enable =3D 0;
> >> +
> >> +     pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
> >> +     if (IS_ERR(pxa->clk)) {
> >> +             dev_err(dev, "failed to get io clock\n");
> >> +             ret =3D PTR_ERR(pxa->clk);
> >> +             goto out;
> >> +     }
> >> +
> >> +     pxa->res =3D request_mem_region(iomem->start, resource_size(=
iomem),
> >> +             mmc_hostname(host->mmc));
> >> +     if (!pxa->res) {
> >> +             dev_err(&pdev->dev, "cannot request region\n");
> >> +             ret =3D -EBUSY;
> >> +             goto out;
> >> +     }
> >> +
> >> +     host->ioaddr =3D ioremap(iomem->start, resource_size(iomem))=
;
> >> +     if (!host->ioaddr) {
> >> +             dev_err(&pdev->dev, "failed to remap registers\n");
> >> +             ret =3D -ENOMEM;
> >> +             goto out;
> >> +     }
> >> +
> >> +     host->hw_name =3D "MMC";
> >> +     host->ops =3D &sdhci_pxa_ops;
> >> +     host->irq =3D irq;
> >> +     host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA |
> >> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL; +
> >=20
> > Maybe check if these aren't already set in pdata and warn user ?
>=20
> Here pdata->quirks only provide specific quirk like
> SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device, the common quir=
k
> is provided above.

Right, but what if the user also provides such a quirk? It's unnecessar=
y ... and=20
in case the quirk was removed from here later, it'd have to be removed =
from=20
user's code too ...

> In sdhci-s3c, host->quirks is modified here via pdata->cd_type, which
> is also a good method.
> Here we transfer SDHCI_QUIRK_BROKEN_CARD_DETECTION directly from pdat=
a
> since it already move to include folder.
>=20
> >> +     if (pdata->quirks)
> >> +             host->quirks |=3D pdata->quirks;
> >> +
> >> +     ret =3D sdhci_add_host(host);
> >> +     if (ret) {
> >> +             dev_err(&pdev->dev, "failed to add host\n");
> >> +             goto out;
> >> +     }
> >> +
> >> +     if (pxa->pdata->max_speed)
> >> +             host->mmc->f_max =3D pxa->pdata->max_speed;
> >=20
> > What happens otherwise ?
>=20
> Otherwise, host->mmc->f_max =3D host->max_clk set in sdhci_add_host,
> host->max_clk is 50M in 2.0 controller, and 200M in 3.0 controller, i=
f
> controller does not need to provide get_max_clock.
> it's better add defalut value in else condition.

Thanks for clearing this
>=20
> Thanks Marek for review.
>=20
> >> +
> >> +     platform_set_drvdata(pdev, host);
> >> +
> >> +     return 0;
> >> +out:
> >> +     if (host) {
> >> +             clk_put(pxa->clk);
> >> +             if (host->ioaddr)
> >> +                     iounmap(host->ioaddr);
> >> +             if (pxa->res)
> >> +                     release_mem_region(pxa->res->start,
> >> +                                     resource_size(pxa->res));
> >> +             sdhci_free_host(host);
> >> +     }
> >> +
> >> +     return ret;
> >> +}
> >> +
> >=20
> > Thanks!
> >=20
> > Cheers
