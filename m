From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 1/3] mmc: atmel-mci: add device tree support
Date: Wed, 28 Mar 2012 11:04:39 +0200
Message-ID: <20120328090439.GC32137@ldesroches-Latitude-E6320>
References: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
 <1332929150-14240-2-git-send-email-ludovic.desroches@atmel.com>
 <CAJuYYwQSyGXSYjJnQSXUJZ4DaHHY7bz=OZ5bEEBxkqboN_Sa7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:6752 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757524Ab2C1JEy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Mar 2012 05:04:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJuYYwQSyGXSYjJnQSXUJZ4DaHHY7bz=OZ5bEEBxkqboN_Sa7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org

Hi Thomas,

On Wed, Mar 28, 2012 at 02:01:16PM +0530, Thomas Abraham wrote:
> On 28 March 2012 15:35,  <ludovic.desroches@atmel.com> wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > =A0.../devicetree/bindings/mmc/atmel-hsmci.txt =A0 =A0 =A0 =A0| =A0=
 67 ++++++++++++++++
> > =A0drivers/mmc/host/atmel-mci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 80 ++++++++++++++++++++
> > =A02 files changed, 147 insertions(+), 0 deletions(-)
> > =A0create mode 100644 Documentation/devicetree/bindings/mmc/atmel-h=
smci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt =
b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> > new file mode 100644
> > index 0000000..bd21e52
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> > @@ -0,0 +1,67 @@
> > +* Atmel High Speed MultiMedia Card Interface
> > +
> > +This controller on atmel products provides an interface for MMC, S=
D and SDIO
> > +types of memory cards.
> > +
> > +1) MCI node
> > +
> > +Required properties:
> > +- compatible: no blank "atmel,hsmci"
> > +- reg: should contain HSMCI registers location and length
> > +- interrupts: should contain HSMCI interrupt number
> > +- #address-cells: should be one. The cell is the slot id.
> > +- #size-cells: should be zero.
> > +- at least one slot node
> > +
> > +The node contains child nodes for each slot that the platform uses
> > +
> > +Example MCI node:
> > +
> > +mmc0: mmc@f0008000 {
> > + =A0 =A0 =A0 compatible =3D "atmel,hsmci";
> > + =A0 =A0 =A0 reg =3D <0xf0008000 0x600>;
> > + =A0 =A0 =A0 interrupts =3D <12 4>;
> > + =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 #size-cells =3D <0>;
> > +
> > + =A0 =A0 =A0 [ child node definitions...]
> > +};
> > +
> > +2) slot nodes
> > +
> > +Required properties:
> > +- reg: should contain the slot id.
> > +
> > +Optional properties:
> > +- bus-width: number of data lines connected to the controller
> > +- cd-gpios: specify GPIOs for card detection
> > +- cd-invert: invert the value of external card detect gpio line
> > +- wp-gpios: specify GPIOs for write protection
>=20
> There is a push for common bindings for sd/mmc and other card
> controllers as suggested by Arnd here:
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg13421.html
>=20

Thanks for the link, I have seen this discussion so I know that binding=
s
should change in order to have common ones.
Since I have seen no decision (or I missed it) about common bindings, I=
 only
used existing bindings:

- cd-gpios and wp-gpios seem quite common
- bus-width is used by omap-hsmmc and samsung-sdhci
- cd-invert was into patches sent for mmci device tree support

I will change my bindings if needed.

