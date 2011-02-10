From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Thu, 10 Feb 2011 22:37:41 +0530
Message-ID: <AANLkTikLLSXGg+VMubeRs-K=EBUuna5gFwGjvn=SsPB7@mail.gmail.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
 <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com> <alpine.DEB.2.00.1102081622180.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37716 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1BJRIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 12:08:02 -0500
In-Reply-To: <alpine.DEB.2.00.1102081622180.21991@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com

Hi Paul,

On Wed, Feb 9, 2011 at 4:59 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 2 Feb 2011, Kishore Kadiyala wrote:
>
>> Update the omap2420 hwmod data with the HSMMC info.
>
> Umm, this doesn't look right. =A0OMAP2420 doesn't have an HSMMC block=
 as far
> as I know. =A0It also uses a different driver than later OMAPs.

OK , I will update this in V3.

>
> More comments below.
>
>> Add a device attribute structure which will be used
>> by the host driver to find whether the HSMMC controller
>> supports DUAL VOLT cards.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0 88 +++++++++++++=
+++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0| =A0 =A07 ++
>> =A02 files changed, 95 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_2420_data.c
>> index b85c630..1fbb618 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> @@ -18,6 +18,7 @@
>> =A0#include <plat/serial.h>
>> =A0#include <plat/i2c.h>
>> =A0#include <plat/gpio.h>
>> +#include <plat/mmc.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -44,6 +45,7 @@ static struct omap_hwmod omap2420_gpio2_hwmod;
>> =A0static struct omap_hwmod omap2420_gpio3_hwmod;
>> =A0static struct omap_hwmod omap2420_gpio4_hwmod;
>> =A0static struct omap_hwmod omap2420_dma_system_hwmod;
>> +static struct omap_hwmod omap2420_mmc1_hwmod;
>>
>> =A0/* L3 -> L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core =3D {
>> @@ -95,6 +97,24 @@ static struct omap_hwmod_ocp_if omap2420_l4_core_=
_l4_wkup =3D {
>> =A0 =A0 =A0 .user =A0 =3D OCP_USER_MPU | OCP_USER_SDMA,
>> =A0};
>>
>> +/* L4 CORE -> MMC1 interface */
>> +static struct omap_hwmod_addr_space omap2420_mmc1_addr_space[] =3D =
{
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4809c000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4809c07f,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2420_l4_core__mmc1 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2420_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2420_mmc1_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mmchs1_ick",
>
> This clock doesn't exist in the OMAP2420 clock tree.

Corrected in V2
https://patchwork.kernel.org/patch/541911/

>
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_mmc1_addr_space,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2420_mmc1_addr_sp=
ace),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> =A0/* L4 CORE -> UART1 interface */
>> =A0static struct omap_hwmod_addr_space omap2420_uart1_addr_space[] =3D=
 {
>> =A0 =A0 =A0 {
>> @@ -196,6 +216,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_cor=
e_slaves[] =3D {
>> =A0/* Master interfaces on the L4_CORE interconnect */
>> =A0static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] =3D {
>> =A0 =A0 =A0 &omap2420_l4_core__l4_wkup,
>> + =A0 =A0 &omap2420_l4_core__mmc1,
>> =A0 =A0 =A0 &omap2_l4_core__uart1,
>> =A0 =A0 =A0 &omap2_l4_core__uart2,
>> =A0 =A0 =A0 &omap2_l4_core__uart3,
>> @@ -864,6 +885,72 @@ static struct omap_hwmod omap2420_dma_system_hw=
mod =3D {
>> =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_NO_IDLEST,
>> =A0};
>>
>> +/* MMC/SD/SDIO common */
>> +
>> +static struct omap_hwmod_class_sysconfig mmc_sysc =3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x3c,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x64,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x68,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS=
_SIDLEMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_ENAWAKEUP =
| SYSC_HAS_SOFTRESET |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_AUTOIDLE |=
 SYSS_HAS_RESET_STATUS),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class mmc_class =3D {
>> + =A0 =A0 .name =3D "mmc",
>> + =A0 =A0 .sysc =3D &mmc_sysc,
>> +};
>> +
>> +/* MMC/SD/SDIO1 */
>> +
>> +static struct mmc_dev_attr mmc1_dev_attr =3D {
>> + =A0 =A0 .flags =3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
>> +};
>> +
>> +static struct omap_hwmod_irq_info mmc1_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 83 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info mmc1_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx", .dma_req =3D 61 }, /* DMA_MMC1_TX */
>> + =A0 =A0 { .name =3D "rx", .dma_req =3D 62 }, /* DMA_MMC1_RX */
>> +};
>> +
>> +static struct omap_hwmod_opt_clk mmc1_opt_clks[] =3D {
>> + =A0 =A0 { .role =3D "dbck", .clk =3D "mmchsdb_fck" },
>
> Also does not exist on OMAP2420.

Corrected in V2
https://patchwork.kernel.org/patch/541911/

>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2420_mmc1_slaves[] =3D {
>> + =A0 =A0 &omap2420_l4_core__mmc1,
>> +};
>> +
>> +static struct omap_hwmod omap2420_mmc1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc1_hwmod",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D mmc1_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(mmc1_mpu_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D mmc1_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(mmc1_sdma_reqs),
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D mmc1_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(mmc1_opt_clks),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs1_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =A0=3D OMAP242=
0_EN_MMC_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
420_ST_MMC_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2420_mmc1_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2420_mmc1_slaves),
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &mmc_class,
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &mmc1_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420)=
,
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap2420_hwmods[] =3D {
>> =A0 =A0 =A0 &omap2420_l3_main_hwmod,
>> =A0 =A0 =A0 &omap2420_l4_core_hwmod,
>> @@ -871,6 +958,7 @@ static __initdata struct omap_hwmod *omap2420_hw=
mods[] =3D {
>> =A0 =A0 =A0 &omap2420_mpu_hwmod,
>> =A0 =A0 =A0 &omap2420_iva_hwmod,
>> =A0 =A0 =A0 &omap2420_wd_timer2_hwmod,
>> + =A0 =A0 &omap2420_mmc1_hwmod,
>> =A0 =A0 =A0 &omap2420_uart1_hwmod,
>> =A0 =A0 =A0 &omap2420_uart2_hwmod,
>> =A0 =A0 =A0 &omap2420_uart3_hwmod,
>> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-o=
map/include/plat/mmc.h
>> index f57f36a..7821344 100644
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -43,6 +43,13 @@
>>
>> =A0#define OMAP_MMC_MAX_SLOTS =A0 2
>>
>> +/* omap_hwmod integration data */
>> +#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT =A0 =A0 =A0 =A0BIT(1)
>
> Since it's not using the HSMMC driver, this is not going to do anythi=
ng.

Agree , Need to remove this

<snip>

Regards,
Kishore
