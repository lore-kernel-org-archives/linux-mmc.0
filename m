From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 3/5] OMAP4-HSMMC: Adding MMC-TWL regulator changes
Date: Thu, 6 May 2010 21:35:12 +0530
Message-ID: <w2x7f9d1ffb1005060905x9f10aaf7zb94acd4ee5a0d2cb@mail.gmail.com>
References: <35156.10.24.255.17.1272988897.squirrel@dbdmail.itg.ti.com>
	 <4BE1491C.20005@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58264 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab0EFQFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2010 12:05:13 -0400
In-Reply-To: <4BE1491C.20005@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>

<<snip>>

> As I understand it, the PBIAS configuration is required for HSMMC
> irrespective of how the power is supplied, thus it is not TWL related=
=2E
> The TWL stuff should not be in hsmmc.c.
>
> Also I would suggest the only change to omap_hsmmc is:
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index e9caf69..f792cff 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -465,8 +465,6 @@ static int omap_hsmmc_gpio_init(struct
> omap_mmc_platform_data *pdata)
> =A0 =A0 =A0 int ret;
>
> =A0 =A0 =A0 if (gpio_is_valid(pdata->slots[0].switch_pin)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_c=
dirq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cdi=
rq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->slots[0].cover)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].get_cover=
_state =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap_hsmmc_get_cover_state;
> @@ -2160,6 +2158,8 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable t=
o grab MMC CD IRQ\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq_cd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_c=
dirq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cdi=
rq;
> =A0 =A0 =A0 }
>
> =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>
>
> And that the late init function is used to do the rest e.g.
> find a home for these 3 functions:
>
> static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> {
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0struct platform_device *pdev =3D container_of(dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct platform_device, dev);
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>
> =A0 =A0 =A0 =A0/* MMC1 Card detect Configuration */
> =A0 =A0 =A0 =A0if (pdev->id =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D omap4_hsmmc1_card_detect_confi=
g();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Unable to conf=
igure Card detect for MMC1\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect =3D twl603=
0_mmc_card_detect;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D TW=
L6030_IRQ_BASE +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return ret;
> }
>
> static __init void omap4_twl6030_hsmmc_set_late_init(struct device *d=
ev)
> {
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>
> =A0 =A0 =A0 =A0pdata->init =3D omap4_twl6030_hsmmc_late_init;
> }
>
> void __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *control=
lers)
> {
> =A0 =A0 =A0 =A0struct omap2_hsmmc_info *c;
>
> =A0 =A0 =A0 =A0omap2_hsmmc_init(controllers);
>
> =A0 =A0 =A0 =A0for (c =3D controllers; c->mmc; c++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_twl6030_hsmmc_set_late_init(c->d=
ev);
> }
>
> And then the board file becomes:
>
> static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0=3D 8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0=3D 8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.nonremovable =A0 =3D true,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> };
>
> static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vmmc",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev_name =A0 =A0 =A0 =3D "mmci-omap-h=
s.0",
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =3D "vmmc",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev_name =A0 =A0 =A0 =3D "mmci-omap-h=
s.1",
> =A0 =A0 =A0 =A0},
> };
>
> static int __init sdp4430_mmc_init(void)
> {
> =A0 =A0 =A0 =A0omap4_twl6030_hsmmc_init(mmc);
> =A0 =A0 =A0 =A0return 0;
> }
>

Thanks Adrian !
Agree and will move changes to board-4430 file
