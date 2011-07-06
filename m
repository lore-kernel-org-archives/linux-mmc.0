From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: add device tree probe
 support
Date: Wed, 6 Jul 2011 11:31:47 +0800
Message-ID: <20110706033146.GA26172@S2100-06.ap.freescale.net>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
 <1309879568-25837-4-git-send-email-shawn.guo@linaro.org>
 <CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:2832
	"EHLO CH1EHSOBE015.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752329Ab1GFDZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2011 23:25:30 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 05, 2011 at 11:54:34AM -0600, Grant Likely wrote:
> On Tue, Jul 5, 2011 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wrot=
e:
> > The patch adds device tree probe support for sdhci-esdhc-imx driver=
=2E
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > =A0.../devicetree/bindings/mmc/fsl-imx-esdhc.txt =A0 =A0 =A0| =A0 4=
0 ++++++++
> > =A0drivers/mmc/host/sdhci-esdhc-imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0102 +++++++++++++++++++-
> > =A02 files changed, 137 insertions(+), 5 deletions(-)
> > =A0create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx=
-esdhc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.tx=
t b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > new file mode 100644
> > index 0000000..351d239
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -0,0 +1,40 @@
> > +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.=
MX
> > +
> > +The Enhanced Secure Digital Host Controller on Freescale i.MX fami=
ly
> > +provides an interface for MMC, SD, and SDIO types of memory cards.
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-esdhc"
> > +- reg : Should contain eSDHC registers location and length
> > +- interrupts : Should contain eSDHC interrupt
> > +- cd-type : String, card detection (CD) method. =A0Supported value=
s are:
> > + =A0 =A0"none" : No CD
> > + =A0 =A0"controller" : Uses eSDHC controller internal CD signal
> > + =A0 =A0"gpio" : Uses GPIO pin for CD
> > + =A0 =A0"permanent" : No CD because card is permanently wired to h=
ost
> > +- wp-type : String, write protection (WP) method. =A0Supported val=
ues are:
> > + =A0 =A0"none" : No WP
> > + =A0 =A0"controller" : Uses eSDHC controller internal WP signal
> > + =A0 =A0"gpio" : Uses GPIO pin for WP
> > +- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, if
> > + =A0properties cd-type and wp-type are "gpio".
>=20
> Again, be explicit in your gpios property names.  Create a different
> property for each gpio: cd-gpios and wp-gpios.
>=20
Sorry. I fixed the example below.  But this one got missed.

> As for wp-type and cd-type, I think you can drop them.  Default to
> internal controller CD and WP pins.  Use gpio if cd-gpios or wp-gpios
> is present, and define specific properties for the no-wp, no-cd and
> fixed-card cases.  (can you tell that I'm not a fan of the "*-type"
> binding for this driver?)  :-)
>=20
Ok, I'm getting to know you.

