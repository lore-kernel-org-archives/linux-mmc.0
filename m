From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Mon, 30 May 2011 01:42:04 -0400
Message-ID: <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33081 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab1E3FmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 01:42:05 -0400
Received: by vws1 with SMTP id 1so2443737vws.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2011 22:42:04 -0700 (PDT)
In-Reply-To: <201105271746.04775.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, May 27, 2011 at 11:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 25 May 2011, Zhangfei Gao wrote:
>> =A0 =A0 =A0 Instead of sharing sdhci-pxa.c, use sdhci-mmp2.c specifi=
clly for mmp2.
>> =A0 =A0 =A0 sdhci-pxa.c is used to share among pxa serious, like pxa=
910, mmp2, etc.
>> =A0 =A0 =A0 The platfrom difference are put under arch/arm, while is=
 not easy to track.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 43 ++++-
>> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +-
>> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
>> =A0drivers/mmc/host/sdhci-mmp2.c =A0 =A0 =A0 =A0 =A0| =A0303 +++++++=
+++++++++++++++++++++++++
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0303 -------=
-------------------------
>> =A05 files changed, 349 insertions(+), 313 deletions(-)
>> =A0create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>> =A0delete mode 100644 drivers/mmc/host/sdhci-pxa.c
>
> Yes, looks good for the most part. I was rather confused by the fact =
that the old
> and new file are both 303 lines, so I assumed they would be identical=
, when they
> are really completely different.
>
> There is a little room for simplification, I think:
>
>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>> +{
>> + =A0 =A0 /* Micro SD does not support write-protect feature */
>> + =A0 =A0 return 0;
>> +}
>
> You shouldn't need to provide an empty get_ro function, the
> default is that there is no write-protect.

Thanks Arnd for review.
The reason to put get_ro here is some board use micro sd, while some
board design is general sd card.
The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
return 1 in our controller, so it shows read only.
So add one call back for the board with micro sd card via flag.

>
>> +static void mmp2_set_clock(struct sdhci_host *host, unsigned int cl=
ock)
>> +{
>> + =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>> + =A0 =A0 struct sdhci_pxa *pxa =3D pltfm_host->priv;
>> +
>> + =A0 =A0 if (clock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmp2_soc_set_timing(host, pxa->pdata);
>> +}
>
> The mmp2_soc_set_timing() function is only called here, so you can ea=
sily
> merge the two into one, starting with
>
> =A0 =A0 =A0 =A0if (!clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
OK, thanks,
>
>> +static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct sdhci_pltfm_host *pltfm_host;
>> + =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_da=
ta;
>> + =A0 =A0 struct device *dev =3D &pdev->dev;
>> + =A0 =A0 struct sdhci_host *host =3D NULL;
>> + =A0 =A0 struct sdhci_pxa *pxa =3D NULL;
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct clk *clk;
>
> The probe and release functions for mmp2 and pxa910 are almost identi=
cal.
> I'd suggest you leave them in sdhci-pxa.c as a library, and export th=
em
> using EXPORT_SYMBOL_GPL. Then you can call them from the respective
> probe functions, e.g.
>
> static struct sdhci_mmp2_ops =3D {
> =A0 =A0 =A0 =A0.set_clock =3D mmp2_set_clock,
> =A0 =A0 =A0 =A0.set_uhs_signaling =3D mmp2_set_uhs_signaling,
> =A0 =A0 =A0 =A0.get_ro =3D mmp2_get_ro,
> };
> static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
> {
> =A0 =A0 =A0 =A0 unsigned int quirks =3D SDHCI_QUIRK_BROKEN_ADMA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_32BIT_DMA_ADDR
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_32BIT_DMA_SIZE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_32BIT_ADMA_SIZE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>
> =A0 =A0 =A0 =A0return sdhci_pxa_probe(pdev, quirks, sdhci_mmp2_ops);
> }
>
>> + =A0 =A0 pxa =3D kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>> + =A0 =A0 if (!pxa) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 pxa->ops =3D kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL)=
;
>> + =A0 =A0 if (!pxa->ops) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>
> I think you really shouldn't allocate the sdhci_ops dynamically.
> In fact, it would be much better if we were able to mark them
> as const in all drivers.

We found some issues when supporting multi-slot, each slot may have
different ops.
So use the method of allocating the sdhci_ops dynamically instead of
using static ops.
=46or example, emmc has 74_clocks call back, while mmc and sdio slot
does not have such ops.
If not dynamically allocate sdhci_ops, all slot ops may become same,
and 74_clocks may be called for every slot.
Also, some board may have get_ro, while other board may not, so
transfer the ops via flags.

Not sure whether it is worthy to add additional common files to share
probe and remove function.
Also the init the ops part are different.

>
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_messa=
ge_t state)
>> +{
>> + =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 return sdhci_suspend_host(host, state);
>> +}
>> +
>> +static int sdhci_mmp2_resume(struct platform_device *dev)
>> +{
>> + =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 return sdhci_resume_host(host);
>> +}
>> +#else
>> +#define sdhci_mmp2_suspend =A0 NULL
>> +#define sdhci_mmp2_resume =A0 =A0NULL
>> +#endif
>
> Similarly, I think it would be good if sdhci-pltfm.c would simply
> export these functions so you could refer to them in your driver.
> There is no need to have identical copies in each variant.
>

There are some additional code for suspend and resume, so
sdhci_pltfm_suspend may not enough.
=46or example, when enable wifi host sleep feature, additional register
have to be configured.

> =A0 =A0 =A0 =A0Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
