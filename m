From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device powered
	off
Date: Fri, 23 Jul 2010 02:18:08 +0300
Message-ID: <AANLkTim3RWv2-qi9UMg1imwKTJuh3GstdjMTxz64uOHf@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-20-git-send-email-ohad@wizery.com> <676FD6AA0F002F49B89E70F0C5EFD22C1311192A47@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <676FD6AA0F002F49B89E70F0C5EFD22C1311192A47@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Gabay, Benzy" <benzyg@ti.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>, Roger Quadros <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@fluxnic.net>, "Pandita, Vikram" <vikram.pandita@ti.com>, Kalle Valo <kalle.valo@iki.fi>
List-Id: linux-mmc@vger.kernel.org

Hi Gever,

On Wed, Jul 21, 2010 at 9:55 PM, Gabay, Benzy <benzyg@ti.com> wrote:
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Wednesday, July 21, 2010 12:34 PM
> To: linux-wireless@vger.kernel.org; linux-mmc@vger.kernel.org; linux-=
omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux@arm.linux.org.uk; Chi=
kkature Rajashekar, Madhusudhan; Luciano Coelho; akpm@linux-foundation.=
org; San Mehat; Roger Quadros; Tony Lindgren; Nicolas Pitre; Pandita, V=
ikram; Kalle Valo; Ohad Ben-Cohen
> Subject: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device pow=
ered off
>
> Keep the MMC3 wl1271 WLAN device powered off until its
> SDIO function driver requests otherwise.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A01 +
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +++
> =A0arch/arm/mach-omap2/hsmmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0 =A0| =A0 =A03 ++=
+
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +++
> =A05 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/=
mach-omap2/board-zoom-peripherals.c
> index 3230801..3ab9125 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -217,6 +217,7 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =3D MMC_VDD_165_=
195,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dont_power_card =3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.priv_data =A0 =A0 =A0=3D &omap_zoom_w=
lan_data,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
=2E..
> --
> 1.7.0.4
>
> [Benzy Gabay] small comment: Please make sure that all 127x related c=
hanges are not bounded only to MMC3.
> On OMAP4 WLAN is used on MMC5.


The only place MMC3 is bound is in the board files (see code snippet
above), so that should be ok.

I can probably split this patch to make this more obvious just by
reading the diffstat if you prefer.


Thanks,
Ohad.


>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
