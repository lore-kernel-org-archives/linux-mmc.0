From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and initialization
Date: Wed, 18 Apr 2012 20:53:32 +0530
Message-ID: <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
	<E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34537 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752179Ab2DRPXg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 11:23:36 -0400
Received: by laap9 with SMTP id p9so5425786laa.10
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 08:23:32 -0700 (PDT)
In-Reply-To: <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Apr 18, 2012 at 3:42 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> DMAengine uses the DMA engine device structure when mapping/unmapping
> memory for DMA, so the MMC devices do not need their DMA masks
> initialized (this reflects hardware: the MMC device is not the device
> doing DMA.)
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/mach-omap1/board-h2-mmc.c =A0 =A0| =A0 =A01 -
> =A0arch/arm/mach-omap1/board-h3-mmc.c =A0 =A0| =A0 =A01 -
> =A0arch/arm/mach-omap1/board-nokia770.c =A0| =A0 =A01 -
> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0| =A0 =A01 -
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A02 --
Hi,

drivers/mmc/host/omap.c is also using dma_mask should that also be remo=
ved

> =A06 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1=
/board-h2-mmc.c
> index da0e37d..e1362ce 100644
> --- a/arch/arm/mach-omap1/board-h2-mmc.c
> +++ b/arch/arm/mach-omap1/board-h2-mmc.c
> @@ -54,7 +54,6 @@ static struct omap_mmc_platform_data mmc1_data =3D =
{
> =A0 =A0 =A0 =A0.nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1,
> =A0 =A0 =A0 =A0.init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =3D mmc_late_init,
> =A0 =A0 =A0 =A0.cleanup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D mmc_cleanup,
> - =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0xffffffff,
> =A0 =A0 =A0 =A0.slots[0] =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_power =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D mmc_set_power,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D MMC_VDD_32_33 | MMC_VDD_33_34,
> diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1=
/board-h3-mmc.c
> index f8242aa..c74daac 100644
> --- a/arch/arm/mach-omap1/board-h3-mmc.c
> +++ b/arch/arm/mach-omap1/board-h3-mmc.c
> @@ -36,7 +36,6 @@ static int mmc_set_power(struct device *dev, int sl=
ot, int power_on,
> =A0*/
> =A0static struct omap_mmc_platform_data mmc1_data =3D {
> =A0 =A0 =A0 =A0.nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1,
> - =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0xffffffff,
> =A0 =A0 =A0 =A0.slots[0] =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_power =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D mmc_set_power,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D MMC_VDD_32_33 | MMC_VDD_33_34,
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-oma=
p1/board-nokia770.c
> index d21dcc2..cac9954 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -185,7 +185,6 @@ static int nokia770_mmc_get_cover_state(struct de=
vice *dev, int slot)
>
> =A0static struct omap_mmc_platform_data nokia770_mmc2_data =3D {
> =A0 =A0 =A0 =A0.nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1,
> - =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0xffffffff,
> =A0 =A0 =A0 =A0.max_freq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 12000000,
> =A0 =A0 =A0 =A0.slots[0] =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_power =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D nokia770_mmc_set_power,
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/b=
oard-n8x0.c
> index 518091c..1003748 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -470,7 +470,6 @@ static struct omap_mmc_platform_data mmc1_data =3D=
 {
> =A0 =A0 =A0 =A0.cleanup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D n8x0_mmc_cleanup,
> =A0 =A0 =A0 =A0.shutdown =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D n8x0_mmc_shutdown,
> =A0 =A0 =A0 =A0.max_freq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 24000000,
> - =A0 =A0 =A0 .dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0xffffffff,
> =A0 =A0 =A0 =A0.slots[0] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_power =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D n8x0_mmc_set_power,
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index b0268ea..41e5277 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -315,7 +315,6 @@ static int __init omap_hsmmc_pdata_init(struct om=
ap2_hsmmc_info *c,
> =A0 =A0 =A0 =A0mmc->slots[0].caps =3D c->caps;
> =A0 =A0 =A0 =A0mmc->slots[0].pm_caps =3D c->pm_caps;
> =A0 =A0 =A0 =A0mmc->slots[0].internal_clock =3D !c->ext_clock;
> - =A0 =A0 =A0 mmc->dma_mask =3D 0xffffffff;
> =A0 =A0 =A0 =A0mmc->max_freq =3D c->max_freq;
> =A0 =A0 =A0 =A0if (cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->reg_offset =3D OMAP4_MMC_REG_OFFS=
ET;
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-om=
ap/include/plat/mmc.h
> index 7a38750..9fe87a7 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -80,8 +80,6 @@ struct omap_mmc_platform_data {
> =A0 =A0 =A0 =A0/* Return context loss count due to PM states changing=
 */
> =A0 =A0 =A0 =A0int (*get_context_loss_count)(struct device *dev);
>
> - =A0 =A0 =A0 u64 dma_mask;
> -
> =A0 =A0 =A0 =A0/* Integrating attributes from the omap_hwmod layer */
> =A0 =A0 =A0 =A0u8 controller_flags;
>
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
