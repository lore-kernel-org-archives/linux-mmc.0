From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [patch] sdhci-pltfm: add call back function
Date: Mon, 27 Sep 2010 09:06:57 +0800
Message-ID: <AANLkTimhN4+RvF8cj3KTDSLLuUfQ1dR+jmEV4-Gv9qhz@mail.gmail.com>
References: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com> <20100926160933.GA23180@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64806 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab0I0BHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 21:07:23 -0400
Received: by qyk33 with SMTP id 33so6998176qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 18:07:22 -0700 (PDT)
In-Reply-To: <20100926160933.GA23180@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Richard Zhu <r65037@freescale.com>

On Mon, Sep 27, 2010 at 12:09 AM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
> On Sun, Sep 26, 2010 at 04:52:06AM -0400, zhangfei gao wrote:
>> Add several call back to sdhci-pltfm.c, help give suggestion
>
> Just formal things, without looking at the code yet.
>
> Make seperate patches out of these, everyone with a proper descriptio=
n.
>
>> 1. struct sdhci_host *(*alloc_host)(struct device *dev), since
>> specific driver need some private variable to allocate and free,
>> including clk.
>> 2. unsigned int =C2=A0(*get_quirk)(struct sdhci_host *host); add thi=
s
>> because one driver may serve several device, each one may require
>> different quirk, and specific driver is right one to know.
>> 3. void (*set_max_speed)(struct sdhci_host *host); this should be do=
ne
>> after add_host, which impact f_max.
>> 4. int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data
>> *pdata, void* priv_pdata); copy from Wolfram Sang's patch to transfe=
r
>> platform data, copy here for test.
>

Just a rough idea, considering the potential differences (I believe
there will be
more in the future) between the SDHCI of different SoCs, would it make =
more
sense to make sdhci-pltfm.c as a common function library for sdhci-<soc=
>.c?

