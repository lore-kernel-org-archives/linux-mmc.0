From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: adapt hsmmc to hwmod framework
Date: Thu, 24 Feb 2011 19:32:47 +0530
Message-ID: <AANLkTimN05ct07QdWyrhLVF7+b3GO74uxShW5=fAcYhh@mail.gmail.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
 <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com> <AANLkTik1BjyofdjQAfkiCpWUUDevC-1CsdxGWug3ntAu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60675 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754665Ab1BXODJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 09:03:09 -0500
In-Reply-To: <AANLkTik1BjyofdjQAfkiCpWUUDevC-1CsdxGWug3ntAu@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

On Thu, Feb 24, 2011 at 11:58 AM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
> Kishore,
>
> On Wed, Feb 23, 2011 at 23:17, Kishore Kadiyala <kishore.kadiyala@ti.=
com> wrote:
>> Changes involves:
>> 1) Remove controller reset in devices.c which is taken care of
>> =A0 by hwmod framework.
>> 2) Removing all base address macro defines except keeping one for OM=
AP2420.
>
> why?

Will  mention the details in the log

>
>> 3) Using omap-device layer to register device and utilizing data fro=
m
>> =A0 hwmod data file for base address, dma channel number, Irq_number=
,
>> =A0 device attribute.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> CC: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0251 ----------=
-----------------------
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0153 ++++++++=
++++++++++--
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 14 --
>> =A03 files changed, 141 insertions(+), 277 deletions(-)
>>
>
> <<snip>>
>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 34272e4..b6e1eae 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -16,7 +16,11 @@
>> =A0#include <mach/hardware.h>
>> =A0#include <plat/mmc.h>
>> =A0#include <plat/omap-pm.h>
>> +#include <plat/mux.h>
>> +#include <plat/omap_hwmod.h>
>> +#include <plat/omap_device.h>
>>
>> +#include "mux.h"
>> =A0#include "hsmmc.h"
>> =A0#include "control.h"
>>
>> @@ -30,7 +34,7 @@ static u16 control_mmc1;
>>
>> =A0static struct hsmmc_controller {
>> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0name[HSMMC_NAME_LEN + 1];
>> -} hsmmc[OMAP34XX_NR_MMC];
>> +} hsmmc[OMAP44XX_NR_MMC];
>
> Why do you have a dependency on OMAP44XX_NR_MMC? You should get
> this kind of information using number of iterations in *_hwmod_each_b=
y_class.

Ok , will remove

>
>>
>> =A0#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>>
>> @@ -204,7 +208,141 @@ static int nop_mmc_set_power(struct device *de=
v, int slot, int power_on,
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] _=
_initdata;
>> +static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc=
_controller,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int controller_nr)
>> +{
>> + =A0 =A0 =A0 if ((mmc_controller->slots[0].switch_pin > 0) && \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].switch_pin <=
 OMAP_MAX_GPIO_LINES))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].switch_pin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 if ((mmc_controller->slots[0].gpio_wp > 0) && \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].gpio_wp < OM=
