From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 3/3] omap3/omap4 hsmmc: Register offset handling
Date: Wed, 1 Sep 2010 19:04:35 +0530
Message-ID: <AANLkTinC2aaKJmyVyfi_pEGswxY2L6MFdm2VCv0dfwyh@mail.gmail.com>
References: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>
	<4C7E4680.1060208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55400 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab0IANef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 09:34:35 -0400
In-Reply-To: <4C7E4680.1060208@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "madhu.cr@ti.com" <madhu.cr@ti.com>

On Wed, Sep 1, 2010 at 5:56 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> kishore kadiyala wrote:
>>
>> OMAP4 not only have newly added hsmmc registers but also
>> have registers which were there in OMAP3 and which doesn't
>> have a common offset deviation compared to OMAP3.
>>
>> For generic handling, OMAP3 and OMAP4 has different array's of
>> register offset maintained and right one is choosen during run time.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0 30 +++--
>> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +
>> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 78 ++++++++++-
>> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0251
>> +++++++++++++++------------------
>> =A04 files changed, 218 insertions(+), 147 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index 2dbb265..03add6e 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -506,6 +506,8 @@ static inline void omap_init_sham(void) { }
>> =A0#define MMCHS_SYSCONFIG_SWRESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1=
 << 1)
>> =A0#define MMCHS_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x0014
>> =A0#define MMCHS_SYSSTATUS_RESETDONE =A0 =A0 =A0(1 << 0)
>> +#define OMAP4_MMCHS_SYSCONFIG_SWRESET =A0(1 << 0)
>> +#define OMAP4_MMCHS_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 0x100
>>
>> =A0static struct platform_device dummy_pdev =3D {
>> =A0 =A0 =A0 =A0.dev =3D {
>> @@ -528,6 +530,8 @@ static struct platform_device dummy_pdev =3D {
>> =A0static void __init omap_hsmmc_reset(void)
>> =A0{
>> =A0 =A0 =A0 =A0u32 i, nr_controllers;
>> + =A0 =A0 =A0 u32 reg_val =3D 0;
>> + =A0 =A0 =A0 u32 reg_off =3D 0;
>>
>> =A0 =A0 =A0 =A0if (cpu_is_omap242x())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> @@ -562,9 +566,6 @@ static void __init omap_hsmmc_reset(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D OMAP4_MMC_RE=
G_OFFSET;
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dummy_pdev.id =3D i;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_set_name(&dummy_pdev.dev, "mmci-o=
map-hs.%d", i);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D clk_get(dev, "ick");
>> @@ -582,9 +583,18 @@ static void __init omap_hsmmc_reset(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(MMCHS_SYSCONFIG_SWRESET, b=
ase +
>> MMCHS_SYSCONFIG);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D omap_readl(base + MMCHS_SYSSTATU=
S);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(base + MMCHS_SYSST=
ATUS) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D MMCHS_SYSC=
ONFIG_SWRESET;
>
> Should this be OMAP4_MMCHS_SYSCONFIG_SWRESET?

Yes, it should be as mentioned [Late night post's take's away quality :=
) ] ,
will correct it and repost .

<snip>

Thanks,
Kishore
