From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V2 2/3] ARM: S5PV310: Add HSMMC platform data
Date: Wed, 6 Oct 2010 17:48:21 +0900
Message-ID: <AANLkTinj96jr4LWfqcQSZGSjw_az_z+-f9EBY8COdEXm@mail.gmail.com>
References: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
	<1286344846-21244-3-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1286344846-21244-3-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jeongbae Seo <jeongbae.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, Hyuk Lee <hyuk1.lee@samsung.com>, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 6, 2010 at 3:00 PM, Jeongbae Seo <jeongbae.seo@samsung.com>=
 wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> This patch adds initialization HSMMC device information.
> And HSMMC platform data like card detect, data bus width
> and capability is configured.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
> Changes since v1:
> - Separated to board specific and common changes
> =C2=A0(This is for common part)
>
> =C2=A0arch/arm/mach-s5pv310/cpu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A07 +++
> =C2=A0arch/arm/plat-samsung/include/plat/sdhci.h | =C2=A0 57 ++++++++=
++++++++++++++++++++
> =C2=A02 files changed, 64 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.=
c
> index 225ca53..3345cf6 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <plat/cpu.h>
> =C2=A0#include <plat/clock.h>
> =C2=A0#include <plat/s5pv310.h>
> +#include <plat/sdhci.h>
>
> =C2=A0#include <mach/regs-irq.h>
>
> @@ -88,6 +89,12 @@ static void s5pv310_idle(void)
> =C2=A0void __init s5pv310_map_io(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5=
pv310_iodesc));
> +
> + =C2=A0 =C2=A0 =C2=A0 /* initialize device information early */
> + =C2=A0 =C2=A0 =C2=A0 s5pv310_default_sdhci0();
> + =C2=A0 =C2=A0 =C2=A0 s5pv310_default_sdhci1();
> + =C2=A0 =C2=A0 =C2=A0 s5pv310_default_sdhci2();
> + =C2=A0 =C2=A0 =C2=A0 s5pv310_default_sdhci3();
> =C2=A0}
>
> =C2=A0void __init s5pv310_init_clocks(int xtal)
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pl=
at-samsung/include/plat/sdhci.h
> index 30844c2..d92670a 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -110,6 +110,10 @@ extern void s5pv210_setup_sdhci0_cfg_gpio(struct=
 platform_device *, int w);
> =C2=A0extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_devic=
e *, int w);
> =C2=A0extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_devic=
e *, int w);
> =C2=A0extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_devic=
e *, int w);
> +extern void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *, =
int w);
> +extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, =
int w);
> +extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, =
int w);
> +extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, =
int w);
>
> =C2=A0/* S3C64XX SDHCI setup */
>
> @@ -288,4 +292,57 @@ static inline void s5pv210_default_sdhci3(void) =
{ }
>
> =C2=A0#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>
> +/* S5PV310 SDHCI setup */
> +#ifdef CONFIG_S5PV310_SETUP_SDHCI
> +extern char *s5pv310_hsmmc_clksrcs[4];
> +
> +extern void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void __iomem *r,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct mmc_ios *ios,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct mmc_card *card);
> +
> +static inline void s5pv310_default_sdhci0(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc0_def_platdata.clocks =3D s5pv310_hsm=
mc_clksrcs;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc0_def_platdata.cfg_gpio =3D s5pv310_s=
etup_sdhci0_cfg_gpio;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc0_def_platdata.cfg_card =3D s5pv310_s=
etup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci1(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc1_def_platdata.clocks =3D s5pv310_hsm=
mc_clksrcs;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc1_def_platdata.cfg_gpio =3D s5pv310_s=
etup_sdhci1_cfg_gpio;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc1_def_platdata.cfg_card =3D s5pv310_s=
etup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci2(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC2
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc2_def_platdata.clocks =3D s5pv310_hsm=
mc_clksrcs;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc2_def_platdata.cfg_gpio =3D s5pv310_s=
etup_sdhci2_cfg_gpio;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc2_def_platdata.cfg_card =3D s5pv310_s=
etup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci3(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC3
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc3_def_platdata.clocks =3D s5pv310_hsm=
mc_clksrcs;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc3_def_platdata.cfg_gpio =3D s5pv310_s=
etup_sdhci3_cfg_gpio;
> + =C2=A0 =C2=A0 =C2=A0 s3c_hsmmc3_def_platdata.cfg_card =3D s5pv310_s=
etup_sdhci_cfg_card;
> +#endif
> +}
> +
> +#else
> +static inline void s5pv310_default_sdhci0(void) { }
> +static inline void s5pv310_default_sdhci1(void) { }
> +static inline void s5pv310_default_sdhci2(void) { }
> +static inline void s5pv310_default_sdhci3(void) { }
> +
> +#endif /* CONFIG_S5PV310_SETUP_SDHCI */
> +
> =C2=A0#endif /* __PLAT_S3C_SDHCI_H */

Why don't we have s5pv310_default_sdhci(int cont_num) ?