> > +
> > +Examples:
> > +
> > +esdhc@70004000 {
> > + =A0 =A0 =A0 compatible =3D "fsl,imx51-esdhc";
> > + =A0 =A0 =A0 reg =3D <0x70004000 0x4000>;
> > + =A0 =A0 =A0 interrupts =3D <1>;
> > + =A0 =A0 =A0 fsl,cd-type =3D "controller";
> > + =A0 =A0 =A0 fsl,wp-type =3D "controller";
> > +};
> > +
> > +esdhc@70008000 {
> > + =A0 =A0 =A0 compatible =3D "fsl,imx51-esdhc";
> > + =A0 =A0 =A0 reg =3D <0x70008000 0x4000>;
> > + =A0 =A0 =A0 interrupts =3D <2>;
> > + =A0 =A0 =A0 fsl,cd-type =3D "gpio";
> > + =A0 =A0 =A0 fsl,wp-type =3D "gpio";
> > + =A0 =A0 =A0 cd-gpios =3D <&gpio0 6 0>; /* GPIO1_6 */
> > + =A0 =A0 =A0 wp-gpios =3D <&gpio0 5 0>; /* GPIO1_5 */
> > +};
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/=
sdhci-esdhc-imx.c
> > index 1edda29..593d6b9 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -20,6 +20,9 @@
> > =A0#include <linux/mmc/host.h>
> > =A0#include <linux/mmc/mmc.h>
> > =A0#include <linux/mmc/sdio.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> > =A0#include <mach/esdhc.h>
> > =A0#include "sdhci-pltfm.h"
> > =A0#include "sdhci-esdhc.h"
> > @@ -72,6 +75,14 @@ static struct platform_device_id imx_esdhc_devty=
pe[] =3D {
> > =A0 =A0 =A0 =A0}
> > =A0};
> >
> > +static const struct of_device_id imx_esdhc_dt_ids[] =3D {
> > + =A0 =A0 =A0 { .compatible =3D "fsl,imx25-esdhc", .data =3D &imx_e=
sdhc_devtype[IMX25_ESDHC], },
> > + =A0 =A0 =A0 { .compatible =3D "fsl,imx35-esdhc", .data =3D &imx_e=
sdhc_devtype[IMX35_ESDHC], },
> > + =A0 =A0 =A0 { .compatible =3D "fsl,imx51-esdhc", .data =3D &imx_e=
sdhc_devtype[IMX51_ESDHC], },
> > + =A0 =A0 =A0 { .compatible =3D "fsl,imx53-esdhc", .data =3D &imx_e=
sdhc_devtype[IMX53_ESDHC], },
> > + =A0 =A0 =A0 { /* sentinel */ }
> > +};
> > +
> > =A0static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
> > =A0{
> > =A0 =A0 =A0 =A0return data->devtype =3D=3D IMX25_ESDHC;
> > @@ -305,24 +316,96 @@ static irqreturn_t cd_irq(int irq, void *data=
)
> > =A0 =A0 =A0 =A0return IRQ_HANDLED;
> > =A0};
> >
> > +#ifdef CONFIG_OF
> > +static const char *cd_types[] =3D {
> > + =A0 =A0 =A0 [ESDHC_CD_NONE] =A0 =A0 =A0 =A0 =3D "none",
> > + =A0 =A0 =A0 [ESDHC_CD_CONTROLLER] =A0 =3D "controller",
> > + =A0 =A0 =A0 [ESDHC_CD_GPIO] =A0 =A0 =A0 =A0 =3D "gpio",
> > + =A0 =A0 =A0 [ESDHC_CD_PERMANENT] =A0 =A0=3D "permanent",
> > +};
> > +
> > +static const char *wp_types[] =3D {
> > + =A0 =A0 =A0 [ESDHC_WP_NONE] =A0 =A0 =A0 =A0 =3D "none",
> > + =A0 =A0 =A0 [ESDHC_WP_CONTROLLER] =A0 =3D "controller",
> > + =A0 =A0 =A0 [ESDHC_WP_GPIO] =A0 =A0 =A0 =A0 =3D "gpio",
> > +};
> > +
> > +static int __devinit sdhci_esdhc_imx_probe_dt(struct platform_devi=
ce *pdev)
> > +{
> > + =A0 =A0 =A0 const struct of_device_id *of_id =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_match_device(imx_e=
sdhc_dt_ids, &pdev->dev);
> > + =A0 =A0 =A0 struct device_node *np =3D pdev->dev.of_node;
> > + =A0 =A0 =A0 struct esdhc_platform_data *boarddata;
> > + =A0 =A0 =A0 int err, i;
> > + =A0 =A0 =A0 const char *cd, *wp;
> > +
> > + =A0 =A0 =A0 if (!np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 boarddata =3D kzalloc(sizeof(*boarddata), GFP_KERNEL)=
;
> > + =A0 =A0 =A0 if (!boarddata)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 pdev->dev.platform_data =3D boarddata;
>=20
> This is illegal.  As far as device drivers are concerned,
> pdev->dev.platform_data is immutable and must not be changed.
> Otherwise they break the driver model.  If you need to keep around a
> platform_data structure, then it needs to be stored in the driver
> private data.  Your best option is to refactor the driver to not
> reference pdev->dev.platform_data after probe() exits.
>=20
Ok.  I saw a patch from Troy doing this.  Will incorporate it into
the series.

Regards,
Shawn

> > +
> > + =A0 =A0 =A0 err =3D of_property_read_string(np, "fsl,cd-type", &c=
d);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(cd_types); i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcasecmp(cd, cd_types[i])) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boarddata->cd_type =3D=
 i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 err =3D of_property_read_string(np, "fsl,wp-type", &w=
p);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(wp_types); i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcasecmp(wp, wp_types[i])) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boarddata->wp_type =3D=
 i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 boarddata->cd_gpio =3D of_get_gpio(np, 0);