> > +
> > +Example slot node:
> > +
> > +slot@0 {
> > + =A0 =A0 =A0 reg =3D <0>;
> > + =A0 =A0 =A0 bus-width =3D <4>;
> > + =A0 =A0 =A0 cd-gpios =3D <&pioD 15 0>
> > + =A0 =A0 =A0 cd-invert;
> > +};
> > +
> > +Example full MCI node:
> > +mmc0: mmc@f0008000 {
> > + =A0 =A0 =A0 compatible =3D "atmel,hsmci";
> > + =A0 =A0 =A0 reg =3D <0xf0008000 0x600>;
> > + =A0 =A0 =A0 interrupts =3D <12 4>;
> > + =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 slot@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-width =3D <4>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd-gpios =3D <&pioD 15 0>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd-invert;
> > + =A0 =A0 =A0 };
> > + =A0 =A0 =A0 slot@1 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-width =3D <4>;
> > + =A0 =A0 =A0 };
> > +};
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-=
mci.c
> > index b5693fd..b160be6 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -19,6 +19,9 @@
> > =A0#include <linux/interrupt.h>
> > =A0#include <linux/ioport.h>
> > =A0#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> > =A0#include <linux/platform_device.h>
> > =A0#include <linux/scatterlist.h>
> > =A0#include <linux/seq_file.h>
> > @@ -477,6 +480,70 @@ err:
> > =A0 =A0 =A0 =A0dev_err(&mmc->class_dev, "failed to initialize debug=
fs for slot\n");
> > =A0}
> >
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id atmci_dt_ids[] =3D {
> > + =A0 =A0 =A0 { .compatible =3D "atmel,hsmci" },
> > + =A0 =A0 =A0 { /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, atmci_dt_ids);
> > +
> > +static int __devinit atmci_of_init(struct platform_device *pdev)
> > +{
> > + =A0 =A0 =A0 struct device_node *np =3D pdev->dev.of_node;
> > + =A0 =A0 =A0 struct device_node *cnp;
> > + =A0 =A0 =A0 struct mci_platform_data *pdata;
> > + =A0 =A0 =A0 unsigned int slot_id;
> > + =A0 =A0 =A0 const __be32 *reg;
> > +
> > + =A0 =A0 =A0 if (!np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > + =A0 =A0 =A0 pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GF=
P_KERNEL);
> > + =A0 =A0 =A0 if (!pdata)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 for_each_child_of_node(np, cnp) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(cnp, "reg", N=
ULL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!reg) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, =
"reg property is missing for %s\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cn=
p->full_name);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot_id =3D be32_to_cpu(reg[0]);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (slot_id > (ATMCI_MAX_NR_SLOTS-1))=
 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, =
"can't have more than %d slots\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AT=
MCI_MAX_NR_SLOTS);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(cnp, "bus-wi=
dth",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&pdata->slot[slot_id].bus_width))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slot[slot_id].=
bus_width =3D 1;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slot[slot_id].detect_pin =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_named_gpio(cnp=
, "cd-gpios", 0);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_find_property(cnp, "cd-invert"=
, NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slot[slot_id].=
detect_is_active_high =3D true;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slot[slot_id].wp_pin =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_named_gpio(cnp=
, "wp-gpios", 0);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 pdev->dev.platform_data =3D pdata;
>=20
> Assigning a pointer to pdev->dev.platform as done above is not
> allowed. The pointer to pdata obtained from dt should be stored as
> part of the driver's private data and used. (I used to do the same
> mistake until I learnt this lesson learnt from Grant).
>=20

Thanks for this lesson. It seems to be a usual error. I will correct it=
=2E

> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +#else /* CONFIG_OF */
> > +static inline int atmci_of_init(struct platform_device *dev)
> > +{
> > + =A0 =A0 =A0 return 0;
> > +}
> > +#endif
> > +
> > =A0static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *=
host,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0unsigned int ns)
> > =A0{
> > @@ -1847,6 +1914,13 @@ static int __init atmci_init_slot(struct atm=
el_mci *host,
> > =A0 =A0 =A0 =A0slot->sdc_reg =3D sdc_reg;
> > =A0 =A0 =A0 =A0slot->sdio_irq =3D sdio_irq;
> >
> > + =A0 =A0 =A0 dev_dbg(&mmc->class_dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "slot[%u]: bus_width=3D%u, detect_pin=
=3D%d, "
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "detect_is_active_high=3D%s, wp_pin=3D=
%d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id, slot_data->bus_width, slot_data->=
detect_pin,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot_data->detect_is_active_high ? "t=
rue" : "false",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot_data->wp_pin);
> > +
> > =A0 =A0 =A0 =A0mmc->ops =3D &atmci_ops;
> > =A0 =A0 =A0 =A0mmc->f_min =3D DIV_ROUND_UP(host->bus_hz, 512);
> > =A0 =A0 =A0 =A0mmc->f_max =3D host->bus_hz / 2;
> > @@ -2047,6 +2121,11 @@ static int __init atmci_probe(struct platfor=
m_device *pdev)
> > =A0 =A0 =A0 =A0regs =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
> > =A0 =A0 =A0 =A0if (!regs)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
> > +
> > + =A0 =A0 =A0 ret =3D atmci_of_init(pdev);
> > + =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > +
> > =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> > =A0 =A0 =A0 =A0if (!pdata)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
> > @@ -2242,6 +2321,7 @@ static struct platform_driver atmci_driver =3D=
 {
> > =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "atmel=
_mci",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =A0 =A0 =A0 =A0 =3D ATMC=
I_PM_OPS,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(atmc=
i_dt_ids),
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > --
> > 1.7.5.4
>=20
> Thanks,
> Thomas.
>

Thanks

Regards

Ludovic
