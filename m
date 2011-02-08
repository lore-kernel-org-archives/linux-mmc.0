From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v2 5/5] OMAP: devices: Modify HSMMC device to adapt to
 hwmod framework
Date: Wed, 9 Feb 2011 04:04:12 +0430
Message-ID: <AANLkTimWXJ3oAHm_kht9k02WKF9GDkOnHLRVccXo-_Ok@mail.gmail.com>
References: <1297198431-23779-1-git-send-email-kishore.kadiyala@ti.com> <1297198431-23779-6-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53209 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753306Ab1BHXl6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Feb 2011 18:41:58 -0500
In-Reply-To: <1297198431-23779-6-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com

Kishore,

On Wed, Feb 9, 2011 at 01:23, Kishore Kadiyala <kishore.kadiyala@ti.com=
> wrote:
> Changes involves:
> 1) Remove controller reset in devices.c which is taken care
> =A0 by hwmod framework.
> 2) Removing all base address macro defines.
> 3) Using omap-device layer to register device and utilizing data from
> =A0 hwmod data file for base address, dma channel number, Irq_number,
> =A0 device attribute.
> 4) Update the driver to use dev_attr to find whether controller
> =A0 supports dual volt cards.
> 5) Moving "omap_mmc_add" api from plat-omap/devices.c to mach-omap1/d=
evices.c
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
> =A0arch/arm/mach-omap1/devices.c =A0 =A0 =A0 =A0 | =A0 41 +++++++
> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0| =A0 =A06 +-
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 | =A0207 +++++++----=
----------------------
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +-
> =A0arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0| =A0 50 --------
> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 36 ++-----
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0 =A04 +-
> =A07 files changed, 100 insertions(+), 250 deletions(-)
>

<<snip>>

> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index e0f0ef9..80e46b3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -610,112 +610,6 @@ static inline void omap_init_aes(void) { }
>
> =A0/*----------------------------------------------------------------=
---------*/
>
<<snip>>

>
> @@ -828,66 +722,54 @@ static inline void omap2_mmc_mux(struct omap_mm=
c_platform_data *mmc_controller,
> =A0 =A0 =A0 =A0}
> =A0}
>
> -void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int nr_controllers)
> +struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC];
> +EXPORT_SYMBOL(hsmmc_data);
> +
> +static struct omap_device_pm_latency omap_hsmmc_latency[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enab=
le_hwmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =3D OMAP_DEV=
ICE_LATENCY_AUTO_ADJUST,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* XXX There should also be an entry here to power of=
f/on the
> + =A0 =A0 =A0 =A0* MMC regulators/PBIAS cells, etc.
> + =A0 =A0 =A0 =A0*/
> +};
> +
> +int omap2_init_mmc(struct omap_hwmod *oh, void *nop)
> =A0{
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct omap_device *od;
> + =A0 =A0 =A0 struct omap_device_pm_latency *ohl;
> =A0 =A0 =A0 =A0char *name;
> + =A0 =A0 =A0 int ohl_cnt =3D 0;
> + =A0 =A0 =A0 static int mmc_num;
>
> - =A0 =A0 =A0 for (i =3D 0; i < nr_controllers; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base, size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int irq =3D 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_data[i])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mmc_mux(mmc_data[i], i);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (i) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC1_BAS=
E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC_IR=
Q;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_MMC2_BAS=
E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_24XX_MMC2_I=
RQ;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx() =
&& !cpu_is_omap34xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_MMC3_BAS=
E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D INT_34XX_MMC3_I=
RQ;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC4_BAS=
E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MM=
C4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_MMC5_BAS=
E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D OMAP44XX_IRQ_MM=
C5;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!hsmmc_data[mmc_num]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_num++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (cpu_is_omap2420()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap";
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohl =3D omap_hsmmc_latency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohl_cnt =3D ARRAY_SIZE(omap_hsmmc_laten=
cy);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap2420()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP2420_MMC_S=
IZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < 3)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq +=3D=
 OMAP44XX_IRQ_GIC_START;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP4_HSMMC_SI=
ZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs"=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D OMAP3_HSMMC_SI=
ZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D "mmci-omap-hs"=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mmc_add(name, i, base, size, irq, =
mmc_data[i]);
> - =A0 =A0 =A0 };
> + =A0 =A0 =A0 hsmmc_data[mmc_num]->dev_attr =3D oh->dev_attr;

