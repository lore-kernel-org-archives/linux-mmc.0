From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 3/7] OMAP4-HSMMC: Adding Card detect support
Date: Tue, 4 May 2010 11:41:52 +0530
Message-ID: <w2o7f9d1ffb1005032311udda8b2clcee872f93a51ac51@mail.gmail.com>
References: <63568.10.24.255.18.1271874040.squirrel@dbdmail.itg.ti.com>
	 <20100421190827.GH18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42755 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab0EDGLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 02:11:53 -0400
In-Reply-To: <20100421190827.GH18272@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

On Thu, Apr 22, 2010 at 12:38 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:16]:
>> Since OMAP4's card detection doesn't support GPIO,this patch
>> basically moves card detection API from driver to Board file so
>> that it can handle in both GPIO and NON-GPIO case.
>> This Patch also adds a flag which can differentiate whether the
>> card-detect line is GPIO or NON-GPIO.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 | =A0 =A01 +
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 74 ++++++++=
+++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/hsmmc.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A03 +-
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0 29 +---------=
--
>> =A05 files changed, 81 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index eae7c80..4e8f74e 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -89,6 +89,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* but is a phoenix interrupt
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D 384,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .cd_type =A0 =A0 =A0 =A0=3D true,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
>> =A0 =A0 =A0 },
>> =A0 =A0 =A0 {
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 9ad2295..ca3d4c9 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -13,6 +13,8 @@
>> =A0#include <linux/slab.h>
>> =A0#include <linux/string.h>
>> =A0#include <linux/delay.h>
>> +#include <linux/gpio.h>
>> +#include <linux/i2c/twl.h>
>> =A0#include <mach/hardware.h>
>> =A0#include <plat/control.h>
>> =A0#include <plat/mmc.h>
>> @@ -27,7 +29,11 @@ static u16 control_devconf1_offset;
>>
>> =A0#define HSMMC_NAME_LEN =A0 =A0 =A0 9
>>
>> +/* Phoenix Registers */
>> +#define TWL6030_MMCCTRL =A0 =A0 =A00xEE
>
> This define belongs to the twl code.

Agreed.

>
>> =A0static struct hsmmc_controller {
>> + =A0 =A0 struct omap_mmc_platform_data =A0 *mmc;
>> =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0name[HSMMC_NAME_LEN + 1];
>> =A0} hsmmc[OMAP34XX_NR_MMC];
>>
>> @@ -42,6 +48,50 @@ static int hsmmc_get_context_loss(struct device *=
dev)
>> =A0#define hsmmc_get_context_loss NULL
>> =A0#endif
>>
>> +static int twl_mmc_get_cover_state(struct device *dev, int slot)
>> +{
>> + =A0 =A0 struct omap_mmc_platform_data *mmc =3D dev->platform_data;
>> +
>> + =A0 =A0 /* NOTE: assumes card detect signal is active-low */
>> + =A0 =A0 return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
>> +}
>> +
>> +static int twl_mmc_card_detect(int irq)
>> +{
>> + =A0 =A0 unsigned i;
>> + =A0 =A0 u8 read_reg;
>> + =A0 =A0 unsigned res;
>> +
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(hsmmc); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct omap_mmc_platform_data *mmc;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc =3D hsmmc[i].mmc;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (irq !=3D mmc->slots[0].card_detect_irq=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->slots[0].nongpio_cd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* BIT0 of REG_MMC_CTRL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0 - Card not present
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1 - Card present
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D twl_i2c_read_u8(TW=
L6030_MODULE_ID0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &read_reg, TWL6030_MMCCTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res >=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rea=
d_reg & 0x1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !gpio_get_value_can=
sleep
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (mmc->slots[0].switch_pin);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: assumes card dete=
ct signal is active-low */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !gpio_get_value_can=
sleep
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (mmc->slots[0].switch_pin);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return -ENOSYS;
>> +}
>
> You should just register a separate twl_card_detect function during i=
nit
> instead of doing these tests over and over again.

Agreed.

>
>> =A0static void hsmmc1_before_set_reg(struct device *dev, int slot,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =
power_on, int vdd)
>> =A0{
>> @@ -189,8 +239,32 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc=
_info
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->get_context_loss_count =3D hsmmc_ge=
t_context_loss;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].switch_pin =3D c->gpio_cd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].nongpio_cd =3D c->cd_type;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].gpio_wp =3D c->gpio_wp;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* TWL Card detect can be GPIO based or NO=
N-GPIO Based */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!c->cd_type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(c->gpio_=
cd)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots=
[0].card_detect_irq =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 gpio_to_irq(c->gpio_cd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c->cov=
er_only)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc->slots[0].get_cover_state =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 twl_mmc_get_cover_state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc->slots[0].card_detect =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl_mmc_card_detect;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots=
[0].switch_pin =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].card_detect_=
irq =3D c->gpio_cd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c->cover_only)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots=
[0].get_cover_state =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 twl_mmc_get_cover_state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots=
[0].card_detect =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl_mmc_card_detect;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].remux =3D c->remux;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c->cover_only)
>
> Once you register separate twl_card_detect during init, this part wil=
l
> not be needed.

Agreed

>
>> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc=
=2Eh
>> index 36f0ba8..3dfc43a 100644
>> --- a/arch/arm/mach-omap2/hsmmc.h
>> +++ b/arch/arm/mach-omap2/hsmmc.h
>> @@ -17,6 +17,7 @@ struct omap2_hsmmc_info {
>> =A0 =A0 =A0 bool =A0 =A0no_off; =A0 =A0 =A0 =A0 /* power_saving and =
power is not to go off */
>> =A0 =A0 =A0 bool =A0 =A0vcc_aux_disable_is_sleep; /* Regulator off r=
emapped to sleep */
>> =A0 =A0 =A0 int =A0 =A0 gpio_cd; =A0 =A0 =A0 =A0/* or -EINVAL */
>> + =A0 =A0 bool =A0 =A0cd_type; =A0 =A0 =A0 =A0/* Card detect Type:NO=
N-GPIO=3Dtrue,GPIO=3Dflase */
>> =A0 =A0 =A0 int =A0 =A0 gpio_wp; =A0 =A0 =A0 =A0/* or -EINVAL */
>> =A0 =A0 =A0 char =A0 =A0*name; =A0 =A0 =A0 =A0 =A0/* or NULL for def=
ault */
>> =A0 =A0 =A0 struct device *dev; =A0 =A0 /* returned: pointer to mmc =
adapter */
>> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-o=
map/include/plat/mmc.h
>> index a1bac07..521decc 100644
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -103,6 +103,7 @@ struct omap_mmc_platform_data {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned vcc_aux_disable_is_sleep:1;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int switch_pin; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /* gpio (card detect) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned nongpio_cd:1; =A0/* NON-GPIO=3Dtr=
ue , GPIO=3Dfalse */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int gpio_wp; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0/* gpio (write protect) */
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*set_bus_mode)(struct device *dev, =
int slot, int bus_mode);
>> @@ -132,7 +133,7 @@ struct omap_mmc_platform_data {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Card detection IRQs */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int card_detect_irq;
>> - =A0 =A0 =A0 =A0 =A0 =A0 int (*card_detect)(struct device *dev, int=
 slot);
>> + =A0 =A0 =A0 =A0 =A0 =A0 int (*card_detect)(int irq);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int ban_openended:1;
>>
>
> Why are you removing *dev from card_detect?

My fault and will retain in next version

>
> Will comment further after that all is fixed. Please also make sure
> omap_hsmmc.c compiles and works as a module.

Sure will test omap_hsmmc.c as module .

Regards,
Kishore
