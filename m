From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Tue, 28 Sep 2010 14:31:37 +0900
Message-ID: <AANLkTi=McbCvo3cLNHk=upKWO4RM+4fM=_qX1b3Ya12c@mail.gmail.com>
References: <4C7CDA39.1020907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41694 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab0I1Fbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 01:31:39 -0400
Received: by wyb28 with SMTP id 28so4620223wyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2010 22:31:38 -0700 (PDT)
In-Reply-To: <4C7CDA39.1020907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, matt@console-pimps.org, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>

To Ben,

Maybe you missing this patch. It's the jaehoon's approach.

Thank you,
Kyungmin Park

2010/8/31 Jaehoon Chung <jh80.chung@samsung.com>:
> This is sdhci-s3c patch for c210.
> c210 didn't use divider of host controller.
>
> Host Controller need other clock setting methods.
>
> So I add the callback functions for s5pc210.
> also I set 400KHz for initial clock.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 19 ++++++++
> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 68 =
++++++++++++++++++++++++++++
> =A02 files changed, 87 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pl=
at-samsung/include/plat/sdhci.h
> index 30844c2..7c75ee3 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -15,6 +15,8 @@
> =A0#ifndef __PLAT_S3C_SDHCI_H
> =A0#define __PLAT_S3C_SDHCI_H __FILE__
>
> +#include <plat/devs.h>
> +
> =A0struct platform_device;
> =A0struct mmc_host;
> =A0struct mmc_card;
> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(void) =
{ }
>
> =A0#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>
> +/* re-define device name depending on support. */
> +static inline void s3c_hsmmc_setname(char *name)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> + =A0 =A0 =A0 s3c_device_hsmmc0.name =3D name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> + =A0 =A0 =A0 s3c_device_hsmmc1.name =3D name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC2
> + =A0 =A0 =A0 s3c_device_hsmmc2.name =3D name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC3
> + =A0 =A0 =A0 s3c_device_hsmmc3.name =3D name;
> +#endif
> +}
> +
> =A0#endif /* __PLAT_S3C_SDHCI_H */
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 71ad416..3927793 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -52,6 +52,11 @@ struct sdhci_s3c {
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk_bus[MAX_BUS=
_CLK];
> =A0};
>
> +enum soc_type {
> + =A0 =A0 =A0 TYPE_SAMSUNG, =A0 /* S5PC1XX, S3C... */
> + =A0 =A0 =A0 TYPE_S5PC210, =A0 /* S5PC210 */
> +};
> +
> =A0static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0return sdhci_priv(host);
> @@ -232,6 +237,52 @@ static unsigned int sdhci_s3c_get_min_clock(stru=
ct sdhci_host *host)
> =A0 =A0 =A0 =A0return min;
> =A0}
>
> +/**
> +* sdhci_s3c_get_max_clk - callback to get maximum clock frequency.
> +*/
> +static unsigned int sdhci_s5pc210_get_max_clock(struct sdhci_host *h=
ost)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 unsigned int rate;
> + =A0 =A0 =A0 int ptr =3D ourhost->cur_clk;
> +
> + =A0 =A0 =A0 rate =3D clk_round_rate(ourhost->clk_bus[ptr], UINT_MAX=
);
> +
> + =A0 =A0 =A0 return rate;
> +}
> +
> +/**
> + * sdhci_s3c_get_min_clock - callback to get minimal supported clock=
 value
> +*/
> +static unsigned int sdhci_s5pc210_get_min_clock(struct sdhci_host *h=
ost)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 unsigned int rate;
> + =A0 =A0 =A0 int ptr =3D ourhost->cur_clk;
> +
> + =A0 =A0 =A0 rate =3D clk_round_rate(ourhost->clk_bus[ptr], 400000);
> +
> + =A0 =A0 =A0 return rate;
> +}
> +
> +/**
> + * sdhci_s5pc210_set_clock - callback on clock change
> +*/
> +static void sdhci_s5pc210_set_clock(struct sdhci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int clock)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> +
> + =A0 =A0 =A0 if (clock =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 sdhci_s3c_set_clock(host, clock);
> +
> + =A0 =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock)=
;
> +
> + =A0 =A0 =A0 host->clock =3D clock;
> +}
> +
> =A0static struct sdhci_ops sdhci_s3c_ops =3D {
> =A0 =A0 =A0 =A0.get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_get_ma=
x_clk,
> =A0 =A0 =A0 =A0.set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_se=
t_clock,
> @@ -395,6 +446,12 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0host->quirks =3D 0;
> =A0 =A0 =A0 =A0host->irq =3D irq;
>
> + =A0 =A0 =A0 if (pdev->id_entry->driver_data =3D=3D TYPE_S5PC210) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.set_clock =3D sdhci_s5pc2=
10_set_clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_min_clock =3D sdhci_s=
5pc210_get_min_clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_max_clock =3D sdhci_s=
5pc210_get_max_clock;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Setup quirks for the controller */
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
> @@ -520,6 +577,16 @@ static int sdhci_s3c_resume(struct platform_devi=
ce *dev)
> =A0#define sdhci_s3c_resume NULL
> =A0#endif
>
> +static struct platform_device_id sdhci_driver_ids[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s3c-sdhc=
i",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D TYPE_SAMSUNG,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5pc210-=
sdhci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D TYPE_S5PC210,
> + =A0 =A0 =A0 }, { },
> +};
> +
> =A0static struct platform_driver sdhci_s3c_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_s3c_remo=
ve),
> @@ -529,6 +596,7 @@ static struct platform_driver sdhci_s3c_driver =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "s3c-sdhci",
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D sdhci_driver_ids,
> =A0};
>
> =A0static int __init sdhci_s3c_init(void)
> -- 1.6.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
