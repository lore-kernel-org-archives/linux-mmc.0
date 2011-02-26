From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v5 2/8] OMAP2430: hwmod data: Add HSMMC
Date: Sat, 26 Feb 2011 16:41:22 +0530
Message-ID: <AANLkTikFQaH-sR5egBagVAtArh91p8ehABwKBtH4VR7a@mail.gmail.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
 <1298653783-26410-3-git-send-email-kishore.kadiyala@ti.com> <alpine.DEB.2.00.1102251429320.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34050 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab1BZLLq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Feb 2011 06:11:46 -0500
In-Reply-To: <alpine.DEB.2.00.1102251429320.6198@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, b-cousson@ti.com

Hi Paul,

On Sat, Feb 26, 2011 at 3:07 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Kishore,
>
> There are several problems with this data that generate warning messa=
ges
> on boot on 2430SDP.
>
> Did you actually test this on 2430SDP? =A0The warning messages would =
have
> been obvious in the boot log.

Thanks for catching this.
Sorry I missed the warning messages in the boot log.
I will resend the patch fixing the comments.

>
> Comments below:
>
> On Fri, 25 Feb 2011, Kishore Kadiyala wrote:
>
>> From: Paul Walmsley <paul@pwsan.com>
>>
>> Update the omap2430 hwmod data with the HSMMC info.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0146 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 146 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_2430_data.c
>> index de0015d..a1c3c5e 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -54,6 +54,8 @@ static struct omap_hwmod omap2430_dma_system_hwmod=
;
>> =A0static struct omap_hwmod omap2430_mcspi1_hwmod;
>> =A0static struct omap_hwmod omap2430_mcspi2_hwmod;
>> =A0static struct omap_hwmod omap2430_mcspi3_hwmod;
>> +static struct omap_hwmod omap2430_mmc1_hwmod;
>> +static struct omap_hwmod omap2430_mmc2_hwmod;
>>
>> =A0/* L3 -> L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core =3D {
>> @@ -250,6 +252,42 @@ static struct omap_hwmod_ocp_if *omap2430_usbhs=
otg_slaves[] =3D {
>> =A0 =A0 =A0 &omap2430_l4_core__usbhsotg,
>> =A0};
>>
>> +/* L4 CORE -> MMC1 interface */
>> +static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] =3D =
{
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4809c000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4809c1ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2430_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2430_mmc1_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mmchs1_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2430_mmc1_addr_space,
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc1_addr_sp=
ace),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* L4 CORE -> MMC2 interface */
>> +static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] =3D =
{
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x480b4000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480b41ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap2430_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap2430_mmc2_hwmod,
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2430_mmc2_addr_space,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mmchs2_ick",
>> + =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc2_addr_sp=
ace),
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> =A0/* Slave interfaces on the L4_CORE interconnect */
>> =A0static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] =3D {
>> =A0 =A0 =A0 &omap2430_l3_main__l4_core,
>> @@ -258,6 +296,8 @@ static struct omap_hwmod_ocp_if *omap2430_l4_cor=
e_slaves[] =3D {
>> =A0/* Master interfaces on the L4_CORE interconnect */
>> =A0static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] =3D {
>> =A0 =A0 =A0 &omap2430_l4_core__l4_wkup,
>> + =A0 =A0 &omap2430_l4_core__mmc1,
>> + =A0 =A0 &omap2430_l4_core__mmc2,
>> =A0};
>>
>> =A0/* L4 CORE */
>> @@ -1508,6 +1548,110 @@ static struct omap_hwmod omap2430_usbhsotg_h=
wmod =3D {
>>
>>
>>
>> +/* MMC/SD/SDIO common */
>> +
>> +static struct omap_hwmod_class_sysconfig omap2430_mmc_sysc =3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x1fc,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x10,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x14,
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
>> +static struct omap_hwmod_class omap2430_mmc_class =3D {
>> + =A0 =A0 .name =3D "mmc",
>> + =A0 =A0 .sysc =3D &omap2430_mmc_sysc,
>> +};
>> +
>> +/* MMC/SD/SDIO1 */
>> +
>> +static struct omap_hwmod_irq_info omap2430_mmc1_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 83 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap2430_mmc1_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx", .dma_req =3D 61 }, /* DMA_MMC1_TX */
>> + =A0 =A0 { .name =3D "rx", .dma_req =3D 62 }, /* DMA_MMC1_RX */
>> +};
>> +
>> +static struct omap_hwmod_opt_clk omap2430_mmc1_opt_clks[] =3D {
>> + =A0 =A0 { .role =3D "dbck", .clk =3D "mmchsdb_fck" },
>
> This is not the correct name of the clock. =A0This generates warnings=
 on
> boot and prevents the HSMMC block from being soft-reset.

Ok , will fix

>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] =3D {
>> + =A0 =A0 &omap2430_l4_core__mmc1,
>> +};
>> +
>> +static struct omap_hwmod omap2430_mmc1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc1",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap2430_mmc1_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap2430_mmc1_mpu_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap2430_mmc1_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap2430_mmc1_sdma_reqs),
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap2430_mmc1_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap2430_mmc1_opt_clks),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs1_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =A0=3D OMAP243=
0_EN_MMCHS1_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
430_ST_MMCHS1_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2430_mmc1_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc1_slaves),
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap2430_mmc_class,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)=
,
>
> This needs to have HWMOD_CONTROL_OPT_CLKS_IN_RESET set in the flags,
> otherwise the softreset will not be possible. =A0See the OMAP2430 TRM=
 Rev Z
> [SWPU090Z] Table 23-10 "MMCHS_SYSSTATUS", the RESETDONE bit.

Ok, will update

>
>> +};
>> +
>> +/* MMC/SD/SDIO2 */
>> +
>> +static struct omap_hwmod_irq_info omap2430_mmc2_mpu_irqs[] =3D {
>> + =A0 =A0 { .irq =3D 86 },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap2430_mmc2_sdma_reqs[] =3D {
>> + =A0 =A0 { .name =3D "tx", .dma_req =3D 47 }, /* DMA_MMC2_TX */
>> + =A0 =A0 { .name =3D "rx", .dma_req =3D 48 }, /* DMA_MMC2_RX */
>> +};
>> +
>> +static struct omap_hwmod_opt_clk omap2430_mmc2_opt_clks[] =3D {
>> + =A0 =A0 { .role =3D "dbck", .clk =3D "mmchsdb_fck" },
>
> This is not the correct name of the clock. =A0This generates warnings=
 on
> boot and prevents the HSMMC block from being soft-reset.
>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] =3D {
>> + =A0 =A0 &omap2430_l4_core__mmc2,
>> +};
>> +
>> +static struct omap_hwmod omap2430_mmc2_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc2",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap2430_mmc2_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap2430_mmc2_mpu_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap2430_mmc2_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap2430_mmc2_sdma_reqs),
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap2430_mmc2_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap2430_mmc2_opt_clks),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs2_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =A0=3D OMAP243=
0_EN_MMCHS2_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP2=
430_ST_MMCHS2_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap2430_mmc2_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap2430_mmc2_slaves),
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap2430_mmc_class,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)=
,
>
> This needs to have HWMOD_CONTROL_OPT_CLKS_IN_RESET set in the flags,
> otherwise the softreset will not be possible. =A0See the OMAP2430 TRM=
 Rev Z
> [SWPU090Z] Table 23-10 "MMCHS_SYSSTATUS", the RESETDONE bit.
>

Ok, will update

<snip>

Thanks,
Kishore
