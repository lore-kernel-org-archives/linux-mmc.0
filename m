From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 3/7] mmc: dw_mmc: add device tree support
Date: Thu, 10 May 2012 15:12:32 +0530
Message-ID: <CAJuYYwQqPEDP3ygkjOjeAwUr--M13KSB7JdYm8Tiok5BvJbruw@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
	<CAH9JG2XJk+CJNFiZu0C-TK_aj2gRPP5czUvTzEeDBXNejR6qvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33454 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121Ab2EJJmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:42:33 -0400
Received: by vbbff1 with SMTP id ff1so1295476vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 02:42:32 -0700 (PDT)
In-Reply-To: <CAH9JG2XJk+CJNFiZu0C-TK_aj2gRPP5czUvTzEeDBXNejR6qvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

Dear Mr. Park,

On 2 May 2012 12:25, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> On 5/2/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Add device tree based discovery support.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/mmc/synposis-dw-mshc.txt =A0 | =A0 85 +++=
++++++
>> =A0drivers/mmc/host/dw_mmc-pltfm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 24 +++
>> =A0drivers/mmc/host/dw_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0181
>> +++++++++++++++++++-
>> =A0drivers/mmc/host/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 10 +
>> =A0include/linux/mmc/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +
>> =A05 files changed, 296 insertions(+), 6 deletions(-)
>> =A0create mode 100644
>> Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.=
txt
>> b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> new file mode 100644
>> index 0000000..c1ed70e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> @@ -0,0 +1,85 @@
>> +* Synopsis Designware Mobile Storage Host Controller
>> +
>> +The Synopsis designware mobile storage host controller is used to
>> interface
>> +a SoC with storage medium such as eMMC or SD/MMC cards.
>> +
>> +Required Properties:
>> +
>> +* compatible: should be one of the following
>> + =A0 =A0 - synopsis,dw-mshc: for controllers compliant with synopsi=
s dw-mshc.
> I googled the "Synopsis Designware Mobile Storage Host Controller" an=
d
> Synopsis released it as this name. but still I like the 'dw-mmc'
> instead of'dw-mshc'.

Ok. Synopsis abbreviates this controller as MSHC in their datasheets
available online. Since device tree is more about describing the
hardware, using MSHC as the abbreviation will help with correlating
hardware specs with the dts file. So I would prefer to continue using
mshc as the abbreviation.

>> +
>> +* reg: physical base address of the dw-mshc controller and size of =
its
>> memory
>> + =A0region.
>> +
>> +* interrupts: interrupt specifier for the controller. The format an=
d value
>> of
>> + =A0the interrupt specifier depends on the interrupt parent for the
>> controller.
>> +
>> +# Slots: The slot specific information are contained within child-n=
odes
>> with
>> + =A0each child-node representing a supported slot. There should be =
atleast
>> one
>> + =A0child node representing a card slot. The name of the slot child=
 node
>> should
>> + =A0be 'slot{n}' where n is the unique number of the slot connnecte=
d to the
>> + =A0controller. The following are optional properties which can be =
included
>> in
>> + =A0the slot child node.
>> +
>> + =A0 =A0 * bus-width: specifies the width of the data bus connected=
 from the
>> + =A0 =A0 =A0 controller to the card slot. The value should be 1, 4 =
or 8. In case
>> + =A0 =A0 =A0 this property is not specified, a default value of 1 i=
s assumed for
>> + =A0 =A0 =A0 this property.
>> +
>> + =A0 =A0 * cd-gpios: specifies the card detect gpio line. The forma=
t of the
>> + =A0 =A0 =A0 gpio specifier depends on the gpio controller.
>> +
>> + =A0 =A0 * wp-gpios: specifies the write protect gpio line. The for=
mat of the
>> + =A0 =A0 =A0 gpio specifier depends on the gpio controller.
>> +
>> + =A0 =A0 * gpios: specifies a list of gpios used for command, clock=
 and data
>> + =A0 =A0 =A0 bus. The first gpio is the command line and the second=
 gpio is the
