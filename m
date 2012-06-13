From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Wed, 13 Jun 2012 11:11:49 +0800
Message-ID: <CAMj5Bkge5GwQmuz2MpDx19ymAac0WxvF-s2DN=x8U4OWTvmecw@mail.gmail.com>
References: <8762aw1hcw.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46890 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab2FMDLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 23:11:51 -0400
Received: by wgbdr13 with SMTP id dr13so134258wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 20:11:49 -0700 (PDT)
In-Reply-To: <8762aw1hcw.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

On Wed, Jun 13, 2012 at 3:05 AM, Chris Ball <cjb@laptop.org> wrote:
> Tested on an OLPC XO-1.75. =A0(MMP2, sdhci-pxav3, CONFIG_MACH_MMP2_DT=
=3Dy)
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> =A0.../devicetree/bindings/mmc/sdhci-pxa.txt =A0 =A0 =A0 =A0 =A0| =A0=
 21 ++++++++
> =A0drivers/mmc/host/sdhci-pxav2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 52 ++++++++++++++++++++
> =A0drivers/mmc/host/sdhci-pxav3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 50 +++++++++++++++++++
> =A03 files changed, 123 insertions(+)
> =A0create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa=
=2Etxt

Thanks Chris for the great help, compile error if CONFIG_OF not defined=
=2E

>
> +#ifdef CONFIG_OF
> +static const struct of_device_id sdhci_pxav2_of_match[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D "mrvl,pxav2-mmc",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
> +
> +static struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device =
*dev)
> +{
> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata;
> + =A0 =A0 =A0 struct device_node *np =3D dev->of_node;
> + =A0 =A0 =A0 u32 bus_width;
> + =A0 =A0 =A0 u32 clk_delay_cycles;

> +
> + =A0 =A0 =A0 return pdata;
> +}
> +#else
> +static inline struct sdhci_pxa_platdata pxav2_get_mmc_pdata(struct d=
evice *dev)
Should be static struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct
device *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +#endif
> +
> =A0static int __devinit sdhci_pxav2_probe(struct platform_device *pde=
v)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_pltfm_host *pltfm_host;
> @@ -128,6 +173,8 @@ static int __devinit sdhci_pxav2_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0struct sdhci_host *host =3D NULL;
> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D NULL;
> + =A0 =A0 =A0 const struct of_device_id *match;
> +
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0struct clk *clk;
>
> @@ -156,6 +203,10 @@ static int __devinit sdhci_pxav2_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>
> + =A0 =A0 =A0 match =3D of_match_device(of_match_ptr(sdhci_pxav2_of_m=
atch), &pdev->dev);
> + =A0 =A0 =A0 if (match) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pxav2_get_mmc_pdata(dev);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (pdata) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_CARD_PERMA=
NENT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* on-chip device */
> @@ -218,6 +269,7 @@ static struct platform_driver sdhci_pxav2_driver =
=3D {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "sdhci-pxav2",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,

#ifdef CONFIG_OF required, otherwise build fail.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D sdhci_pxav2_of_matc=
h,
#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D SDHCI_PLTFM_PMOPS,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_pxav2_probe,
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-=
pxav3.c
> index f296956..1835c94 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c

> +#ifdef CONFIG_OF
> +static const struct of_device_id sdhci_pxav3_of_match[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D "mrvl,pxav3-mmc",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_pxav3_of_match);
> +
> +static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device =
*dev)
> +{

> +}
> +#else
> +static inline struct sdhci_pxa_platdata pxav3_get_mmc_pdata(struct d=
evice *dev)
Should be static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct
device *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +#endif
> +
> @@ -263,6 +312,7 @@ static int __devexit sdhci_pxav3_remove(struct pl=
atform_device *pdev)
> =A0static struct platform_driver sdhci_pxav3_driver =3D {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "sdhci-pxav3",
#ifdef CONFIG_OF required, otherwise build fail.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D sdhci_pxav3_of_matc=
h,
#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D SDHCI_PLTFM_PMOPS,
> =A0 =A0 =A0 =A0},
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
