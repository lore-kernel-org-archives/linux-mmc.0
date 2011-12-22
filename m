From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Fri, 23 Dec 2011 01:07:55 +0530
Message-ID: <CAF=Qhp3UjugPL8eDzbJ9=-Yw0gxxpCFw7p13GS5LQEWrzHxLfQ@mail.gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44732 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab1LVTiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2011 14:38:16 -0500
In-Reply-To: <1323868927-3738-1-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
> External circuitry like level shifters may limit the maximum operatio=
n
> speed of the hsmmc controller. Add a field to struct omap2_hsmmc_info
> so boards can adjust the setting on demand.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/hsmmc.c =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/hsmmc.h =A0 | =A0 =A02 ++
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A08 ++++++--
> =A03 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index f4a1020..4c7bc36 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -298,6 +298,7 @@ static int __init omap_hsmmc_pdata_init(struct om=
ap2_hsmmc_info *c,
> =A0 =A0 =A0 =A0mmc->slots[0].caps =3D c->caps;
> =A0 =A0 =A0 =A0mmc->slots[0].internal_clock =3D !c->ext_clock;
> =A0 =A0 =A0 =A0mmc->dma_mask =3D 0xffffffff;
> + =A0 =A0 =A0 mmc->max_freq =3D c->max_freq;
> =A0 =A0 =A0 =A0if (cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->reg_offset =3D OMAP4_MMC_REG_OFFS=
ET;
> =A0 =A0 =A0 =A0else
> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.=
h
> index f757e78..65a8c12 100644
> --- a/arch/arm/mach-omap2/hsmmc.h
> +++ b/arch/arm/mach-omap2/hsmmc.h
> @@ -25,6 +25,8 @@ struct omap2_hsmmc_info {
> =A0 =A0 =A0 =A0char =A0 =A0*name; =A0 =A0 =A0 =A0 =A0/* or NULL for d=
efault */
> =A0 =A0 =A0 =A0struct device *dev; =A0 =A0 /* returned: pointer to mm=
c adapter */
> =A0 =A0 =A0 =A0int =A0 =A0 ocr_mask; =A0 =A0 =A0 /* temporary HACK */
> + =A0 =A0 =A0 int =A0 =A0 max_freq; =A0 =A0 =A0 /* maximum clock, if =
constrained by external
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ci=
rcuitry, or 0 for default */
> =A0 =A0 =A0 =A0/* Remux (pad configuration) when powering on/off */
> =A0 =A0 =A0 =A0void (*remux)(struct device *dev, int slot, int power_=
on);
> =A0 =A0 =A0 =A0/* init some special card */
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 101cd31..8215ef9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (mmc_slot(host).vcc_aux_disable_is_sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).no_off =3D 1;
>
> - =A0 =A0 =A0 mmc->f_min =A0 =A0 =A0=3D OMAP_MMC_MIN_CLOCK;
> - =A0 =A0 =A0 mmc->f_max =A0 =A0 =A0=3D OMAP_MMC_MAX_CLOCK;
> + =A0 =A0 =A0 mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
> +
> + =A0 =A0 =A0 if (pdata->max_freq > 0)

What about having check as below:
if (pdata->max_freq > 0 && pdata->max_freq < OMAP_MMC_MAX_CLOCK)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_max =3D pdata->max_freq;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_max =3D OMAP_MMC_MAX_CLOCK;
>
> =A0 =A0 =A0 =A0spin_lock_init(&host->irq_lock);
>
> --
> 1.7.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