>> + =A0 =A0 =A0 clock line. The rest of the gpios (depending on the bu=
s-width
>> + =A0 =A0 =A0 property) are the data lines in no particular order. T=
he format of
>> + =A0 =A0 =A0 the gpio specifier depends on the gpio controller.
>> +
>> +Optional properties:
>> +
>> +* fifo-depth: The maximum size of the tx/rx fifo's. If this propert=
y is
>> not
>> + =A0specified, the default value of the fifo size is determined fro=
m the
>> + =A0controller registers.
>> +
>> +* =A0card-detect-delay: Delay in milli-seconds before detecting car=
d after
>> card
>> + =A0 insert event. The default value is 0.
>> +
>> +* supports-highspeed: Enables support for high speed cards (upto 50=
MHz)
>> +
>> +* card-detection-broken: The card detection functionality is not av=
ailable
>> on
>> + =A0any of the slots.
>> +
>> +* no-write-protect: The write protect pad of the controller is not
>> connected
>> + =A0to the write protect pin on the slot.
>> +
>> +Example:
>> +
>> + =A0The MSHC controller node can be split into two portions, SoC sp=
ecific
>> and
>> + =A0board specific portions as listed below.
>> +
>> + =A0 =A0 dwmmc0@12200000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "synopsis,dw-mshc";
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x12200000 0x1000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0 75 0>;
>> + =A0 =A0 };
>> +
>> + =A0 =A0 dwmmc0@12200000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 supports-highspeed;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card-detection-broken;
>> + =A0 =A0 =A0 =A0 =A0 =A0 no-write-protect;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fifo-depth =3D <0x80>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card-detect-delay =3D <200>;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 slot0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-width =3D <8>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd-gpios =3D <&gpc0 2 2 3 =
3>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpc0 0 2 0 3>,=
 <&gpc0 1 2 0 3>,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <&gpc1 0 2=
 3 3>, <&gpc1 1 2 3 3>,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <&gpc1 2 2=
 3 3>, <&gpc1 3 2 3 3>,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <&gpc0 3 2=
 3 3>, <&gpc0 4 2 3 3>,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <&gpc0 5 2=
 3 3>, <&gpc0 6 2 3 3>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 };
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
>> b/drivers/mmc/host/dw_mmc-pltfm.c
>> index 92ec3eb..2b2c9bd 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -19,8 +19,24 @@
>> =A0#include <linux/mmc/host.h>
>> =A0#include <linux/mmc/mmc.h>
>> =A0#include <linux/mmc/dw_mmc.h>
>> +#include <linux/of.h>
>> =A0#include "dw_mmc.h"
>>
>> +#ifdef CONFIG_OF
>> +static struct dw_mci_drv_data synopsis_drv_data =3D {
>> + =A0 =A0 .ctrl_type =A0 =A0 =A0=3D DW_MCI_TYPE_SYNOPSIS,
>> +};
>> +
>> +static const struct of_device_id dw_mci_pltfm_match[] =3D {
>> + =A0 =A0 { .compatible =3D "synopsis,dw-mshc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D (void *)&synopsi=
s_drv_data, },
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>> +#else
>> +static const struct of_device_id dw_mci_pltfm_match[];
>> +#endif
>> +
>> =A0static int dw_mci_pltfm_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct dw_mci *host;
>> @@ -51,6 +67,13 @@ static int dw_mci_pltfm_probe(struct platform_dev=
ice
>> *pdev)
>> =A0 =A0 =A0 if (!host->regs)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>> +
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct of_device_id *match;
>> + =A0 =A0 =A0 =A0 =A0 =A0 match =3D of_match_node(dw_mci_pltfm_match=
, pdev->dev.of_node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->drv_data =3D match->data;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 ret =3D dw_mci_probe(host);
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> @@ -111,6 +134,7 @@ static struct platform_driver dw_mci_pltfm_drive=
r =3D {
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(dw_mci_pltfm_remove=
),
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dw_mmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(dw_mci_pl=
tfm_match),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &dw_mci_=
pltfm_pmops,
>> =A0 =A0 =A0 },
>> =A0};
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 38cb7f8..bcf66d7 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -33,9 +33,13 @@
>> =A0#include <linux/bitops.h>
>> =A0#include <linux/regulator/consumer.h>
>> =A0#include <linux/workqueue.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>>
>> =A0#include "dw_mmc.h"
>>
>> +#define NUM_PINS(x) (x + 2)
>> +
>> =A0/* Common flag combinations */
>> =A0#define DW_MCI_DATA_ERROR_FLAGS =A0 =A0 =A0(SDMMC_INT_DTO | SDMMC=
_INT_DCRC | \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDMMC=
_INT_HTO | SDMMC_INT_SBE =A0| \
>> @@ -86,6 +90,8 @@ struct idmac_desc {
>> =A0struct dw_mci_slot {
>> =A0 =A0 =A0 struct mmc_host =A0 =A0 =A0 =A0 *mmc;
>> =A0 =A0 =A0 struct dw_mci =A0 =A0 =A0 =A0 =A0 *host;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wp_gpio;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd_gpio;
>>
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctype;
>>
>> @@ -816,6 +822,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D 0;
>> =A0 =A0 =A0 else if (brd->get_ro)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D brd->get_ro(slot->id);
>> + =A0 =A0 else if (gpio_is_valid(slot->wp_gpio))
>> + =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D gpio_get_value(slot->wp_gpio=
);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_readl(slot->host, WR=
TPRT) & (1 << slot->id) ? 1 : 0;
>> @@ -837,6 +845,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D 1;
>> =A0 =A0 =A0 else if (brd->get_cd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D !brd->get_cd(slot->id);
>> + =A0 =A0 else if (gpio_is_valid(slot->cd_gpio))
>> + =A0 =A0 =A0 =A0 =A0 =A0 present =3D gpio_get_value(slot->cd_gpio);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D (mci_readl(slot->host, CDETE=
CT) & (1 << slot->id))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D 0 ? 1 : 0;
>> @@ -1747,6 +1757,96 @@ static void dw_mci_work_routine_card(struct
>> work_struct *work)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +static struct device_node *dw_mci_of_find_slot_node(struct device *=
dev, u8
>> slot)
>> +{
>> + =A0 =A0 struct device_node *np;
>> + =A0 =A0 char name[7];
>> +
>> + =A0 =A0 if (!dev || !dev->of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 for_each_child_of_node(dev->of_node, np) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sprintf(name, "slot%d", slot);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(name, np->name))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return np;
>> + =A0 =A0 }
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> +{
>> + =A0 =A0 struct device_node *np =3D dw_mci_of_find_slot_node(dev, s=
lot);
>> + =A0 =A0 u32 bus_wd =3D 1;
>> +
>> + =A0 =A0 if (!np)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> +
>> + =A0 =A0 if (of_property_read_u32(np, "bus-width", &bus_wd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "bus-width property not found=
, assuming width"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " as 1\n")=
;
>> + =A0 =A0 return bus_wd;
>> +}
>> +
>> +static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bu=
s_wd)
>> +{
>> + =A0 =A0 struct device_node *np =3D dw_mci_of_find_slot_node(&host-=
>dev, slot);
>> + =A0 =A0 int idx, gpio, ret;
>> +
>> + =A0 =A0 for (idx =3D 0; idx < NUM_PINS(bus_wd); idx++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D of_get_gpio(np, idx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&host->dev, "inval=
id gpio: %d\n", gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D devm_gpio_request(&host->dev, gpio=
, "dw-mci-bus");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&host->dev, "gpio =
[%d] request failed\n", gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 host->slot[slot]->wp_gpio =3D -1;
>> + =A0 =A0 gpio =3D of_get_named_gpio(np, "wp_gpios", 0);
>> + =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "wp gpio not availabl=
e");
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D devm_gpio_request(&host->dev, gpio=
, "dw-mci-wp");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "gpio=
 [%d] request failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->slot[slot]->wp_gpio =
=3D gpio;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 host->slot[slot]->cd_gpio =3D -1;
>> + =A0 =A0 gpio =3D of_get_named_gpio(np, "cd-gpios", 0);
>> + =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "cd gpio not availabl=
e");
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D devm_gpio_request(&host->dev, gpio=
, "dw-mci-cd");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&host->dev, "gpio =
[%d] request failed\n", gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->slot[slot]->cd_gpio =
=3D gpio;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#else /* CONFIG_OF */
>> +static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> +{
>> + =A0 =A0 return 1;
>> +}
>> +
>> +static int dw_mci_of_setup_bus(struct dw_mci *host, u8 slot, u32 bu=
s_wd)
>> +{
>> + =A0 =A0 return -EINVAL;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>> =A0static int __init dw_mci_init_slot(struct dw_mci *host, unsigned =
int id)
>> =A0{
>> =A0 =A0 =A0 struct mmc_host *mmc;
>> @@ -1760,6 +1860,7 @@ static int __init dw_mci_init_slot(struct dw_m=
ci
>> *host, unsigned int id)
>> =A0 =A0 =A0 slot->id =3D id;
>> =A0 =A0 =A0 slot->mmc =3D mmc;
>> =A0 =A0 =A0 slot->host =3D host;
>> + =A0 =A0 host->slot[id] =3D slot;
>>
>> =A0 =A0 =A0 mmc->ops =3D &dw_mci_ops;
>> =A0 =A0 =A0 mmc->f_min =3D DIV_ROUND_UP(host->bus_hz, 510);
>> @@ -1780,12 +1881,21 @@ static int __init dw_mci_init_slot(struct dw=
_mci
>> *host, unsigned int id)
>> =A0 =A0 =A0 if (host->pdata->caps)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps =3D host->pdata->caps;
>>
>> + =A0 =A0 mmc->caps |=3D host->drv_data->caps;
>> +
>> =A0 =A0 =A0 if (host->pdata->caps2)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 =3D host->pdata->caps2;
>>
>> - =A0 =A0 if (host->pdata->get_bus_wd)
>> + =A0 =A0 if (host->pdata->get_bus_wd) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata->get_bus_wd(slot->id) >=3D=
 4)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4=
_BIT_DATA;
>> + =A0 =A0 } else if (host->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int bus_width;
>> + =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D dw_mci_of_get_bus_wd(&host->=
dev, slot->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bus_width >=3D 4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_B=
IT_DATA;
> In case of bus_width has 8; then how to handle it? maybe it's missing=
 one.


Yes, this was not correct. I will fix this. Thanks for pointing this ou=
t.


>> + =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_of_setup_bus(host, slot->id, bus_wi=
dth);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MM=
C_CAP_MMC_HIGHSPEED;
>> @@ -1830,7 +1940,6 @@ static int __init dw_mci_init_slot(struct dw_m=
ci
>> *host, unsigned int id)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(DW_MMC_CARD_PRESENT, &slot->fl=
ags);
>>
>> - =A0 =A0 host->slot[id] =3D slot;
>> =A0 =A0 =A0 mmc_add_host(mmc);
>>
>> =A0#if defined(CONFIG_DEBUG_FS)
>> @@ -1923,15 +2032,75 @@ static bool mci_wait_reset(struct device *de=
v,
>> struct dw_mci *host)
>> =A0 =A0 =A0 return false;
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +static struct dw_mci_of_quirks {
>> + =A0 =A0 char *quirk;
>> + =A0 =A0 int id;
>> +} of_quriks[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirk =A0=3D "supports-highspeed",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .id =A0 =A0 =3D DW_MCI_QUIRK_HIGHSPEED,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirk =A0=3D "card-detection-broken",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .id =A0 =A0 =3D DW_MCI_QUIRK_BROKEN_CARD_D=
ETECTION,
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirk =A0=3D "no-write-protect",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .id =A0 =A0 =3D DW_MCI_QUIRK_NO_WRITE_PROT=
ECT,
>> + =A0 =A0 },
>> + =A0 =A0 { }
>> +};
>> +
>> +static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>> +{
>> + =A0 =A0 struct dw_mci_board *pdata;
>> + =A0 =A0 struct device *dev =3D &host->dev;
>> + =A0 =A0 struct device_node *np =3D dev->of_node, *slot;
>> + =A0 =A0 u32 timing[3];
>> + =A0 =A0 int idx, cnt;
>> +
>> + =A0 =A0 pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory fo=
r pdata\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* find out number of slots supported */
>> + =A0 =A0 for_each_child_of_node(np, slot)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_slots++;
>> +
>> + =A0 =A0 /* get quirks */
>> + =A0 =A0 cnt =3D sizeof(of_quriks) / sizeof(struct dw_mci_of_quirks=
);
>> + =A0 =A0 for (idx =3D 0; idx < cnt; idx++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, of_quriks[idx].qui=
rk, NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->quirks |=3D of_quri=
ks[idx].id;
>> +
>> + =A0 =A0 if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_de=
pth))
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "fifo-depth property not fou=
nd, using "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "value of =
=46IFOTH register as default\n");
>> +
>> + =A0 =A0 of_property_read_u32(np, "card-detect-delay", &pdata->dete=
ct_delay_ms);
>> +
>> + =A0 =A0 return pdata;
>> +}
>> +
>> +#else /* CONFIG_OF */
>> +static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>> +{
>> + =A0 =A0 return ERR_PTR(-EINVAL);
>> +}
>> +#endif /* CONFIG_OF */
>> +
>> =A0int dw_mci_probe(struct dw_mci *host)
>> =A0{
>> =A0 =A0 =A0 int width, i, ret =3D 0;
>> =A0 =A0 =A0 u32 fifo_size;
>>
>> - =A0 =A0 if (!host->pdata || !host->pdata->init) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&host->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Platform data must supply=
 init function\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 if (!host->pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->pdata =3D dw_mci_parse_dt(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(host->pdata)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&host->dev, "platf=
orm data not available\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (!host->pdata->select_slot && host->pdata->num_slots =
> 1) {
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 15c27e1..8b8862b 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -182,4 +182,14 @@ extern int dw_mci_suspend(struct dw_mci *host);
>> =A0extern int dw_mci_resume(struct dw_mci *host);
>> =A0#endif
>>
>> +/* Variations in the dw_mci controller */
>> +#define DW_MCI_TYPE_SYNOPSIS =A0 =A0 =A0 =A0 0
>> +#define DW_MCI_TYPE_EXYNOS5250 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 /* Sam=
sung Exynos5250 Extensions */
> Um. it's not good idea to add specific SOC version. And as you know,
> exynos4 series has this controller.

There are some differences between the Exynos4 and Exynos5 mshc
controllers. For instance, the DIVRATIO field in the CLKSEL register
is available only in Exynos5 and there are 8 phase shift values in
Exynos5 when compared to 4 phase shift values in Exynos4. Likewise,
there are some other differences. So to handle these specific
implementations, we need to define types (or variants) of the
controller. Using SoC names for the type would help in readability of
the different types of implementations that are defined. So I would
prefer to continue using SoC names for this.

Thanks,
Thomas.
