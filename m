From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v3 4/5] OMAP: hwmod data: Add dev_attr and use in the host driver
Date: Thu, 24 Feb 2011 19:28:59 +0530
Message-ID: <AANLkTimcUqsH94eG4xpR=5UQ1ry94meuZ8_vUgt3TPX+@mail.gmail.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
 <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com> <4D663A27.2010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48531 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754769Ab1BXN7V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 08:59:21 -0500
In-Reply-To: <4D663A27.2010502@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Feb 24, 2011 at 4:29 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
>>
>> Add a device attribute to hwmod data of omap2430, omap3, omap4.
>> Currently the device attribute holds information regarding dual volt=
 MMC
>> card
>> support by the controller which will be later passed to the host dri=
ver
>> via
>> platform data.
>>
>> Signed-off-by: Kevin Hilman<khilman@deeprootsystems.com>
>> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>
> There are few minor comments to fix hence the:
> Almost-Acked-by: Benoit Cousson<b-cousson@ti.com>
>
>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A09 +++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 12 ++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 16 +++++++++++++=
+++
>> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0| =A0 10 +++++++=
+++
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++--
>> =A05 files changed, 49 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> index 4d45b7d..e050355 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -19,6 +19,7 @@
>> =A0#include<plat/i2c.h>
>> =A0#include<plat/gpio.h>
>> =A0#include<plat/mcspi.h>
>> +#include<plat/mmc.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -1290,6 +1291,10 @@ static struct omap_hwmod_class mmc_class =3D =
{
>>
>> =A0/* MMC/SD/SDIO1 */
>>
>> +static struct mmc_dev_attr mmc1_dev_attr =3D {
>
> Could you rename the struct omap_mmc_dev_attr to stick to the convent=
ion?

Ok

>
> The dev_attr should be just above "static struct omap_hwmod". See the=
 OMAP4
> example below.
>
>> + =A0 =A0 =A0 .flags =3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
>> +};
>> +
>> =A0static struct omap_hwmod_irq_info mmc1_mpu_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 83 },
>> =A0};
>> @@ -1328,11 +1333,14 @@ static struct omap_hwmod omap2430_mmc1_hwmod=
 =3D {
>> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap2430_mmc1_slaves,
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc1_slav=
es),
>> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D&mmc_class,
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&mmc1_dev_attr,
>
> dev_attr should be above .slaves.
>
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
2430),
>> =A0};
>>
>> =A0/* MMC/SD/SDIO2 */
>>
>> +static struct mmc_dev_attr mmc2_dev_attr;
>
> If you do not have any dev_attr for that instance, do not add it here=
 and
> test for null pointer in your driver.
> This comment applies for all instances in all OMAPs.

ok

>
>> +
>> =A0static struct omap_hwmod_irq_info mmc2_mpu_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 86 },
>> =A0};
>> @@ -1371,6 +1379,7 @@ static struct omap_hwmod omap2430_mmc2_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap2430_mmc2_slaves,
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc2_slav=
es),
>> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D&mmc_class,
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&mmc2_dev_attr,
>
> Not needed if there is not data in the structure.

ok

>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index dd39e75..6c4ccfd 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -25,6 +25,7 @@
>> =A0#include<plat/gpio.h>
>> =A0#include<plat/dma.h>
>> =A0#include<plat/mcspi.h>
>> +#include<plat/mmc.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -3383,6 +3384,10 @@ static struct omap_hwmod_class
>> omap44xx_mmc_hwmod_class =3D {
>> =A0};
>>
>> =A0/* mmc1 */
>> +static struct mmc_dev_attr omap_mmc1_dev_attr =3D {
>> + =A0 =A0 =A0 .flags =3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
>> +};
>> +
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 83 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -3437,10 +3442,14 @@ static struct omap_hwmod omap44xx_mmc1_hwmod=
 =3D {
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc1_slav=
es),
>> =A0 =A0 =A0 =A0.masters =A0 =A0 =A0 =A0=3D omap44xx_mmc1_masters,
>> =A0 =A0 =A0 =A0.masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_mmc1_mast=
ers),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&omap_mmc1_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> =A0/* mmc2 */
>> +static struct omap_hwmod omap44xx_mmc2_hwmod;
>> +static struct mmc_dev_attr omap_mmc2_dev_attr;
>> +
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 86 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -3495,11 +3504,13 @@ static struct omap_hwmod omap44xx_mmc2_hwmod=
 =3D {
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc2_slav=
es),
>> =A0 =A0 =A0 =A0.masters =A0 =A0 =A0 =A0=3D omap44xx_mmc2_masters,
>> =A0 =A0 =A0 =A0.masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_mmc2_mast=
ers),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&omap_mmc2_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> =A0/* mmc3 */
>> =A0static struct omap_hwmod omap44xx_mmc3_hwmod;
>> +static struct mmc_dev_attr omap_mmc3_dev_attr;
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 94 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -3547,11 +3558,13 @@ static struct omap_hwmod omap44xx_mmc3_hwmod=
 =3D {
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_mmc3_slaves,
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc3_slav=
es),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&omap_mmc3_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> =A0/* mmc4 */
>> =A0static struct omap_hwmod omap44xx_mmc4_hwmod;
>> +static struct mmc_dev_attr omap_mmc4_dev_attr;
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 96 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -3599,11 +3612,13 @@ static struct omap_hwmod omap44xx_mmc4_hwmod=
 =3D {
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_mmc4_slaves,
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc4_slav=
es),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&omap_mmc4_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> =A0/* mmc5 */
>> =A0static struct omap_hwmod omap44xx_mmc5_hwmod;
>> +static struct mmc_dev_attr omap_mmc5_dev_attr;
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 59 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -3651,6 +3666,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_mmc5_slaves,
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc5_slav=
es),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&omap_mmc5_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>
> In order to be aligned with the generator, and assuming that only the=
 mm1
> needs dev_attr, the OMAP4 diff should be:

ok, will have changes as below.

>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 79a8601..958651c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3420,6 +3420,11 @@ static struct omap_hwmod_ocp_if
> *omap44xx_mmc1_slaves[] =3D {
> =A0 =A0 =A0 =A0&omap44xx_l4_per__mmc1,
> =A0};
>
> +/* mmc1 dev_attr */
> +static struct omap_mmc_dev_attr mmc1_dev_attr =3D {
> + =A0 =A0 =A0 .flags =A0=3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> +};
> +
> =A0static struct omap_hwmod omap44xx_mmc1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc1",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mmc_hwmod_clas=
s,
> @@ -3433,6 +3438,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.clkctrl_reg =3D OMAP4=
430_CM_L3INIT_MMC1_CLKCTRL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &mmc1_dev_attr,
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_mmc1_slaves,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc1_slave=
s),
> =A0 =A0 =A0 =A0.masters =A0 =A0 =A0 =A0=3D omap44xx_mmc1_masters,
> ---
>
> Regards,
> Benoit
>