Or from OO point of view (though I don't quite like OO), the sdhci-<soc=
> is
actually a derivative of sdhci-pltfm, which by concept, sdhci-<soc> cou=
ld be
an individual driver, and can call its super functions in sdhci-pltfm. =
E.g. in
sdhci_<soc>_probe(), one can call sdhci_pltfm_probe()?

The platform driver version may not be able to resemble the pci version=
 so
just provide an alternate way of solving this issue.

> No copying. If you think my patch is useful, add an Acked-by and say =
your
> patches depend on mine.
>
>>
>> From 8c59d0b917f434d7c424ce1e0896af45c3e5fbba Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Sun, 26 Sep 2010 16:37:11 -0400
>> Subject: [PATCH 2/2] sdhci-pltfm: add call back function
>>
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =C2=A0drivers/mmc/host/sdhci-pltfm.c | =C2=A0 24 ++++++++++++++++++-=
-----
>> =C2=A0include/linux/sdhci-pltfm.h =C2=A0 =C2=A0| =C2=A0 =C2=A05 ++++=
-
>> =C2=A02 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci=
-pltfm.c
>> index e045e3c..e06f047 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_pltfm_data *pdata =3D pdev->dev.pl=
atform_data;
>> =C2=A0 =C2=A0 =C2=A0 const struct platform_device_id *platid =3D pla=
tform_get_device_id(pdev);
>> + =C2=A0 =C2=A0 void *priv_pdata =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_host *host;
>> =C2=A0 =C2=A0 =C2=A0 struct resource *iomem;
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>>
>> - =C2=A0 =C2=A0 if (!pdata && platid && platid->driver_data)
>> + =C2=A0 =C2=A0 if (platid && platid->driver_data) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =3D (void *)p=
latid->driver_data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv_pdata =3D pdev->dev=
=2Eplatform_data;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =3D pdev->dev.plat=
form_data;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 iomem =3D platform_get_resource(pdev, IORESOURC=
E_MEM, 0);
>> =C2=A0 =C2=A0 =C2=A0 if (!iomem) {
>> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,=
 "Invalid iomem size. You may "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "experience problems.\n");
>>
>> - =C2=A0 =C2=A0 if (pdev->dev.parent)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D sdhci_alloc_hos=
t(pdev->dev.parent, 0);
>> + =C2=A0 =C2=A0 if (pdata && pdata->alloc_host)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D pdata->alloc_ho=
st(&pdev->dev);
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D sdhci_allo=
c_host(&pdev->dev, 0);
>>
>> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops =3D pdata=
->ops;
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops =3D &sdhc=
i_pltfm_ops;
>> - =C2=A0 =C2=A0 if (pdata)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
quirks;
>> +
>> =C2=A0 =C2=A0 =C2=A0 host->irq =3D platform_get_irq(pdev, 0);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!request_mem_region(iomem->start, resource_=
size(iomem),
>> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (pdata && pdata->init) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdata->init(host=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdata->init(host=
, pdata, priv_pdata);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_plat_init;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (pdata && pdata->get_quirk)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
get_quirk(host);
>> + =C2=A0 =C2=A0 else if (pdata)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
quirks;
>> +
>> =C2=A0 =C2=A0 =C2=A0 ret =3D sdhci_add_host(host);
>> =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_add_host;
>>
>> + =C2=A0 =C2=A0 if (pdata && pdata->set_max_speed)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata->set_max_speed(hos=
t);
>> +
>> =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm=
=2Eh
>> index 0239bd7..0d8e8f6 100644
>> --- a/include/linux/sdhci-pltfm.h
>> +++ b/include/linux/sdhci-pltfm.h
>> @@ -28,8 +28,11 @@ struct sdhci_host;
>> =C2=A0struct sdhci_pltfm_data {
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_ops *ops;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int quirks;
>> - =C2=A0 =C2=A0 int (*init)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 int (*init)(struct sdhci_host *host, struct sdhci_pl=
tfm_data *pdata,
>> void* priv_pdata);
>> =C2=A0 =C2=A0 =C2=A0 void (*exit)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 void (*set_max_speed)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 unsigned int =C2=A0(*get_quirk)(struct sdhci_host *h=
ost);
>> + =C2=A0 =C2=A0 struct sdhci_host *(*alloc_host)(struct device *dev)=
;
>> =C2=A0};
>>
>> =C2=A0#endif /* _SDHCI_PLTFM_H */
>> --
>> 1.7.0.4
>
>> From 8c59d0b917f434d7c424ce1e0896af45c3e5fbba Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Sun, 26 Sep 2010 16:37:11 -0400
>> Subject: [PATCH 2/2] sdhci-pltfm: add call back function
>>
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =C2=A0drivers/mmc/host/sdhci-pltfm.c | =C2=A0 24 ++++++++++++++++++-=
-----
>> =C2=A0include/linux/sdhci-pltfm.h =C2=A0 =C2=A0| =C2=A0 =C2=A05 ++++=
-
>> =C2=A02 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci=
-pltfm.c
>> index e045e3c..e06f047 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct pl=
atform_device *pdev)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_pltfm_data *pdata =3D pdev->dev.pl=
atform_data;
>> =C2=A0 =C2=A0 =C2=A0 const struct platform_device_id *platid =3D pla=
tform_get_device_id(pdev);
>> + =C2=A0 =C2=A0 void *priv_pdata =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_host *host;
>> =C2=A0 =C2=A0 =C2=A0 struct resource *iomem;
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>>
>> - =C2=A0 =C2=A0 if (!pdata && platid && platid->driver_data)
>> + =C2=A0 =C2=A0 if (platid && platid->driver_data) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =3D (void *)p=
latid->driver_data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv_pdata =3D pdev->dev=
=2Eplatform_data;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata =3D pdev->dev.plat=
form_data;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 iomem =3D platform_get_resource(pdev, IORESOURC=
E_MEM, 0);
>> =C2=A0 =C2=A0 =C2=A0 if (!iomem) {
>> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct plat=
form_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev,=
 "Invalid iomem size. You may "
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "experience problems.\n");
>>
>> - =C2=A0 =C2=A0 if (pdev->dev.parent)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D sdhci_alloc_hos=
t(pdev->dev.parent, 0);
>> + =C2=A0 =C2=A0 if (pdata && pdata->alloc_host)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D pdata->alloc_ho=
st(&pdev->dev);
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D sdhci_allo=
c_host(&pdev->dev, 0);
>>
>> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct plat=
form_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops =3D pdata=
->ops;
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->ops =3D &sdhc=
i_pltfm_ops;
>> - =C2=A0 =C2=A0 if (pdata)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
quirks;
>> +
>> =C2=A0 =C2=A0 =C2=A0 host->irq =3D platform_get_irq(pdev, 0);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!request_mem_region(iomem->start, resource_=
size(iomem),
>> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct =
platform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (pdata && pdata->init) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdata->init(host=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pdata->init(host=
, pdata, priv_pdata);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_plat_init;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (pdata && pdata->get_quirk)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
get_quirk(host);
>> + =C2=A0 =C2=A0 else if (pdata)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->quirks =3D pdata->=
quirks;
>> +
>> =C2=A0 =C2=A0 =C2=A0 ret =3D sdhci_add_host(host);
>> =C2=A0 =C2=A0 =C2=A0 if (ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_add_host;
>>
>> + =C2=A0 =C2=A0 if (pdata && pdata->set_max_speed)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata->set_max_speed(hos=
t);
>> +
>> =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm=
=2Eh
>> index 0239bd7..0d8e8f6 100644
>> --- a/include/linux/sdhci-pltfm.h
>> +++ b/include/linux/sdhci-pltfm.h
>> @@ -28,8 +28,11 @@ struct sdhci_host;
>> =C2=A0struct sdhci_pltfm_data {
>> =C2=A0 =C2=A0 =C2=A0 struct sdhci_ops *ops;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int quirks;
>> - =C2=A0 =C2=A0 int (*init)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 int (*init)(struct sdhci_host *host, struct sdhci_pl=
tfm_data *pdata, void* priv_pdata);
>> =C2=A0 =C2=A0 =C2=A0 void (*exit)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 void (*set_max_speed)(struct sdhci_host *host);
>> + =C2=A0 =C2=A0 unsigned int =C2=A0(*get_quirk)(struct sdhci_host *h=
ost);
>> + =C2=A0 =C2=A0 struct sdhci_host *(*alloc_host)(struct device *dev)=
;
>> =C2=A0};
>>
>> =C2=A0#endif /* _SDHCI_PLTFM_H */
>> --
>> 1.7.0.4
>>
>
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkyfcD0ACgkQD27XaX1/VRt1rgCdHfpBgfsUinbhf4wXCvIMreul
> tCwAoIvA7nFDgH4jBIZgLX6xRstcENaG
> =3D3A6W
> -----END PGP SIGNATURE-----
>
>
