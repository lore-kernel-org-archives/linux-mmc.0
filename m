From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 2/7] OMAP4-HSMMC: Adding HSMMC support for OMAP4430 Board
	file
Date: Tue, 4 May 2010 11:31:11 +0530
Message-ID: <k2q7f9d1ffb1005032301ob6071114j363af2a67fa1b157@mail.gmail.com>
References: <63411.10.24.255.18.1271873995.squirrel@dbdmail.itg.ti.com>
	 <20100421184751.GG18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49655 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0EDGBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 02:01:12 -0400
In-Reply-To: <20100421184751.GG18272@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

On Thu, Apr 22, 2010 at 12:17 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:15]:
>> This patch adds MMC1 and MMC2 Controller support for OMAP4430 Board
>> file.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0| =A0 =A03 +-
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 39 ++++++++++++++++++++=
+++++++-------
>> =A02 files changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 4b9fc57..40b291a 100644
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
>> index 32cbd72..eae7c80 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -33,6 +33,7 @@
>> =A0#include <plat/usb.h>
>> =A0#include <asm/hardware/gic.h>
>> =A0#include <asm/hardware/cache-l2x0.h>
>> +#include "hsmmc.h"
>>
>> =A0static struct platform_device sdp4430_lcd_device =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sdp4430_lcd",
>> @@ -80,17 +81,27 @@ static int __init omap_l2_cache_init(void)
>> =A0early_initcall(omap_l2_cache_init);
>> =A0#endif
>>
>> -
>> -static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
>> - =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> - =A0 =A0 },
>> +static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "vmmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* "mmc0_cd" is not a gpio interrupt
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* but is a phoenix interrupt
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D 384,
>
> You can't use hardcoded irq numbers for twl interrupts. They can chan=
ge.
> See sdp3430_twl_gpio_setup() for example.

I am working  on it and will avoid hard coding .

Regards,
Kishore
