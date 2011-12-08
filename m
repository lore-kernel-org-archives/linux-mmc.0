From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
Date: Thu, 8 Dec 2011 14:33:10 -0800
Message-ID: <CAGDS+nnm_+9975aX9h7U7EUf6UDWiiqO8+yfG_zW1sCxhgrzQw@mail.gmail.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dave Hylands <dhylands@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 6, 2011 at 1:56 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The HSMMC1/HSMMC2 host controllers on OMAP34xx and
> OMAP3503/3515/3525/3530 chips at ES levels prior to 3.0 can't do mult=
iple
> block reads[1]. =A0Mark the hwmod data appropriately.
>
> Reported by Dave Hylands <dhylands@gmail.com> and Steve Sakoman
> <sakoman@gmail.com>.
>
> 1. See for example Advisory 2.1.1.128 "MMC: Multiple Block Read
> =A0 Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
> =A0 Revision F (October 2010) (SPRZ278F), available from
> =A0 http://focus.ti.com/lit/er/sprz278f/sprz278f.pdf
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>
> ---
>
> This patch has a dependency on the "MMC: disable multiblock reads on
> controllers that don't support them" series recently posted to
> the linux-mmc list, so the application of this patch will probably be
> delayed until the 3.3 merge window.

Since the above patch is now in mainline
(2bf22b39823c1d173dda31111a4eb2ce36daaf39) this patch can go in.

Without it 35XXES2.1 systems have broken mmc.   Too late as a bug fix f=
or 3.2?

Steve



> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 90 ++++++++++++++=
++++++++++++-
> =A01 files changed, 86 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index 53b6706..a14d150 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3020,7 +3020,35 @@ static struct omap_mmc_dev_attr mmc1_dev_attr =
=3D {
> =A0 =A0 =A0 =A0.flags =3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> =A0};
>
> -static struct omap_hwmod omap3xxx_mmc1_hwmod =3D {
> +/* See 35xx errata 2.1.1.128 in SPRZ278F */
> +static struct omap_mmc_dev_attr mmc1_pre_es3_dev_attr =3D {
> + =A0 =A0 =A0 .flags =3D (OMAP_HSMMC_SUPPORTS_DUAL_VOLT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_BROKEN_MULTIBLOCK_READ),
> +};
> +
> +static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc1",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_mmc1_mpu_irqs,
> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap34xx_mmc1_sdma_reqs,
> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap34xx_mmc1_opt_clks,
> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap34xx_mmc1_opt_clks=
),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs1_fck",
> + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_M=
OD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP343=
0_EN_MMC1_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OM=
AP3430_ST_MMC1_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &mmc1_pre_es3_dev_attr,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_mmc1_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_mmc1_slaves=
),
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_mmc_class,
> +};
> +
> +static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc1",
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap34xx_mmc1_mpu_irqs,
> =A0 =A0 =A0 =A0.sdma_reqs =A0 =A0 =A0=3D omap34xx_mmc1_sdma_reqs,
> @@ -3063,7 +3091,34 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc2=
_slaves[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_l4_core__mmc2,
> =A0};
>
> -static struct omap_hwmod omap3xxx_mmc2_hwmod =3D {
> +/* See 35xx errata 2.1.1.128 in SPRZ278F */
> +static struct omap_mmc_dev_attr mmc2_pre_es3_dev_attr =3D {
> + =A0 =A0 =A0 .flags =3D OMAP_HSMMC_BROKEN_MULTIBLOCK_READ,
> +};
> +
> +static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc2",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_mmc2_mpu_irqs,
> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap34xx_mmc2_sdma_reqs,
> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap34xx_mmc2_opt_clks,
> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap34xx_mmc2_opt_clks=
),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs2_fck",
> + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_M=
OD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP343=
0_EN_MMC2_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OM=
AP3430_ST_MMC2_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &mmc2_pre_es3_dev_attr,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_mmc2_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_mmc2_slaves=
),
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_mmc_class,
> +};
> +
> +static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc2",
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap34xx_mmc2_mpu_irqs,
> =A0 =A0 =A0 =A0.sdma_reqs =A0 =A0 =A0=3D omap34xx_mmc2_sdma_reqs,
> @@ -3130,8 +3185,6 @@ static __initdata struct omap_hwmod *omap3xxx_h=
wmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_l4_core_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_l4_per_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_l4_wkup_hwmod,
> - =A0 =A0 =A0 &omap3xxx_mmc1_hwmod,
> - =A0 =A0 =A0 &omap3xxx_mmc2_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_mmc3_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_mpu_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_iva_hwmod,
> @@ -3209,6 +3262,20 @@ static __initdata struct omap_hwmod *omap3430e=
s2plus_hwmods[] =3D {
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> +/* <=3D 3430ES3-only hwmods */
> +static __initdata struct omap_hwmod *omap3430_pre_es3_hwmods[] =3D {
> + =A0 =A0 =A0 &omap3xxx_pre_es3_mmc1_hwmod,
> + =A0 =A0 =A0 &omap3xxx_pre_es3_mmc2_hwmod,
> + =A0 =A0 =A0 NULL
> +};
> +
> +/* 3430ES3+-only hwmods */
> +static __initdata struct omap_hwmod *omap3430_es3plus_hwmods[] =3D {
> + =A0 =A0 =A0 &omap3xxx_es3plus_mmc1_hwmod,
> + =A0 =A0 =A0 &omap3xxx_es3plus_mmc2_hwmod,
> + =A0 =A0 =A0 NULL
> +};
> +
> =A0/* 34xx-only hwmods (all ES revisions) */
> =A0static __initdata struct omap_hwmod *omap34xx_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap34xx_sr1_hwmod,
> @@ -3281,6 +3348,21 @@ int __init omap3xxx_hwmod_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0h =3D omap3430es2plus_hwmods;
> =A0 =A0 =A0 =A0};
>
> + =A0 =A0 =A0 if (h) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_hwmod_register(h);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_VALUE(r))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 h =3D NULL;
> + =A0 =A0 =A0 if (rev =3D=3D OMAP3430_REV_ES1_0 || rev =3D=3D OMAP343=
0_REV_ES2_0 ||
> + =A0 =A0 =A0 =A0 =A0 rev =3D=3D OMAP3430_REV_ES2_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D omap3430_pre_es3_hwmods;
> + =A0 =A0 =A0 } else if (rev =3D=3D OMAP3430_REV_ES3_0 || rev =3D=3D =
OMAP3430_REV_ES3_1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_REV_ES3_1_2)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D omap3430_es3plus_hwmods;
> + =A0 =A0 =A0 };
> +
> =A0 =A0 =A0 =A0if (h)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D omap_hwmod_register(h);
>
> --
> 1.7.6.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