> > + =A0 =A0 =A0 boarddata->wp_gpio =3D of_get_gpio(np, 1);
> > +
> > + =A0 =A0 =A0 pdev->id_entry =3D of_id->data;
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +#else
> > +static inline int sdhci_esdhc_imx_probe_dt(struct platform_device =
*pdev)
> > +{
> > + =A0 =A0 =A0 return 0;
> > +}
> > +#endif
> > +
> > =A0static int __devinit sdhci_esdhc_imx_probe(struct platform_devic=
e *pdev)
> > =A0{
> > + =A0 =A0 =A0 struct device_node *np =3D pdev->dev.of_node;
> > =A0 =A0 =A0 =A0struct sdhci_pltfm_host *pltfm_host;
> > =A0 =A0 =A0 =A0struct sdhci_host *host;
> > - =A0 =A0 =A0 struct esdhc_platform_data *boarddata;
> > + =A0 =A0 =A0 struct esdhc_platform_data *boarddata =3D NULL;
> > =A0 =A0 =A0 =A0struct clk *clk;
> > =A0 =A0 =A0 =A0int err;
> > =A0 =A0 =A0 =A0struct pltfm_imx_data *imx_data;
> >
> > + =A0 =A0 =A0 err =3D sdhci_esdhc_imx_probe_dt(pdev);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > +
> > =A0 =A0 =A0 =A0host =3D sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pda=
ta);
> > - =A0 =A0 =A0 if (IS_ERR(host))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(host);
> > + =A0 =A0 =A0 if (IS_ERR(host)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(host);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_sdhci_pltfm;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0pltfm_host =3D sdhci_priv(host);
> >
> > =A0 =A0 =A0 =A0imx_data =3D kzalloc(sizeof(struct pltfm_imx_data), =
GFP_KERNEL);
> > - =A0 =A0 =A0 if (!imx_data)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 if (!imx_data) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_imx_data;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0imx_data->devtype =3D pdev->id_entry->driver_data;
> > =A0 =A0 =A0 =A0pltfm_host->priv =3D imx_data;
> > @@ -416,12 +499,17 @@ no_board_data:
> > =A0 =A0 =A0 =A0clk_put(pltfm_host->clk);
> > =A0err_clk_get:
> > =A0 =A0 =A0 =A0kfree(imx_data);
> > +err_imx_data:
> > =A0 =A0 =A0 =A0sdhci_pltfm_free(pdev);
> > +err_sdhci_pltfm:
> > + =A0 =A0 =A0 if (np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(boarddata);
> > =A0 =A0 =A0 =A0return err;
> > =A0}
> >
> > =A0static int __devexit sdhci_esdhc_imx_remove(struct platform_devi=
ce *pdev)
> > =A0{
> > + =A0 =A0 =A0 struct device_node *np =3D pdev->dev.of_node;
> > =A0 =A0 =A0 =A0struct sdhci_host *host =3D platform_get_drvdata(pde=
v);
> > =A0 =A0 =A0 =A0struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(h=
ost);
> > =A0 =A0 =A0 =A0struct esdhc_platform_data *boarddata =3D host->mmc-=
>parent->platform_data;
> > @@ -444,6 +532,9 @@ static int __devexit sdhci_esdhc_imx_remove(str=
uct platform_device *pdev)
> >
> > =A0 =A0 =A0 =A0sdhci_pltfm_free(pdev);
> >
> > + =A0 =A0 =A0 if (np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(boarddata);
> > +
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> >
> > @@ -451,6 +542,7 @@ static struct platform_driver sdhci_esdhc_imx_d=
river =3D {
> > =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "sdhci-esdhc-imx",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D imx_esdhc_dt_ids,
> > =A0 =A0 =A0 =A0},
> > =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D imx_esdhc_devtype,
> > =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_esdhc_imx_probe,
> > --
> > 1.7.4.1

