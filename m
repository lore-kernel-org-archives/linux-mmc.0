From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: Remove usage of clk_type member in
 platform data
Date: Tue, 4 Oct 2011 16:53:24 +0900
Message-ID: <CAH9JG2VKeRujhEUA=y7UuncwUFrMqtdnkpiVqz0VHCF1nPK4_Q@mail.gmail.com>
References: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
	<1317713315-5830-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40455 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab1JDHxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 03:53:25 -0400
In-Reply-To: <1317713315-5830-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, Jeongbae Seo <jeongbae.seo@samsung.com>

Hi,

On Tue, Oct 4, 2011 at 4:28 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> SDHCI controllers on Exynos4 do not include the sdclk divider as per =
the
> sdhci controller specification. This case can be represented using th=
e
> sdhci quirk SDHCI_QUIRK_NONSTANDARD_CLOCK instead of using an additio=
nal
> enum type definition 'clk_types'.
>
> Hence, usage of clk_type member in platform data is removed and the s=
dhci
> quirk is used. In addition to that, since this qurik is SoC specific,
> driver data is introduced to represent controllers on SoC's that requ=
ire
> this quirk.
Right.
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Jeongbae Seo <jeongbae.seo@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> In the function 'sdhci_cmu_set_clock', the code that waits for a stab=
le
> sdclk clock is replicated from 'sdhci_set_clock' function. This porti=
on
> of code is replicated in sdhci-cns3xxx driver as well. This duplicati=
on
> could have been avoid by adding a new function in sdhci host controll=
er
> driver that waits for stable sdclk and sdhci-s3c/sdhci-cns3xxx can be
> the users of the new function. If adding a new function in sdhci host
> controller driver is acceptable, an additional patch in this series
> can be added that creates the new function that waits for stable sdcl=
k.
>
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 74 ++++++++++++++++++++++++++++=
+++++++++++--
> =A01 files changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 82709b6..b29e734 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -53,6 +53,18 @@ struct sdhci_s3c {
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk_bus[MAX_BUS=
_CLK];
> =A0};
>
> +/**
> + * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver=
 data
> + * @sdhci_quirks: sdhci host specific quirks.
> + *
> + * Specifies platform specific configuration of sdhci controller.
> + * Note: A structure for driver specific platform data is used for f=
uture
> + * expansion of its usage.
> + */
> +struct sdhci_s3c_drv_data {
> + =A0 =A0 =A0 unsigned int =A0 =A0sdhci_quirks;
> +};
> +
> =A0static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0return sdhci_priv(host);
> @@ -132,10 +144,10 @@ static unsigned int sdhci_s3c_consider_clock(st=
ruct sdhci_s3c *ourhost,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return UINT_MAX;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Clock divider's step is different as 1 from that o=
f host controller
> - =A0 =A0 =A0 =A0* when 'clk_type' is S3C_SDHCI_CLK_DIV_EXTERNAL.
> + =A0 =A0 =A0 =A0* If controller uses a non-standard clock division, =
find the best clock
> + =A0 =A0 =A0 =A0* speed possible with selected clock source and skip=
 the division.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (ourhost->pdata->clk_type) {
> + =A0 =A0 =A0 if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLO=
CK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_round_rate(clksrc, wanted=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wanted - rate;
> =A0 =A0 =A0 =A0}
> @@ -272,6 +284,8 @@ static unsigned int sdhci_cmu_get_min_clock(struc=
t sdhci_host *host)
> =A0static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned =
int clock)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 unsigned long timeout;
> + =A0 =A0 =A0 u16 clk =3D 0;
>
> =A0 =A0 =A0 =A0/* don't bother if the clock is going off */
> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
> @@ -282,6 +296,25 @@ static void sdhci_cmu_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
> =A0 =A0 =A0 =A0clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock=
);
>
> =A0 =A0 =A0 =A0host->clock =3D clock;
> +
> + =A0 =A0 =A0 clk =3D SDHCI_CLOCK_INT_EN;
> + =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 /* Wait max 20 ms */
> + =A0 =A0 =A0 timeout =3D 20;
> + =A0 =A0 =A0 while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SDHCI_CLOCK_INT_STABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: In=
ternal clock never "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "stabil=
ised.\n", mmc_hostname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk |=3D SDHCI_CLOCK_CARD_EN;
> + =A0 =A0 =A0 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> =A0}
>
> =A0/**
> @@ -382,9 +415,17 @@ static void sdhci_s3c_setup_card_detect_gpio(str=
uct sdhci_s3c *sc)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device =
*pdev)
> +{
> + =A0 =A0 =A0 return (struct sdhci_s3c_drv_data *)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_get_device_id(=
pdev)->driver_data;
> +}
> +
> =A0static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct s3c_sdhci_platdata *pdata =3D pdev->dev.platfor=
m_data;
> + =A0 =A0 =A0 struct sdhci_s3c_drv_data *drv_data;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> =A0 =A0 =A0 =A0struct sdhci_s3c *sc;
> @@ -414,6 +455,7 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(host);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 drv_data =3D sdhci_s3c_get_driver_data(pdev);
> =A0 =A0 =A0 =A0sc =3D sdhci_priv(host);
>
> =A0 =A0 =A0 =A0sc->host =3D host;
> @@ -494,6 +536,8 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0/* Setup quirks for the controller */
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
> + =A0 =A0 =A0 if (drv_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D drv_data->sdhci_quirk=
s;
>
> =A0#ifndef CONFIG_MMC_SDHCI_S3C_DMA
>
> @@ -534,7 +578,7 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 * If controller does not have internal clock divider,
> =A0 =A0 =A0 =A0 * we can use overriding functions instead of default.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (pdata->clk_type) {
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_s3c_ops.set_clock =3D sdhci_cmu_=
set_clock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_s3c_ops.get_min_clock =3D sdhci_=
cmu_get_min_clock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_s3c_ops.get_max_clock =3D sdhci_=
cmu_get_max_clock;
> @@ -639,9 +683,31 @@ static int sdhci_s3c_resume(struct platform_devi=
ce *dev)
> =A0#define sdhci_s3c_resume NULL
> =A0#endif
>
> +#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
> +static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data =3D {
> + =A0 =A0 =A0 .sdhci_quirks =3D SDHCI_QUIRK_NONSTANDARD_CLOCK,
> +};
> +#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_d=
ata)
> +#else
> +#define EXYNOS4_SDHCI_DRV_DATA (kernel_ulong_t)NULL
> +#endif
It's too small to save the memory. I think no need to guard the exynos
driver data with ifdef/endif.
> +
> +static struct platform_device_id sdhci_s3c_driver_ids[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s3c-sdhc=
i",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)NULL,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "exynos4-=
sdhci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D EXYNOS4_SDHCI_D=
RV_DATA,
> + =A0 =A0 =A0 },
> +};
> +MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);

Do you have a plan to use the sdhci-pltfm.c as other drivers did?
some drivers are already use it and support OF features.

Thank you,
Kyungmin Park
> +
> =A0static struct platform_driver sdhci_s3c_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_s3c_remo=
ve),
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D sdhci_s3c_driver_ids,
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D sdhci_s3c_suspend,
> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =3D sdhci_s3c_resume,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> --
> 1.6.6.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