AP_MAX_GPIO_LINES))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(mmc_controller->slo=
ts[0].gpio_wp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_clk",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_cmd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc1_dat0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_BIT_DATA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat4",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat5",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat6",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc1_dat7",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller_nr =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MMC2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_clk",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_cmd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_signal("=
sdmmc2_dat0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_P=
IN_INPUT_PULLUP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For 8 wire config=
urations, Lines DAT4, 5, 6 and 7
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* need to be muxed =
in the board-*.c files
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_C=
AP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_controller->sl=
ots[0].caps &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_8_BIT_DATA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_m=
ux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For MMC3 the pins need to be muxe=
d in the board-*.c files
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC] _=
_initdata;
>
> Ditto
>
>> +
>> +static struct omap_device_pm_latency omap_hsmmc_latency[] =3D {
>> + =A0 =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_=
hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_ena=
ble_hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =3D OMAP_DE=
VICE_LATENCY_AUTO_ADJUST,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* XXX There should also be an entry here to power o=
ff/on the
>> + =A0 =A0 =A0 =A0* MMC regulators/PBIAS cells, etc.
>> + =A0 =A0 =A0 =A0*/
>> +};
>> +
>> +static int omap2_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
>> +{
>> + =A0 =A0 =A0 struct omap_device *od;
>> + =A0 =A0 =A0 struct omap_device_pm_latency *ohl;
>> + =A0 =A0 =A0 char *name;
>> + =A0 =A0 =A0 int ohl_cnt =3D 0;
>> + =A0 =A0 =A0 struct mmc_dev_attr *mmc_dattr =3D oh->dev_attr;
>> + =A0 =A0 =A0 struct omap2_hsmmc_info *c =3D (struct omap2_hsmmc_inf=
o *) hsmmcinfo;
>> + =A0 =A0 =A0 int idx;
>> + =A0 =A0 =A0 static int mmc_num;
>> +
>> + =A0 =A0 =A0 /* Initialization of controllers which are not updated
>> + =A0 =A0 =A0 =A0* in board file will be skipped here.
>> + =A0 =A0 =A0 =A0*/
>
> Check multi-line comment style

Ok

>
>> + =A0 =A0 =A0 c +=3D mmc_num;
>> + =A0 =A0 =A0 if (!c->mmc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hsmmc_info is not updated=
 in board file\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 idx =3D c->mmc - 1 ;
>> + =A0 =A0 =A0 name =3D "mmci-omap-hs";
>> + =A0 =A0 =A0 ohl =3D omap_hsmmc_latency;
>> + =A0 =A0 =A0 ohl_cnt =3D ARRAY_SIZE(omap_hsmmc_latency);
>> + =A0 =A0 =A0 omap2_mmc_mux(hsmmc_data[idx], idx);
>> + =A0 =A0 =A0 hsmmc_data[idx]->controller_dev_attr =3D mmc_dattr->fl=
ags;
>
> It would be good rename controller_dev_attr to controller_flag

Ok

>
>> + =A0 =A0 =A0 od =3D omap_device_build(name, idx, oh, hsmmc_data[idx=
],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct omap_mmc_platform_data),=
 ohl, ohl_cnt, false);
>> + =A0 =A0 =A0 if (IS_ERR(od)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Cant build omap_device for %s=
:%s.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 name, oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(od);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* return device handle to board setup code
>> + =A0 =A0 =A0 =A0* required to populate for regulator framework stru=
cture
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 c->dev =3D &od->pdev.dev;
>> + =A0 =A0 =A0 mmc_num++;
>> + =A0 =A0 =A0 return 0;
>> +}
>>
>> =A0void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers=
)
>> =A0{
>> @@ -358,16 +496,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc=
_info *controllers)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc_data[c->mmc - 1] =3D mmc;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
>> -
>> - =A0 =A0 =A0 /* pass the device nodes back to board setup code */
>> - =A0 =A0 =A0 for (c =3D controllers; c->mmc; c++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_mmc_platform_data *mmc =3D=
 hsmmc_data[c->mmc - 1];
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!c->mmc || c->mmc > nr_hsmmc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->dev =3D mmc->dev;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 omap_hwmod_for_each_by_class("mmc", omap2_mmc_init, co=
ntrollers);
>>
>> =A0done:
>> =A0 =A0 =A0 =A0for (i =3D 0; i < nr_hsmmc; i++)
>> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-o=
map/include/plat/mmc.h
>> index 7853130..6205984 100644
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -24,20 +24,12 @@
>> =A0#define OMAP1_MMC2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xfffb7c00=
 =A0 =A0 =A0/* omap16xx only */
>>
>> =A0#define OMAP24XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> -#define OMAP34XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
>> =A0#define OMAP44XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05
>
> As mentioned above, OMAP44XX_NR_MMC & OMAP24XX_NR_MMC shall be
> removed and instead get these info from hwmod.

Agree

>
> I had provided the same comment in the previous patch version too. Yo=
u may
> reject the comment but mention the reasons for the same.
>
>> =A0#define OMAP2420_MMC_SIZE =A0 =A0 =A0OMAP1_MMC_SIZE
>> -#define OMAP3_HSMMC_SIZE =A0 =A0 =A0 0x200
>> =A0#define OMAP4_HSMMC_SIZE =A0 =A0 =A0 0x1000
>
> Can't this be removed?

will check

>
>> =A0#define OMAP2_MMC1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4809c000
>> =A0#define OMAP2_MMC2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480b4000
>> -#define OMAP3_MMC3_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480ad000
>> -#define OMAP4_MMC4_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480d1000
>> -#define OMAP4_MMC5_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480d5000
>> =A0#define OMAP4_MMC_REG_OFFSET =A0 0x100
>
> Remove OMAP4_MMC_REG_OFFSET too.

This is needed for the OMAP4 since the registers which
were accessed has offset deviation of 0x100 w.r.t to OMAP3

>
>> -#define HSMMC5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>> -#define HSMMC4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
>> -#define HSMMC3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2)
>> =A0#define HSMMC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> =A0#define HSMMC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
>
> <<snip>>
>
