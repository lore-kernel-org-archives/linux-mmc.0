From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 3/5] OMAP4-HSMMC: Adding MMC-TWL regulator changes
Date: Wed, 5 May 2010 12:29:38 +0530
Message-ID: <h2x7f9d1ffb1005042359oe9f51814xbc69265261c461d6@mail.gmail.com>
References: <35156.10.24.255.17.1272988897.squirrel@dbdmail.itg.ti.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C6E6E@dbde02.ent.ti.com>
	 <l2x7f9d1ffb1005042349wea6b4c1cwa264576612731342@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C705F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33278 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab0EEG7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 02:59:40 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C705F@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>

On Wed, May 5, 2010 at 12:27 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
>
>> -----Original Message-----
>> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
>> Sent: Wednesday, May 05, 2010 12:19 PM
>> To: G, Manjunath Kondaiah
>> Cc: Kadiyala, Kishore; linux-mmc@vger.kernel.org;
>> linux-omap@vger.kernel.org; tony@atomide.com; Chikkature
>> Rajashekar, Madhusudhan; jarkko.lavinen@nokia.com;
>> rmk@arm.linux.org.uk; paul@pwsan.com
>> Subject: Re: [PATCH v2 3/5] OMAP4-HSMMC: Adding MMC-TWL
>> regulator changes
>>
>> On Wed, May 5, 2010 at 8:53 AM, G, Manjunath Kondaiah
>> <manjugk@ti.com> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: linux-omap-owner@vger.kernel.org
>> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> >> kishore kadiyala
>> >> Sent: Tuesday, May 04, 2010 9:32 PM
>> >> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
>> >> Cc: tony@atomide.com; Chikkature Rajashekar, Madhusudhan;
>> >> jarkko.lavinen@nokia.com; rmk@arm.linux.org.uk; paul@pwsan.com
>> >> Subject: [PATCH v2 3/5] OMAP4-HSMMC: Adding MMC-TWL
>> regulator changes
>> >>
>> >> This patch adds PBIAS Configuration during POWER ON and OFF.
>> >> Also it adds MMC1 Card detect configuration on Phoenix
>> >>
>> >> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A01=
21
>> >> ++++++++++++++++++++++++++---
>> >> =A0arch/arm/plat-omap/include/plat/control.h | =A0 17 ++++
>> >> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 42 +++++++++-
>> >> =A03 files changed, 166 insertions(+), 14 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-omap2/hsmmc.c
>> b/arch/arm/mach-omap2/hsmmc.c
>> >> index f5ca16c..a73f011 100644
>> >> --- a/arch/arm/mach-omap2/hsmmc.c
>> >> +++ b/arch/arm/mach-omap2/hsmmc.c
>> >> @@ -14,6 +14,7 @@
>> >> =A0#include <linux/string.h>
>> >> =A0#include <linux/delay.h>
>> >> =A0#include <linux/i2c/twl.h>
>> >> +#include <linux/platform_device.h>
>> >> =A0#include <mach/hardware.h>
>> >> =A0#include <plat/control.h>
>> >> =A0#include <plat/mmc.h>
>> >> @@ -25,6 +26,7 @@
>> >>
>> >> =A0static u16 control_pbias_offset;
>> >> =A0static u16 control_devconf1_offset;
>> >> +static u16 control_mmc1;
>> >>
>> >> =A0#define HSMMC_NAME_LEN =A0 =A0 =A0 9
>> >>
>> >> @@ -43,7 +45,7 @@ static int hsmmc_get_context_loss(struct
>> >> device *dev)
>> >> =A0#define hsmmc_get_context_loss NULL
>> >> =A0#endif
>> >>
>> >> -static void hsmmc1_before_set_reg(struct device *dev, int slot,
>> >> +static void omap_hsmmc1_before_set_reg(struct device
>> *dev, int slot,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
nt power_on, int vdd)
>> >> =A0{
>> >> =A0 =A0 =A0 u32 reg, prog_io;
>> >> @@ -96,7 +98,7 @@ static void hsmmc1_before_set_reg(struct
>> >> device *dev, int slot,
>> >> =A0 =A0 =A0 }
>> >> =A0}
>> >>
>> >> -static void hsmmc1_after_set_reg(struct device *dev, int slot,
>> >> +static void omap_hsmmc1_after_set_reg(struct device *dev,
>> int slot,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in=
t power_on, int vdd)
>> >> =A0{
>> >> =A0 =A0 =A0 u32 reg;
>> >> @@ -120,6 +122,61 @@ static void hsmmc1_after_set_reg(struct
>> >> device *dev, int slot,
>> >> =A0 =A0 =A0 }
>> >> =A0}
>> >>
>> >> +static void omap4_hsmmc1_before_set_reg(struct device
>> *dev, int slot,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int=
 power_on, int vdd)
>> >> +{
>> >> + =A0 =A0 u32 reg;
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Assume we power both OMAP VMMC1 (for CMD, CLK,
>> >> DAT0..3) and the
>> >> + =A0 =A0 =A0* card with Vcc regulator (from twl4030 or whatever)=
=2E
>> >> OMAP has both
>> >> + =A0 =A0 =A0* 1.8V and 3.0V modes, controlled by the PBIAS regis=
ter.
>> >> + =A0 =A0 =A0*
>> >> + =A0 =A0 =A0* In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a
>> >> supply, which
>> >> + =A0 =A0 =A0* is most naturally TWL VSIM; those pins also use PB=
IAS.
>> >> + =A0 =A0 =A0*
>> >> + =A0 =A0 =A0* FIXME handle VMMC1A as needed ...
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 if (power_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_o=
ffset);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PBIASLITE_PWRDNZ =
|
>> >> OMAP4_MMC1_PWRDNZ);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_off=
set);
>> >> + =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_o=
ffset);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PBIASLITE_PWRDNZ =
|
>> >> OMAP4_MMC1_PWRDNZ);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_off=
set);
>> >> + =A0 =A0 }
>> >> +}
>> >> +
>> >> +static void omap4_hsmmc1_after_set_reg(struct device
>> *dev, int slot,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
power_on, int vdd)
>> >> +{
>> >> + =A0 =A0 u32 reg;
>> >> +
>> >> + =A0 =A0 /* 100ms delay required for PBIAS configuration */
>> >> + =A0 =A0 msleep(100);
>> >> +
>> >> + =A0 =A0 if (power_on) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_o=
ffset);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_MMC1_PBIASLITE_PWRDNZ;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((1 << vdd) <=3D MMC_VDD_165_195) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP4_MMC1_PB=
IASLITE_VMODE;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_MMC1_PB=
IASLITE_PWRDNZ |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_MMC1_PB=
IASLITE_VMODE |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_M=
MC1_PBIASLITE_PWRDNZ |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP4_MMC1_PWRDNZ);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_off=
set);
>> >> + =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_pbias_o=
ffset);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D (OMAP4_MMC1_PBIASLITE_PWRDN=
Z |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PBIASLITE_VM=
ODE |
>> OMAP4_MMC1_PWRDNZ);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_pbias_off=
set);
>> >> + =A0 =A0 }
>> >> +}
>> >> +
>> >> =A0static void hsmmc23_before_set_reg(struct device *dev, int slo=
t,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int power_on, int vdd)
>> >> =A0{
>> >> @@ -140,6 +197,24 @@ static void
>> >> hsmmc23_before_set_reg(struct device *dev, int slot,
>> >> =A0 =A0 =A0 }
>> >> =A0}
>> >>
>> >> +static int mmc_twl_late_init(struct device *dev)
>> >> +{
>> >> + =A0 =A0 int ret =3D 0;
>> >> + =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct platform_device, dev);
>> >> +
>> >> + =A0 =A0 if (cpu_is_omap44xx()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* MMC1 Card detect Configuration */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap4_hsmmc1_ca=
rd_detect_config();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"Unable to configure"
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "Card detect for MMC1\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> + =A0 =A0 }
>> >> + =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> =A0static struct omap_mmc_platform_data
>> >> *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
>> >>
>> >> =A0void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controll=
ers)
>> >> @@ -147,13 +222,28 @@ void __init omap2_hsmmc_init(struct
>> >> omap2_hsmmc_info
>> >> =A0 =A0 =A0 struct omap2_hsmmc_info *c;
>> >> =A0 =A0 =A0 int nr_hsmmc =3D ARRAY_SIZE(hsmmc_data);
>> >> =A0 =A0 =A0 int i;
>> >> + =A0 =A0 u32 reg;
>> >>
>> >> - =A0 =A0 if (cpu_is_omap2430()) {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 control_pbias_offset =3D OMAP243X_CONTR=
OL_PBIAS_LITE;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 control_devconf1_offset =3D OMAP243X_CO=
NTROL_DEVCONF1;
>> >> + =A0 =A0 if (!cpu_is_omap44xx()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap2430()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control_pbias_offset =3D
>> >> OMAP243X_CONTROL_PBIAS_LITE;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control_devconf1_offset=
 =3D
>> >> OMAP243X_CONTROL_DEVCONF1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control_pbias_offset =3D
>> >> OMAP343X_CONTROL_PBIAS_LITE;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control_devconf1_offset=
 =3D
>> >> OMAP343X_CONTROL_DEVCONF1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 } else {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 control_pbias_offset =3D OMAP343X_CONTR=
OL_PBIAS_LITE;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 control_devconf1_offset =3D OMAP343X_CO=
NTROL_DEVCONF1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 control_pbias_offset =3D OMAP44XX_CONTR=
OL_PBIAS_LITE;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 control_mmc1 =3D OMAP44XX_CONTROL_MMC1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_ctrl_readl(control_mmc1);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_CONTROL_SDMMC1_PUSTRENG=
THGRP0 |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CONTROL_SDMMC1_PU=
STRENGTHGRP1);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_CONTROL_SDMMC1_PUSTREN=
GTHGRP2 |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CONTROL_SDMMC1_PU=
STRENGTHGRP3);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_CONTROL_SDMMC1_DR0_SPEE=
DCTRL |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CONTROL_SDMMC1_DR=
1_SPEEDCTRL |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CONTROL_SDMMC1_DR=
2_SPEEDCTRL);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(reg, control_mmc1);
>> >> =A0 =A0 =A0 }
>> >>
>> >> =A0 =A0 =A0 for (c =3D controllers; c->mmc; c++) {
>> >> @@ -186,6 +276,7 @@ void __init omap2_hsmmc_init(struct
>> >> omap2_hsmmc_info *controllers)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].wires =3D c->wires;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].internal_clock =3D !c->=
ext_clock;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->dma_mask =3D 0xffffffff;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->init =3D mmc_twl_late_init;
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->get_context_loss_count =3D hsmmc=
_get_context_loss;
>> >>
>> >> @@ -220,10 +311,18 @@ void __init omap2_hsmmc_init(struct
>> >> omap2_hsmmc_info
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (c->mmc) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-chip level shifti=
ng via
>> PBIAS0/PBIAS1 */
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].before_se=
t_reg =3D
>> >> hsmmc1_before_set_reg;
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].after_set=
_reg =3D
>> >> hsmmc1_after_set_reg;
>> >> -
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) =
{
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-c=
hip level shifting via
>> >> PBIAS0/PBIAS1 */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->sl=
ots[0].before_set_reg =3D
>> >> +
>> >> omap4_hsmmc1_before_set_reg;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->sl=
ots[0].after_set_reg =3D
>> >> +
>> >> omap4_hsmmc1_after_set_reg;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->sl=
ots[0].before_set_reg =3D
>> >> +
>> >> omap_hsmmc1_before_set_reg;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->sl=
ots[0].after_set_reg =3D
>> >> +
>> >> omap_hsmmc1_after_set_reg;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Omap3630 HSMMC1 su=
pports only 4-bit */
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap3630()=
 && c->wires > 4) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c->wi=
