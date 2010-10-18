From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V2 1/1]MMC: add support of sdhci-pxa driver
Date: Mon, 18 Oct 2010 08:23:33 -0400
Message-ID: <AANLkTinn8dmnU_s8mF4mWKnvmWs9XESw72yh4C3Q8a8+@mail.gmail.com>
References: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
	<20101005090314.GD22830@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0JRMXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 08:23:33 -0400
Received: by iwn35 with SMTP id 35so1111727iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 05:23:33 -0700 (PDT)
In-Reply-To: <20101005090314.GD22830@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, kmpark@infradead.org, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org

On Tue, Oct 5, 2010 at 5:03 AM, Matt Fleming <matt@console-pimps.org> w=
rote:
> On Tue, Sep 28, 2010 at 11:23:35PM -0400, zhangfei gao wrote:
>> +
>> + =A0 =A0 pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
>> + =A0 =A0 if (IS_ERR(pxa->clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to get io clock\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pxa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pxa->res =3D request_mem_region(iomem->start, resource_siz=
e(iomem),
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc));
>> + =A0 =A0 if (!pxa->res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot request region=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 host->ioaddr =3D ioremap(iomem->start, resource_size(iomem=
));
>> + =A0 =A0 if (!host->ioaddr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap regis=
ters\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 host->hw_name =3D "MMC";
>> + =A0 =A0 host->ops =3D &sdhci_pxa_ops;
>> + =A0 =A0 host->irq =3D irq;
>> + =A0 =A0 host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BRO=
KEN_TIMEOUT_VAL;
>> +
>> + =A0 =A0 if (pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETECTION)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_=
DETECTION;
>
> I don't think there's a good reason to define
> PXA_QUIRK_BROKEN_CARD_DETECTION because its only use is to turn on
> SDHCI_QUIRK_BROKEN_CARD_DETECTION. As Eric pointed out, you should
> just use SDHCI_QUIRK_BROKEN_CARD_DETECTION directly. While adding new
> sdhci quirks should be avoided, using the existing ones is fine :-)

Thanks Matt for help review.
Will re-use the  SDHCI_QUIRK_BROKEN_CARD_DETECTION, which already move
to include/ and could be used in arch/arm folder.
>
>> +
>> + =A0 =A0 ret =3D sdhci_add_host(host);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add host\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (pxa->pdata->max_speed)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_speed=
;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, host);
>> +
>> + =A0 =A0 return 0;
>> +out:
>> + =A0 =A0 if (host) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ioaddr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(host->ioaddr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->res)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(pxa->re=
s->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 resource_size(pxa->res));
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(host);
>> + =A0 =A0 }
>
> Aren't you missing a clk_put() here?

Thanks, update in coming version.
>
