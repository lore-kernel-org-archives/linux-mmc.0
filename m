From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v3 2/5] OMAP4 HSMMC: Adding hsmmc support to board file
Date: Sat, 15 May 2010 22:38:34 +0530
Message-ID: <AANLkTimG8Cvx5_a-zFiNWp5OqCUocCtfjWj9SFjCggfD@mail.gmail.com>
References: <12490.10.24.255.17.1273781497.squirrel@dbdmail.itg.ti.com>
	 <20100514215651.GI3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55295 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab0EORIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 May 2010 13:08:37 -0400
In-Reply-To: <20100514215651.GI3428@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, adrian.hunter@nokia.com

Tony,
On Sat, May 15, 2010 at 3:26 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100513 13:06]:
>> Support for MMC1 & MMC2 controllers is added to the board file.
>> Also includes configuration of MMC1 Card detect initially.
>
> This patch does not seem to apply, I don't know where you're getting
> the sdp4430_vmmc_supply in this patch?

I have mentioned that patch series has dependency on I2c/regulator
pacthes [with links] in the cover letter.
here is the link to exact patch where sdp4430_vmmc_supply is added
to board file which i had mentioned :
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26258.html

>
> I suggest you forget about the card detect patches for now and
> first produce a minimal set of patches to get the MMC working
> for board-4430sdp.c. The card detect patches should be applied
> only after board-4430sdp.c works for MMC. And we're running out
> of time for this merge window.

Agree.
Actually the patches I've sent has that minimal changes with which MMC
works but with card detect feature dependency [Thought that card detect=
 is also
a basic feature which is much needed].

Will rework and post patches as below :
1)As Sanotsh suggested, will re-base on "for_next " branch
2)Cover letter having links to dependencies on patches [I2c/Regulator]
 with latest re-based
3)patch series with
   a) Minimal set of changes for MMC
   b) later Card detect. [Can take a call on this]

Regards,
Kishore