res =3D 4;
>> >> diff --git a/arch/arm/plat-omap/include/plat/control.h
>> >> b/arch/arm/plat-omap/include/plat/control.h
>> >> index a56deee..6d17a61 100644
>> >> --- a/arch/arm/plat-omap/include/plat/control.h
>> >> +++ b/arch/arm/plat-omap/include/plat/control.h
>> >> @@ -207,6 +207,9 @@
>> >> =A0/* 44xx control status register offset */
>> >> =A0#define OMAP44XX_CONTROL_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A00x2=
c4
>> >>
>> >> +/* 44xx-only CONTROL_GENERAL register offsets */
>> >> +#define OMAP44XX_CONTROL_MMC1 =A0 =A0 =A0 =A0 =A0 0x628
>> >> +#define OMAP44XX_CONTROL_PBIAS_LITE =A0 =A0 0x600
>> >> =A0/*
>> >> =A0 * REVISIT: This list of registers is not comprehensive -
>> >> there are more
>> >> =A0 * that should be added.
>> >> @@ -252,6 +255,20 @@
>> >> =A0#define OMAP2_PBIASLITEPWRDNZ0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 =
<< 1)
>> >> =A0#define OMAP2_PBIASLITEVMODE0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 0)
>> >>
>> >> +/* CONTROL_PBIAS_LITE bits for OMAP4 */
>> >> +#define OMAP4_MMC1_PWRDNZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 26)
>> >> +#define OMAP4_MMC1_PBIASLITE_HIZ_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 25)
>> >> +#define OMAP4_MMC1_PBIASLITE_PWRDNZ =A0 =A0 =A0 =A0 =A0(1 << 22)
>> >> +#define OMAP4_MMC1_PBIASLITE_VMODE =A0 =A0 =A0 =A0 =A0 (1 << 21)
>> >> +
>> >> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0 =A0(1 << 31)
>> >> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1 =A0(1 << 30)
>> >> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2 =A0(1 << 29)
>> >> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3 =A0(1 << 28)
>> >> +#define OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL =A0 (1 << 27)
>> >> +#define OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL =A0 (1 << 26)
>> >> +#define OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL =A0 (1 << 25)
>> >> +
>> >> =A0/* CONTROL_PROG_IO1 bits */
>> >> =A0#define OMAP3630_PRG_SDMMC1_SPEEDCTRL =A0 =A0 =A0 =A0(1 << 20)
>> >>
>> >> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>> >> index eb198db..423a355 100644
>> >> --- a/include/linux/i2c/twl.h
>> >> +++ b/include/linux/i2c/twl.h
>> >> @@ -142,6 +142,13 @@
>> >> =A0#define TWL6030_CHARGER_FAULT_INT_MASK =A0 =A0 =A0 0x60
>> >>
>> >> =A0#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00xEE
>> >> +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1 << 3)
>> >> +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1 << 2)
>> >> +
>> >> +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A0 =A0 =A0 =A00xF2
>> >> +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (0x1 << 3)
>> >> +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (0x1 << 2)
>> >> +
>> >>
>> >> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 0x4030
>> >> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 0x6030
>> >> @@ -174,11 +181,40 @@ int twl_i2c_read(u8 mod_no, u8 *value,
>> >> u8 reg, unsigned
>> >> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> >> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>> >>
>> >> -/*
>> >> - * MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect.
>> >> - */
>> >> +/* MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect */
>> >> =A0int twl6030_mmc_card_detect(struct device *dev, int slot);
>> >>
>> >> +/* Configuring Card Detect for MMC1 */
>> >> +static inline int omap4_hsmmc1_card_detect_config(void)
>> >> +{
>> >> + =A0 =A0 int res =3D -1;
>> >> + =A0 =A0 u8 reg_val =3D 0;
>> >> +
>> >> + =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1
>> >> from Phoenix */
>> >> + =A0 =A0 if (twl_class_is_6030()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDET=
ECT_INT_MASK,
>> >> +
>> >> REG_INT_MSK_LINE_B);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDET=
ECT_INT_MASK,
>> >> +
>> >> REG_INT_MSK_STS_B);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interru=
pts &
>> >> + =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 reg_val |=3D (SW_FC & ~VMMC_AUTO_OFF);
>> >> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>> TWL6030_MMCCTRL);
>> >> + =A0 =A0 res =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> >> +
>> >> TWL6030_CFG_INPUT_PUPD3);
>> >> + =A0 =A0 if (res < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >
>> > Use return res; since "twl_i2c_read_u8" will be handling
>> all types of
>> > Errors.
>>
>> Agree
>>
>> >
>> >> + =A0 =A0 reg_val =3D 0;
>> >> + =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
>> >
>> >
>> >> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>> >> +
>> >> TWL6030_CFG_INPUT_PUPD3);
>> >
>> > reg_val is always zero.
>> > You can replace with "twl_i2c_write_u8(TWL6030_MODULE_ID0, 0,
>> > TWL6030_CFG_INPUT_PUPD3);
>>
>> I think should read the value first using "twl_i2c_read_u8"
>> and set/reset bits
>> accordingly.
>
> Then it is bug in your code. Remove "reg_val =3D 0;"

Will take care !

>
> -Manjunath
