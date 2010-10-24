From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Sun, 24 Oct 2010 11:26:38 +0800
Message-ID: <AANLkTinp-0sgNO8q-4jrCyKY-R1qq7Y2Eu75NqChnKq2@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<201010231624.03293.marek.vasut@gmail.com>
	<AANLkTi=RNDf-A98LN3AH=JdegHXKRjHvtGCDYtkJ5ADg@mail.gmail.com>
	<201010231950.31707.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58227 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0JXD0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Oct 2010 23:26:40 -0400
Received: by fxm16 with SMTP id 16so1852165fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 23 Oct 2010 20:26:39 -0700 (PDT)
In-Reply-To: <201010231950.31707.marek.vasut@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, "eric.y.miao" <eric.y.miao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Oct 24, 2010 at 1:50 AM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
> Dne So 23. =F8=EDjna 2010 18:47:10 zhangfei gao napsal(a):
>> On Sat, Oct 23, 2010 at 10:24 PM, Marek Vasut <marek.vasut@gmail.com=
> wrote:
>> >> +/***************************************************************=
*******
>> >> *** ****\ + *
>> >> =A0 =A0 =A0 =A0 * + * Device probing/removal
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0* + *
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> >> +\***************************************************************=
*******
>> >> ** *****/ +
>> >> +static int __devinit sdhci_pxa_probe(struct platform_device *pde=
v)
>> >> +{
>> >> + =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform=
_data;
>> >> + =A0 =A0 struct device *dev =3D &pdev->dev;
>> >> + =A0 =A0 struct sdhci_host *host =3D NULL;
>> >> + =A0 =A0 struct resource *iomem =3D NULL;
>> >> + =A0 =A0 struct sdhci_pxa *pxa =3D NULL;
>> >> + =A0 =A0 int ret, irq;
>> >> +
>> >> + =A0 =A0 irq =3D platform_get_irq(pdev, 0);
>> >> + =A0 =A0 if (irq < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq specified\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return irq;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>> >> + =A0 =A0 if (!iomem) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory specified\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdh=
ci_pxa));
>> >> + =A0 =A0 if (IS_ERR(host)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to alloc host\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(host);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 pxa =3D sdhci_priv(host);
>> >> + =A0 =A0 pxa->host =3D host;
>> >> + =A0 =A0 pxa->pdata =3D pdata;
>> >> + =A0 =A0 pxa->clk_enable =3D 0;
>> >> +
>> >> + =A0 =A0 pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
>> >> + =A0 =A0 if (IS_ERR(pxa->clk)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to get io clock\n"=
);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pxa->clk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 pxa->res =3D request_mem_region(iomem->start, resource_=
size(iomem),
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc));
>> >> + =A0 =A0 if (!pxa->res) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot request reg=
ion\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 host->ioaddr =3D ioremap(iomem->start, resource_size(io=
mem));
>> >> + =A0 =A0 if (!host->ioaddr) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap re=
gisters\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 host->hw_name =3D "MMC";
>> >> + =A0 =A0 host->ops =3D &sdhci_pxa_ops;
>> >> + =A0 =A0 host->irq =3D irq;
>> >> + =A0 =A0 host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA |
>> >> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL; +
>> >
>> > Maybe check if these aren't already set in pdata and warn user ?
>>
>> Here pdata->quirks only provide specific quirk like
>> SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device, the common qui=
rk
>> is provided above.
>
> Right, but what if the user also provides such a quirk? It's unnecess=
ary ... and
> in case the quirk was removed from here later, it'd have to be remove=
d from
> user's code too ...

What do you mean 'in case the quirk was removed from here later'.
SDHCI_QUIRK_* is just move from drivers/mmc/host/sdhci.h to
include/linux/mmc/sdhci.h, so code in arch/arm could access them
directly.

We also consider use one flag here, like sdhci-s3c.c.
Code like this,
if (pdata->flags & PXA_FLAG_CARD_PERMENT)
     host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;

If SDHCI_QUIRK_* not permitted to access, it would be better to use thi=
s method.

>
>> In sdhci-s3c, host->quirks is modified here via pdata->cd_type, whic=
h
>> is also a good method.
>> Here we transfer SDHCI_QUIRK_BROKEN_CARD_DETECTION directly from pda=
ta
>> since it already move to include folder.
>>
>> >> + =A0 =A0 if (pdata->quirks)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D pdata->quirks;
>> >> +
>> >> + =A0 =A0 ret =3D sdhci_add_host(host);
>> >> + =A0 =A0 if (ret) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add host=
\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 if (pxa->pdata->max_speed)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_sp=
eed;
>> >
>> > What happens otherwise ?
>>
>> Otherwise, host->mmc->f_max =3D host->max_clk set in sdhci_add_host,
>> host->max_clk is 50M in 2.0 controller, and 200M in 3.0 controller, =
if
>> controller does not need to provide get_max_clock.
>> it's better add defalut value in else condition.
>
> Thanks for clearing this
>>
>> Thanks Marek for review.
>>
>> >> +
>> >> + =A0 =A0 platform_set_drvdata(pdev, host);
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +out:
>> >> + =A0 =A0 if (host) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pxa->clk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ioaddr)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(host->ioaddr);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->res)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(pxa-=
>res->start,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 resource_size(pxa->res));
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(host);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return ret;
>> >> +}
>> >> +
>> >
>> > Thanks!
>> >
>> > Cheers
>