Copy the data from oh->dev_attr instead of relying on oh pointer
(don't rely on internals of hwmod data structures in the driver).

> + =A0 =A0 =A0 omap2_mmc_mux(hsmmc_data[mmc_num], mmc_num);
> + =A0 =A0 =A0 od =3D omap_device_build(name, mmc_num, oh, hsmmc_data[=
mmc_num],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct omap_mmc_platform_data), =
ohl, ohl_cnt, false);
> + =A0 =A0 =A0 WARN(IS_ERR(od), "Could not build omap_device for %s %s=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, oh->name);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* return device handle to board setup code
> + =A0 =A0 =A0 =A0* required to populate for regulator framework struc=
ture
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 hsmmc_data[mmc_num]->dev =3D &od->pdev.dev;

If od is incorrect, do a WARN() and return error. Don't access od
in case of a failure.

> + =A0 =A0 =A0 mmc_num++;
> + =A0 =A0 =A0 return 0;
> =A0}
>

<<snip>>

> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-om=
ap/include/plat/mmc.h
> index 7821344..08b7503 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -16,6 +16,7 @@
> =A0#include <linux/mmc/host.h>
>
> =A0#include <plat/board.h>
> +#include <plat/omap_hwmod.h>
>
> =A0#define OMAP15XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> =A0#define OMAP16XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> @@ -23,23 +24,8 @@
> =A0#define OMAP1_MMC1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xfffb7800
> =A0#define OMAP1_MMC2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xfffb7c00 =
=A0 =A0 =A0/* omap16xx only */

These need not be part of plat/mmc.h and
can be moved to mach-omap1/*

>
> -#define OMAP24XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> -#define OMAP34XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> =A0#define OMAP44XX_NR_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05

Shouldn't OMAP44XX_NR_MMC  should also be
removed? I think this info should be populated
dynamically during omap_hwmod_for_each_by_class().

> -#define OMAP2420_MMC_SIZE =A0 =A0 =A0OMAP1_MMC_SIZE
> -#define OMAP3_HSMMC_SIZE =A0 =A0 =A0 0x200
> -#define OMAP4_HSMMC_SIZE =A0 =A0 =A0 0x1000
> -#define OMAP2_MMC1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4809c000
> -#define OMAP2_MMC2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480b4000
> -#define OMAP3_MMC3_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480ad000
> -#define OMAP4_MMC4_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480d1000
> -#define OMAP4_MMC5_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x480d5000
> =A0#define OMAP4_MMC_REG_OFFSET =A0 0x100
> -#define HSMMC5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> -#define HSMMC4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
> -#define HSMMC3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2)
> -#define HSMMC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
> -#define HSMMC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
>
> =A0#define OMAP_MMC_MAX_SLOTS =A0 =A0 2
>
> @@ -78,6 +64,9 @@ struct omap_mmc_platform_data {
>
> =A0 =A0 =A0 =A0u64 dma_mask;
>
> + =A0 =A0 =A0 /* Integrating attributes from the omap_hwmod layer */
> + =A0 =A0 =A0 struct mmc_dev_attr *dev_attr;
> +
> =A0 =A0 =A0 =A0/* Register offset deviation */
> =A0 =A0 =A0 =A0u16 reg_offset;
>
> @@ -164,25 +153,18 @@ extern void omap_mmc_notify_cover_event(struct =
device *dev, int slot,
>
> =A0#if =A0 =A0defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MOD=
ULE) || \
> =A0 =A0 =A0 =A0defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP=
_HS_MODULE)
> +
> +extern struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC];

Same again. OMAP44XX_NR_MMC shall be removed and
instead be populated dynamically.

> +
> =A0void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int nr=
_controllers);

<<snip>>
