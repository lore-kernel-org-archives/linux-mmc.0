From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] sdhci-pltfm: add call back function
Date: Mon, 27 Sep 2010 10:50:34 +0800
Message-ID: <AANLkTikrWFvgqjr6gdzJGGG-uS9zNs6NPvq1oW1FyS7f@mail.gmail.com>
References: <AANLkTi=tkP2O+EaY5xSQ8EZAR0rP9gTz34cipC-WTHjf@mail.gmail.com>
	<20100926160933.GA23180@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65195 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0I0Cue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:50:34 -0400
Received: by iwn5 with SMTP id 5so4366730iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:50:34 -0700 (PDT)
In-Reply-To: <20100926160933.GA23180@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Richard Zhu <r65037@freescale.com>

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
>> 2. unsigned int =A0(*get_quirk)(struct sdhci_host *host); add this
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
> No copying. If you think my patch is useful, add an Acked-by and say =
your
> patches depend on mine.

No problem, here is just draft for discussion, will submit another
three call back functions.

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
>> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 24 ++++++++++++++++++------
>> =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A05 ++++-
>> =A02 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci=
-pltfm.c
>> index e045e3c..e06f047 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_da=
ta;
>> =A0 =A0 =A0 const struct platform_device_id *platid =3D platform_get=
_device_id(pdev);
>> + =A0 =A0 void *priv_pdata =3D NULL;
>> =A0 =A0 =A0 struct sdhci_host *host;
>> =A0 =A0 =A0 struct resource *iomem;
>> =A0 =A0 =A0 int ret;
>>
>> - =A0 =A0 if (!pdata && platid && platid->driver_data)
>> + =A0 =A0 if (platid && platid->driver_data) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D (void *)platid->driver_data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 priv_pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
>> =A0 =A0 =A0 if (!iomem) {
>> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Invalid iomem size.=
 You may "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "experience problems.\n"=
);
>>
>> - =A0 =A0 if (pdev->dev.parent)
>> - =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.parent=
, 0);
>> + =A0 =A0 if (pdata && pdata->alloc_host)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host =3D pdata->alloc_host(&pdev->dev);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, 0)=
;
>>
>> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops =3D pdata->ops;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops =3D &sdhci_pltfm_ops;
>> - =A0 =A0 if (pdata)
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
>> +
>> =A0 =A0 =A0 host->irq =3D platform_get_irq(pdev, 0);
>>
>> =A0 =A0 =A0 if (!request_mem_region(iomem->start, resource_size(iome=
m),
>> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pdata && pdata->init) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host, pdata, priv_pdat=
a);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_plat_init;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (pdata && pdata->get_quirk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->get_quirk(host);
>> + =A0 =A0 else if (pdata)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
>> +
>> =A0 =A0 =A0 ret =3D sdhci_add_host(host);
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_host;
>>
>> + =A0 =A0 if (pdata && pdata->set_max_speed)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_max_speed(host);
>> +
>> =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>>
>> =A0 =A0 =A0 return 0;
>> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm=
=2Eh
>> index 0239bd7..0d8e8f6 100644
>> --- a/include/linux/sdhci-pltfm.h
>> +++ b/include/linux/sdhci-pltfm.h
>> @@ -28,8 +28,11 @@ struct sdhci_host;
>> =A0struct sdhci_pltfm_data {
>> =A0 =A0 =A0 struct sdhci_ops *ops;
>> =A0 =A0 =A0 unsigned int quirks;
>> - =A0 =A0 int (*init)(struct sdhci_host *host);
>> + =A0 =A0 int (*init)(struct sdhci_host *host, struct sdhci_pltfm_da=
ta *pdata,
>> void* priv_pdata);
>> =A0 =A0 =A0 void (*exit)(struct sdhci_host *host);
>> + =A0 =A0 void (*set_max_speed)(struct sdhci_host *host);
>> + =A0 =A0 unsigned int =A0(*get_quirk)(struct sdhci_host *host);
>> + =A0 =A0 struct sdhci_host *(*alloc_host)(struct device *dev);
>> =A0};
>>
>> =A0#endif /* _SDHCI_PLTFM_H */
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
>> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 24 ++++++++++++++++++------
>> =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A05 ++++-
>> =A02 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci=
-pltfm.c
>> index e045e3c..e06f047 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -54,12 +54,17 @@ static int __devinit sdhci_pltfm_probe(struct pl=
atform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_da=
ta;
>> =A0 =A0 =A0 const struct platform_device_id *platid =3D platform_get=
_device_id(pdev);
>> + =A0 =A0 void *priv_pdata =3D NULL;
>> =A0 =A0 =A0 struct sdhci_host *host;
>> =A0 =A0 =A0 struct resource *iomem;
>> =A0 =A0 =A0 int ret;
>>
>> - =A0 =A0 if (!pdata && platid && platid->driver_data)
>> + =A0 =A0 if (platid && platid->driver_data) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D (void *)platid->driver_data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 priv_pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
>> =A0 =A0 =A0 if (!iomem) {
>> @@ -71,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Invalid iomem size.=
 You may "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "experience problems.\n"=
);
>>
>> - =A0 =A0 if (pdev->dev.parent)
>> - =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.parent=
, 0);
>> + =A0 =A0 if (pdata && pdata->alloc_host)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host =3D pdata->alloc_host(&pdev->dev);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, 0)=
;
>>
>> @@ -86,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops =3D pdata->ops;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops =3D &sdhci_pltfm_ops;
>> - =A0 =A0 if (pdata)
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
>> +
>> =A0 =A0 =A0 host->irq =3D platform_get_irq(pdev, 0);
>>
>> =A0 =A0 =A0 if (!request_mem_region(iomem->start, resource_size(iome=
m),
>> @@ -105,15 +109,23 @@ static int __devinit sdhci_pltfm_probe(struct =
platform_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pdata && pdata->init) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host, pdata, priv_pdat=
a);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_plat_init;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (pdata && pdata->get_quirk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->get_quirk(host);
>> + =A0 =A0 else if (pdata)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
>> +
>> =A0 =A0 =A0 ret =3D sdhci_add_host(host);
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_host;
>>
>> + =A0 =A0 if (pdata && pdata->set_max_speed)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_max_speed(host);
>> +
>> =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>>
>> =A0 =A0 =A0 return 0;
>> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm=
=2Eh
>> index 0239bd7..0d8e8f6 100644
>> --- a/include/linux/sdhci-pltfm.h
>> +++ b/include/linux/sdhci-pltfm.h
>> @@ -28,8 +28,11 @@ struct sdhci_host;
>> =A0struct sdhci_pltfm_data {
>> =A0 =A0 =A0 struct sdhci_ops *ops;
>> =A0 =A0 =A0 unsigned int quirks;
>> - =A0 =A0 int (*init)(struct sdhci_host *host);
>> + =A0 =A0 int (*init)(struct sdhci_host *host, struct sdhci_pltfm_da=
ta *pdata, void* priv_pdata);
>> =A0 =A0 =A0 void (*exit)(struct sdhci_host *host);
>> + =A0 =A0 void (*set_max_speed)(struct sdhci_host *host);
>> + =A0 =A0 unsigned int =A0(*get_quirk)(struct sdhci_host *host);
>> + =A0 =A0 struct sdhci_host *(*alloc_host)(struct device *dev);
>> =A0};
>>
>> =A0#endif /* _SDHCI_PLTFM_H */
>> --
>> 1.7.0.4
>>
>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
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
