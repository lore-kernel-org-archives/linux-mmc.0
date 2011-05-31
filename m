From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: MMC: no regulator off during probe for eMMC
Date: Tue, 31 May 2011 20:11:48 +0530
Message-ID: <BANLkTiks92tGJfaTVW2b7DTmU0SuQpbZ4g@mail.gmail.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com> <1306765534-20103-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36581 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab1EaOmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 10:42:09 -0400
In-Reply-To: <1306765534-20103-3-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

On Mon, May 30, 2011 at 7:55 PM, Balaji T K <balajitk@ti.com> wrote:
> eMMC does not handle power off when not in sleep state,
> Skip regulator disable during probe when eMMC is
> not in known state - state left by bootloader.
>
> Resolves eMMC failure on OMAP4
> mmc0: error -110 whilst initialising MMC card
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Tested-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>

> ---
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0arch/arm/mach-omap2/hsmmc.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A03 +++
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A05 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 73fa90b..b324605 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -322,6 +322,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.nonremovable =A0 =3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =3D MMC_VDD_29_3=
0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .no_off_init =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index 3f8dc16..28ca144 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -338,6 +338,9 @@ static int __init omap_hsmmc_pdata_init(struct om=
ap2_hsmmc_info *c,
> =A0 =A0 =A0 =A0if (c->no_off)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->slots[0].no_off =3D 1;
>
> + =A0 =A0 =A0 if (c->no_off_init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->slots[0].no_regulator_off_init =3D=
 c->no_off_init;
> +
> =A0 =A0 =A0 =A0if (c->vcc_aux_disable_is_sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->slots[0].vcc_aux_disable_is_sleep=
 =3D 1;
>
> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.=
h
> index f119348..f757e78 100644
> --- a/arch/arm/mach-omap2/hsmmc.h
> +++ b/arch/arm/mach-omap2/hsmmc.h
> @@ -18,6 +18,7 @@ struct omap2_hsmmc_info {
> =A0 =A0 =A0 =A0bool =A0 =A0nonremovable; =A0 /* Nonremovable e.g. eMM=
C */
> =A0 =A0 =A0 =A0bool =A0 =A0power_saving; =A0 /* Try to sleep or power=
 off when possible */
> =A0 =A0 =A0 =A0bool =A0 =A0no_off; =A0 =A0 =A0 =A0 /* power_saving an=
d power is not to go off */
> + =A0 =A0 =A0 bool =A0 =A0no_off_init; =A0 =A0/* no power off when no=
t in MMC sleep state */
> =A0 =A0 =A0 =A0bool =A0 =A0vcc_aux_disable_is_sleep; /* Regulator off=
 remapped to sleep */
> =A0 =A0 =A0 =A0int =A0 =A0 gpio_cd; =A0 =A0 =A0 =A0/* or -EINVAL */
> =A0 =A0 =A0 =A0int =A0 =A0 gpio_wp; =A0 =A0 =A0 =A0/* or -EINVAL */
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-om=
ap/include/plat/mmc.h
> index f38fef9..c7b8741 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -101,6 +101,9 @@ struct omap_mmc_platform_data {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* If using power_saving and the MMC p=
ower is not to go off */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned no_off:1;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eMMC does not handle power off when =
not in sleep state */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned no_regulator_off_init:1;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Regulator off remapped to sleep */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned vcc_aux_disable_is_sleep:1;
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 259ece0..5b2e215 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -435,6 +435,9 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_h=
ost *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D regulator_get(host->dev, "vmmc=
_aux");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->vcc_aux =3D IS_ERR(reg) ? NULL :=
 reg;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* For eMMC do not power off when not i=
n sleep state */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_slot(host).no_regulator_off_ini=
t)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* UGLY HACK: =A0workaround regulator f=
ramework bugs.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* When the bootloader leaves a supply =
active, it's
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
