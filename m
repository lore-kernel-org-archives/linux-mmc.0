From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 4/7] OMAP4-HSMMC: Addind MMC-TWL regulator changes
Date: Tue, 4 May 2010 11:33:17 +0530
Message-ID: <l2k7f9d1ffb1005032303o6e0c63ddq653487090053377@mail.gmail.com>
References: <63579.10.24.255.18.1271874048.squirrel@dbdmail.itg.ti.com>
	 <20100421210023.GI18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47273 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0EDGDS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 02:03:18 -0400
In-Reply-To: <20100421210023.GI18272@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

On Thu, Apr 22, 2010 at 2:30 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:16]:
>> This patch adds PBIAS Configuration during POWER ON and OFF.
>> Also it adds MMC1 Card detect configuration on Phoenix
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0145 =
+++++++++++++++++++++++------
>> =A0arch/arm/plat-omap/include/plat/control.h | =A0 17 ++++
>> =A02 files changed, 134 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index ca3d4c9..7653434 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -26,11 +26,18 @@
>>
>> =A0static u16 control_pbias_offset;
>> =A0static u16 control_devconf1_offset;
>> +static u16 control_mmc1;
>>
>> =A0#define HSMMC_NAME_LEN =A0 =A0 =A0 9
>>
>> =A0/* Phoenix Registers */
>> -#define TWL6030_MMCCTRL =A0 =A0 =A00xEE
>> +#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A00xEE
>> +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 3)
>> +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 <=
< 2)
>> +
>> +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A00xF2
>> +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << =
3)
>> +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << =
2)
>
> These defines need to go to twl code.
>
>> =A0static struct hsmmc_controller {
>> =A0 =A0 =A0 struct omap_mmc_platform_data =A0 *mmc;
>> @@ -120,27 +127,38 @@ static void hsmmc1_before_set_reg(struct devic=
e *dev, int slot,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D=
 ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, OM=
AP243X_CONTROL_DEVCONF1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->slots[0].internal=
_clock) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D om=
ap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D O=
MAP2_MMCSDIO1ADPCLKISEL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_=
writel(reg, OMAP2_CONTROL_DEVCONF0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->slots[0].internal_clock) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(OM=
AP2_CONTROL_DEVCONF0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP2_MMCSDIO1ADP=
CLKISEL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, OMAP=
2_CONTROL_DEVCONF0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_offs=
et);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set MMC I/O to 52Mhz */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prog_io =3D omap_ctrl_read=
l(OMAP343X_CONTROL_PROG_IO1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prog_io |=3D OMAP3630_PRG_=
SDMMC1_SPEEDCTRL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(prog_io, =
OMAP343X_CONTROL_PROG_IO1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(co=
ntrol_pbias_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set MMC=
 I/O to 52Mhz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prog_io =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_=
readl(OMAP343X_CONTROL_PROG_IO1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prog_io |=3D=
 OMAP3630_PRG_SDMMC1_SPEEDCTRL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_=
writel(prog_io,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP343X_CONTROL_PROG_IO1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D O=
MAP2_PBIASSPEEDCTRL0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP2_PBIASLITEP=
WRDNZ0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP2_PBIASSPEEDC=
TRL0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(co=
ntrol_pbias_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PBIA=
SLITE_PWRDNZ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP2_PBIASLITEPWRDNZ0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_offs=
et);
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_of=
fset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP2_PBIASLITEPWRDNZ0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP2_PBIASLITEP=
WRDNZ0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PBIA=
SLITE_PWRDNZ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_MMC1_PWRDNZ);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_offs=
et);
>> =A0 =A0 =A0 }
>> =A0}
>> @@ -155,16 +173,36 @@ static void hsmmc1_after_set_reg(struct device=
 *dev, int slot,
>>
>> =A0 =A0 =A0 if (power_on) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_of=
fset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_P=
BIASSPEEDCTRL0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((1 << vdd) <=3D MMC_VDD_165_195)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP2_PBIASLITEV=
MODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP2_PBIASLITEP=
WRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP2_PBIASLITEVM=
ODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_MMC1_PBIASL=
ITE_PWRDNZ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((1 << vdd) <=3D MMC_VDD_165_195) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~=
OMAP2_PBIASLITEVMODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~=
OMAP4_MMC1_PBIASLITE_VMODE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (=
OMAP4_MMC1_PBIASLITE_PWRDNZ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D O=
MAP2_PBIASLITEVMODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (=
OMAP4_MMC1_PBIASLITE_VMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1=
_PBIASLITE_PWRDNZ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_MMC1_PWRDNZ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_offs=
et);
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_of=
fset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PB=
IASLITEPWRDNZ0 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_PBIASLITEVMODE0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP2_PBIASSPEED=
CTRL0 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_PBIA=
SLITEPWRDNZ0 | OMAP2_PBIASLITEVMODE0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D (OMAP4_MMC1_PB=
IASLITE_PWRDNZ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1=
_PBIASLITE_VMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1=
_PWRDNZ);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_offs=
et);
>> =A0 =A0 =A0 }
>> =A0}
>
> This all should be set once during init. Please don't sprinkle
> cpu_is_omapxxxx() tests all over the code. That makes the code
> hard to maintain.
>
> Instead, please just register the omap4 specific functions
> once during init. If something cannot be currently defined
> that way, making that change should be a separate patch
> before adding the omap4 code.

Agreed, i will doing it in next version.

Regards,
kishore
