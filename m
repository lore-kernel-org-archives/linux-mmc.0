From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
Date: Fri, 1 Oct 2010 20:44:11 +0530
Message-ID: <AANLkTinoFUwMZxzkD-YxcW=L=0FD6XBHE3t-1VEv2heY@mail.gmail.com>
References: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C50E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C50E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: linux-mmc@vger.kernel.org

Manju,

On Fri, Oct 1, 2010 at 8:32 PM, G, Manjunath Kondaiah <manjugk@ti.com> =
wrote:
>
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Kadiyala, Kishore
>> Sent: Saturday, September 18, 2010 10:04 PM
>> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Cc: khilman@deeprootsystems.com; Cousson, Benoit
>> Subject: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
>>
>> The offset handling implementation of omap4 mmc registers
>> which was already present can't be reused once hwmod
>> modifications are done for mmc driver.
>> Since hwmod data file for OMAP4 is an auto generated the base
>> address for MMC will remain same as OMAP3 and thus the offset
>> deviation of registers should be updated in the hsmmc driver.
>> The omap-mmc platform data is updated with a register offset
>> which will be updated and used in the driver accordingly.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0 =A08 +++-----
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++++
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A03 +++
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A04 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c
>> b/arch/arm/mach-omap2/devices.c index 2dbb265..bb7ec13 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -745,13 +745,13 @@ void __init omap2_init_mmc(struct
>> omap_mmc_platform_data **mmc_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BASE +=
 OMAP4_MMC_REG_OFFSET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BASE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MMC=
4;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BASE +=
 OMAP4_MMC_REG_OFFSET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BASE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MMC=
5;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> @@ -762,10 +762,8 @@ void __init omap2_init_mmc(struct
>> omap_mmc_platform_data **mmc_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP2420_MMC_SI=
ZE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < 3) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D =
OMAP4_MMC_REG_OFFSET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < 3)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq +=3D=
 OMAP44XX_IRQ_GIC_START;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP4_HSMMC_SIZ=
E;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> diff --git a/arch/arm/mach-omap2/hsmmc.c
>> b/arch/arm/mach-omap2/hsmmc.c index c8f647b..49d76a7 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -261,6 +261,10 @@ void __init omap2_hsmmc_init(struct
>> omap2_hsmmc_info *controllers)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].wires =3D c->wires;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].internal_clock =3D !c->ext=
_clock;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->dma_mask =3D 0xffffffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->reg_offset =3D OMAP4_=
MMC_REG_OFFSET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->reg_offset =3D 0;
>
> 1. Since you mentioned that, this is useful for hwmod, the
> register offsets should use enum and static tables. You can
> refer to i2c-omap.c for more details and dma hwmod review
> comments for more details.
> https://patchwork.kernel.org/patch/126251/

I've avoided using static tables for register offset handling as sugges=
ted
by Benoit for HSMMC driver.Instead had the offset updated in hsmmc.c
and used in driver.

Could you check the latest version V4
http://www.spinics.net/lists/linux-omap/msg37226.html


>
> 2. Replace macros with inline functions for low level read/write
> functions.

Didn't touch this in the latest V4

Regards,
Kishore
>
> =A0-Manjunath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