>
> Regards,
>
> Tony
>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 64 ++++++++++++++++++++=
+++++++++++----
>> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 44 ++++++++=
++++++++++++++++
>> =A03 files changed, 103 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index ffe600a..65d8d11 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -140,7 +140,8 @@ obj-$(CONFIG_MACH_IGEP0020) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 +=3D board-igep0020.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hsmmc.o
>> =A0obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK) =A0 +=3D board-omap3touchbook.=
o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hsmmc.o
>> -obj-$(CONFIG_MACH_OMAP_4430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D boa=
rd-4430sdp.o
>> +obj-$(CONFIG_MACH_OMAP_4430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D boa=
rd-4430sdp.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0hsmmc.o
>>
>> =A0obj-$(CONFIG_MACH_OMAP3517EVM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D b=
oard-am3517evm.o
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index d86e22d..70c8ab7 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -32,6 +32,8 @@
>> =A0#include <plat/control.h>
>> =A0#include <plat/timer-gp.h>
>> =A0#include <plat/usb.h>
>> +#include <plat/mmc.h>
>> +#include "hsmmc.h"
>>
>> =A0static struct platform_device sdp4430_lcd_device =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sdp4430_lcd",
>> @@ -68,24 +70,71 @@ static struct omap_musb_board_data musb_board_da=
ta =3D {
>> =A0 =A0 =A0 .power =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 100,
>> =A0};
>>
>> -static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> - =A0 =A0 },
>> +static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D TWL6030_IRQ_BA=
SE + MMCDETECT_INTR_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .cd_type =A0 =A0 =A0 =A0=3D NON_GPIO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
>> =A0 =A0 =A0 },
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .nonremovable =A0 =3D true,
>> =A0 =A0 =A0 },
>> + =A0 =A0 {} =A0 =A0 =A0/* Terminator */
>> +};
>> +
>> +static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dev_name =3D "mmci-omap-hs.0",
>> =A0 =A0 =A0 },
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dev_name =3D "mmci-omap-hs.1",
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pla=
tform_device, dev);
>> + =A0 =A0 struct omap_mmc_platform_data *pdata =3D dev->platform_dat=
a;
>> +
>> + =A0 =A0 /* MMC1 Card detect Configuration */
>> + =A0 =A0 if (pdev->id =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap4_hsmmc1_card_detect_config();
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unable to configur=
e Card detect for MMC1\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect_irq =3D TWL603=
0_IRQ_BASE +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MMCDETECT_INTR_OFFSET;
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static __init void omap4_twl6030_hsmmc_set_late_init(struct device =
*dev)
>> +{
>> + =A0 =A0 struct omap_mmc_platform_data *pdata =3D dev->platform_dat=
a;
>> +
>> + =A0 =A0 pdata->init =3D =A0 omap4_twl6030_hsmmc_late_init;
>> +}
>> +
>> +static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info =
*controllers)
>> +{
>> + =A0 =A0 struct omap2_hsmmc_info *c;
>> +
>> + =A0 =A0 omap2_hsmmc_init(controllers);
>> + =A0 =A0 for (c =3D controllers; c->mmc; c++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_twl6030_hsmmc_set_late_init(c->dev);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static struct regulator_init_data sdp4430_vaux1 =3D {
>> =A0 =A0 =A0 .constraints =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1000000,
>> @@ -137,7 +186,7 @@ static struct regulator_init_data sdp4430_vmmc =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | REGULATOR_CHANGE_MODE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | REGULATOR_CHANGE_STATUS,
>> =A0 =A0 =A0 },
>> - =A0 =A0 .num_consumer_supplies =A0=3D 5,
>> + =A0 =A0 .num_consumer_supplies =A0=3D 2,
>> =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D sdp4430_vmmc_supply,
>> =A0};
>>
>> @@ -256,6 +305,7 @@ static void __init omap_4430sdp_init(void)
>> =A0 =A0 =A0 omap4_i2c_init();
>> =A0 =A0 =A0 platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430=
_devices));
>> =A0 =A0 =A0 omap_serial_init();
>> + =A0 =A0 omap4_twl6030_hsmmc_init(mmc);
>> =A0 =A0 =A0 /* OMAP4 SDP uses internal transceiver so register nop t=
ransceiver */
>> =A0 =A0 =A0 usb_nop_xceiv_register();
>> =A0 =A0 =A0 /* FIXME: allow multi-omap to boot until musb is updated=
 for omap4 */
>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>> index fb6784e..f382d59 100644
>> --- a/include/linux/i2c/twl.h
>> +++ b/include/linux/i2c/twl.h
>> @@ -141,6 +141,15 @@
>> =A0#define TWL6030_CHARGER_CTRL_INT_MASK =A0 =A0 =A0 =A00x10
>> =A0#define TWL6030_CHARGER_FAULT_INT_MASK =A0 =A0 =A0 0x60
>>
>> +#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0xEE
>> +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(0x1 << 3)
>> +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(0x1 << 2)
>> +#define STS_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x1
>> +
>> +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A0 =A0 =A0 =A00xF2
>> +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x1 << 3)
>> +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x1 << 2)
>> +
>>
>> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 0x4030
>> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 0x6030
>> @@ -173,6 +182,41 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, =
unsigned num_bytes);
>> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>>
>> +/* Configuring Card Detect for MMC1 */
>> +static inline int omap4_hsmmc1_card_detect_config(void)
>> +{
>> + =A0 =A0 int res =3D -1;
>> + =A0 =A0 u8 reg_val =3D 0;
>> +
>> + =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1 from =
Phoenix */
>> + =A0 =A0 if (twl_class_is_6030()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT=
_INT_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_LINE_B);
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT=
_INT_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_STS_B);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interrupts=
 &
>> + =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> + =A0 =A0 =A0*/
>> + =A0 =A0 res =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6=
030_MMCCTRL);
>> + =A0 =A0 if (res < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
>> + =A0 =A0 reg_val |=3D SW_FC;
>> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCC=
TRL);
>> +
>> + =A0 =A0 res =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>> + =A0 =A0 if (res < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
>> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>> + =A0 =A0 return res;
>> +}
>> +
>> =A0/*---------------------------------------------------------------=
-------*/
>>
>> =A0/*
>> --
>> 1.6.3.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
