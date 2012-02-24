From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/4] mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
Date: Fri, 24 Feb 2012 15:23:33 +0530
Message-ID: <CAJuYYwSLgO1uNfPDC9HvX5ZjTrL+AzLDh9MJnZVV2=_AhMJwLw@mail.gmail.com>
References: <4F39EB0A.5070708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F39EB0A.5070708@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Dear Mr. Chung,

This has been in the todo list for a long time. Thanks for the patch.
With the use of device tree and sdhci-pltfm driver, it should be
possible to avoid dependency with platform code.

There are few comments below.

On 14 February 2012 10:33, Jaehoon Chung <jh80.chung@samsung.com> wrote=
:
> This patch is change to use the sdhci-pltfm.c
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci-s3c.c | =A0218 ++++++++++++++--------------=
--------------
> =A01 files changed, 71 insertions(+), 147 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 1af756e..a651c1e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -26,6 +26,7 @@
> =A0#include <plat/sdhci.h>
> =A0#include <plat/regs-sdhci.h>
>
> +#include "sdhci-pltfm.h"
> =A0#include "sdhci.h"
>
> =A0#define MAX_BUS_CLK =A0 =A0(4)
> @@ -41,9 +42,7 @@
> =A0* @clk_bus: The clocks that are available for the SD/MMC bus clock=
=2E
> =A0*/
> =A0struct sdhci_s3c {
> - =A0 =A0 =A0 struct sdhci_host =A0 =A0 =A0 *host;
> =A0 =A0 =A0 =A0struct platform_device =A0*pdev;
> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *ioarea;
> =A0 =A0 =A0 =A0struct s3c_sdhci_platdata *pdata;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0cur_clk;

Would it be possible to remove cur_clk and only use pltfm_host->clk ?

> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cd_irq=
;
> @@ -53,11 +52,6 @@ struct sdhci_s3c {
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk_bus[MAX_BUS=
_CLK];
> =A0};
>
> -static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
> -{
> - =A0 =A0 =A0 return sdhci_priv(host);
> -}
> -
> =A0/**
> =A0* get_curclk - convert ctrl2 register to clock source number
> =A0* @ctrl2: Control2 register value.
> @@ -72,7 +66,8 @@ static u32 get_curclk(u32 ctrl2)
>
> =A0static void sdhci_s3c_check_sclk(struct sdhci_host *host)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D pltfm_host->priv;
> =A0 =A0 =A0 =A0u32 tmp =3D readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>
> =A0 =A0 =A0 =A0if (get_curclk(tmp) !=3D ourhost->cur_clk) {
> @@ -92,13 +87,13 @@ static void sdhci_s3c_check_sclk(struct sdhci_hos=
t *host)
> =A0*/
> =A0static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D pltfm_host->priv;
> =A0 =A0 =A0 =A0struct clk *busclk;
> =A0 =A0 =A0 =A0unsigned int rate, max;
> =A0 =A0 =A0 =A0int clk;
>
> =A0 =A0 =A0 =A0/* note, a reset will reset the clock source */
> -
> =A0 =A0 =A0 =A0sdhci_s3c_check_sclk(host);
>
> =A0 =A0 =A0 =A0for (max =3D 0, clk =3D 0; clk < MAX_BUS_CLK; clk++) {
> @@ -163,7 +158,8 @@ static unsigned int sdhci_s3c_consider_clock(stru=
ct sdhci_s3c *ourhost,
> =A0*/
> =A0static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned =
int clock)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D pltfm_host->priv;
> =A0 =A0 =A0 =A0unsigned int best =3D UINT_MAX;
> =A0 =A0 =A0 =A0unsigned int delta;
> =A0 =A0 =A0 =A0int best_src =3D 0;
> @@ -233,7 +229,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host=
 *host, unsigned int clock)
> =A0*/
> =A0static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *hos=
t)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D pltfm_host->priv;
> =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
> =A0 =A0 =A0 =A0int src;
>
> @@ -251,27 +248,27 @@ static unsigned int sdhci_s3c_get_min_clock(str=
uct sdhci_host *host)
> =A0/* sdhci_cmu_get_max_clk - callback to get maximum clock frequency=
=2E*/
> =A0static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *hos=
t)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
>
> - =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk=
], UINT_MAX);
> + =A0 =A0 =A0 return clk_round_rate(pltfm_host->clk, UINT_MAX);
> =A0}
>
> =A0/* sdhci_cmu_get_min_clock - callback to get minimal supported clo=
ck value. */
> =A0static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *hos=
t)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * initial clock can be in the frequency range of
> =A0 =A0 =A0 =A0 * 100KHz-400KHz, so we set it as max value.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk=
], 400000);
> + =A0 =A0 =A0 return clk_round_rate(pltfm_host->clk, 400000);
> =A0}
>
> =A0/* sdhci_cmu_set_clock - callback on clock change.*/
> =A0static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned =
int clock)
> =A0{
> - =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
>
> =A0 =A0 =A0 =A0/* don't bother if the clock is going off */
> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
> @@ -279,7 +276,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host=
 *host, unsigned int clock)
>
> =A0 =A0 =A0 =A0sdhci_s3c_set_clock(host, clock);
>
> - =A0 =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock)=
;
> + =A0 =A0 =A0 clk_set_rate(pltfm_host->clk, clock);
>
> =A0 =A0 =A0 =A0host->clock =3D clock;
> =A0}
> @@ -382,52 +379,50 @@ static void sdhci_s3c_setup_card_detect_gpio(st=
ruct sdhci_s3c *sc)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static struct sdhci_pltfm_data sdhci_s3c_pdata =3D {
> + =A0 =A0 =A0 .quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_=
NO_BUSY_IRQ |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIR=
K_32BIT_DMA_SIZE,
> + =A0 =A0 =A0 .ops =A0 =A0=3D &sdhci_s3c_ops,
> +};
> +
> =A0static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct s3c_sdhci_platdata *pdata =3D pdev->dev.platfor=
m_data;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host;
> + =A0 =A0 =A0 struct sdhci_pltfm_data *pltfm_pdata =3D &sdhci_s3c_pda=
ta;
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> =A0 =A0 =A0 =A0struct sdhci_s3c *sc;
> - =A0 =A0 =A0 struct resource *res;
> - =A0 =A0 =A0 int ret, irq, ptr, clks;
> -
> - =A0 =A0 =A0 if (!pdata) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no device data specified\=
n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 int ret, ptr, clks;
>
> - =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> - =A0 =A0 =A0 if (irq < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq specified\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> - =A0 =A0 =A0 if (!res) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory specified\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 host =3D sdhci_alloc_host(dev, sizeof(struct sdhci_s3c)=
);
> + =A0 =A0 =A0 host =3D sdhci_pltfm_init(pdev, pltfm_pdata);
> =A0 =A0 =A0 =A0if (IS_ERR(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_alloc_host() faile=
d\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(host);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 sc =3D sdhci_priv(host);
> + =A0 =A0 =A0 sc =3D kzalloc(sizeof(struct sdhci_s3c), GFP_KERNEL);
> + =A0 =A0 =A0 if (!sc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_host;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pltfm_host =3D sdhci_priv(host);
> + =A0 =A0 =A0 pltfm_host->priv =3D sc;
>
> - =A0 =A0 =A0 sc->host =3D host;
> =A0 =A0 =A0 =A0sc->pdev =3D pdev;
> - =A0 =A0 =A0 sc->pdata =3D pdata;
> + =A0 =A0 =A0 sc->pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0sc->ext_cd_gpio =3D -1; /* invalid gpio number */
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, host);
> -
> =A0 =A0 =A0 =A0sc->clk_io =3D clk_get(dev, "hsmmc");
> =A0 =A0 =A0 =A0if (IS_ERR(sc->clk_io)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to get io clock\n=
");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(sc->clk_io);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_io_clk;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_host;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* enable the local io clock and keep it running for t=
he moment. */
> @@ -439,9 +434,8 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snprintf(name, 14, "mmc_busclk.%d", pt=
r);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk =3D clk_get(dev, name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(clk))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clks++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sc->clk_bus[ptr] =3D clk;
> @@ -450,7 +444,7 @@ static int __devinit sdhci_s3c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * save current clock index to know wh=
ich clock bus
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * is used later in overriding functio=
ns.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sc->cur_clk =3D ptr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pltfm_host->clk =3D clk;

The sc->cur_clk and pltfm_host->clk are being used interchangeably
here. It would be better to use pltfm_host->clk and remove clk_clk
member from driver private data.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(clk);
>
> @@ -464,53 +458,17 @@ static int __devinit sdhci_s3c_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_no_busclks;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 sc->ioarea =3D request_mem_region(res->start, resource_=
size(res),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host->mmc));
> - =A0 =A0 =A0 if (!sc->ioarea) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to reserve registe=
r area\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_req_regs;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 host->ioaddr =3D ioremap_nocache(res->start, resource_s=
ize(res));
> - =A0 =A0 =A0 if (!host->ioaddr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to map registers\n=
");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_req_regs;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* Ensure we have minimal gpio selected CMD/CLK/Detect=
 */
> - =A0 =A0 =A0 if (pdata->cfg_gpio)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->cfg_gpio(pdev, pdata->max_width)=
;
> -
> - =A0 =A0 =A0 host->hw_name =3D "samsung-hsmmc";
> - =A0 =A0 =A0 host->ops =3D &sdhci_s3c_ops;
> - =A0 =A0 =A0 host->quirks =3D 0;
> - =A0 =A0 =A0 host->irq =3D irq;
> -
> - =A0 =A0 =A0 /* Setup quirks for the controller */
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
> + =A0 =A0 =A0 if (sc->pdata->cfg_gpio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sc->pdata->cfg_gpio(pdev, sc->pdata->ma=
x_width);
>
> =A0#ifndef CONFIG_MMC_SDHCI_S3C_DMA
> -
> =A0 =A0 =A0 =A0/* we currently see overruns on errors, so disable the=
 SDMA
> =A0 =A0 =A0 =A0 * support as well. */
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_BROKEN_DMA;
>
> =A0#endif /* CONFIG_MMC_SDHCI_S3C_DMA */
>
> - =A0 =A0 =A0 /* It seems we do not get an DATA transfer complete on =
non-busy
> - =A0 =A0 =A0 =A0* transfers, not sure if this is a problem with this=
 specific
> - =A0 =A0 =A0 =A0* SDHCI block, or a missing configuration that needs=
 to be set. */
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NO_BUSY_IRQ;
> -
> - =A0 =A0 =A0 /* This host supports the Auto CMD12 */
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> -
> - =A0 =A0 =A0 /* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
> -
> =A0 =A0 =A0 =A0if (pdata->cd_type =3D=3D S3C_SDHCI_CD_NONE ||
> =A0 =A0 =A0 =A0 =A0 =A0pdata->cd_type =3D=3D S3C_SDHCI_CD_PERMANENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_BROKEN_C=
ARD_DETECTION;
> @@ -518,17 +476,14 @@ static int __devinit sdhci_s3c_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0if (pdata->cd_type =3D=3D S3C_SDHCI_CD_PERMANENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps =3D MMC_CAP_NONREMOVAB=
LE;
>
> + =A0 =A0 =A0 /* It supports additional host capabilities if needed *=
/
> =A0 =A0 =A0 =A0if (pdata->host_caps)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
> -
> - =A0 =A0 =A0 if (pdata->pm_caps)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->pm_caps |=3D pdata->pm_caps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D sc->pdata->host_ca=
ps;
>
> - =A0 =A0 =A0 host->quirks |=3D (SDHCI_QUIRK_32BIT_DMA_ADDR |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_QUIRK_32BIT_DM=
A_SIZE);
> + =A0 =A0 =A0 host->mmc->caps2 |=3D MMC_CAP2_BROKEN_VOLTAGE;
>
> - =A0 =A0 =A0 /* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
> - =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
> + =A0 =A0 =A0 if (pdata->pm_caps)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->pm_caps |=3D sc->pdata->pm_c=
aps;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If controller does not have internal clock divider,
> @@ -540,10 +495,6 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_s3c_ops.get_max_clock =3D sdhci_=
cmu_get_max_clock;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* It supports additional host capabilities if needed *=
/
> - =A0 =A0 =A0 if (pdata->host_caps)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
> -
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() failed\=
n");
> @@ -561,24 +512,21 @@ static int __devinit sdhci_s3c_probe(struct pla=
tform_device *pdev)
>
> =A0 =A0 =A0 =A0return 0;
>
> - err_add_host:
> - =A0 =A0 =A0 release_resource(sc->ioarea);
> - =A0 =A0 =A0 kfree(sc->ioarea);
> -
> - err_req_regs:
> +err_add_host:
> =A0 =A0 =A0 =A0for (ptr =3D 0; ptr < MAX_BUS_CLK; ptr++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sc->clk_bus[ptr]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(sc->clk_bu=
s[ptr]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(sc->clk_bus[pt=
r]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> -
> - err_no_busclks:
> +err_no_busclks:
> =A0 =A0 =A0 =A0clk_disable(sc->clk_io);
> =A0 =A0 =A0 =A0clk_put(sc->clk_io);
>
> - err_io_clk:
> - =A0 =A0 =A0 sdhci_free_host(host);
> + =A0 =A0 =A0 kfree(sc);
> +err_alloc_host:
> + =A0 =A0 =A0 sdhci_pltfm_free(pdev);
> + =A0 =A0 =A0 dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -587,8 +535,9 @@ static int __devexit sdhci_s3c_remove(struct plat=
form_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct s3c_sdhci_platdata *pdata =3D pdev->dev.platfor=
m_data;
> =A0 =A0 =A0 =A0struct sdhci_host *host =3D =A0platform_get_drvdata(pd=
ev);
> - =A0 =A0 =A0 struct sdhci_s3c *sc =3D sdhci_priv(host);
> - =A0 =A0 =A0 int ptr;
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct sdhci_s3c *sc =3D pltfm_host->priv;
> + =A0 =A0 =A0 int ptr, ret;
>
> =A0 =A0 =A0 =A0if (pdata->cd_type =3D=3D S3C_SDHCI_CD_EXTERNAL && pda=
ta->ext_cd_cleanup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->ext_cd_cleanup(&sdhci_s3c_notif=
y_change);
> @@ -599,9 +548,9 @@ static int __devexit sdhci_s3c_remove(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (gpio_is_valid(sc->ext_cd_gpio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(sc->ext_cd_gpio);
>
> - =A0 =A0 =A0 sdhci_remove_host(host, 1);
> + =A0 =A0 =A0 ret =3D sdhci_pltfm_unregister(pdev);
>
> - =A0 =A0 =A0 for (ptr =3D 0; ptr < 3; ptr++) {
> + =A0 =A0 =A0 for (ptr =3D 0; ptr < MAX_BUS_CLK; ptr++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sc->clk_bus[ptr]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(sc->clk_bu=
s[ptr]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(sc->clk_bus[pt=
r]);
> @@ -610,54 +559,29 @@ static int __devexit sdhci_s3c_remove(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0clk_disable(sc->clk_io);
> =A0 =A0 =A0 =A0clk_put(sc->clk_io);
>
> - =A0 =A0 =A0 iounmap(host->ioaddr);
> - =A0 =A0 =A0 release_resource(sc->ioarea);
> - =A0 =A0 =A0 kfree(sc->ioarea);
> -
> - =A0 =A0 =A0 sdhci_free_host(host);
> - =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -#ifdef CONFIG_PM
> -
> -static int sdhci_s3c_suspend(struct device *dev)
> -{
> - =A0 =A0 =A0 struct sdhci_host *host =3D dev_get_drvdata(dev);
> -
> - =A0 =A0 =A0 return sdhci_suspend_host(host);
> -}
> -
> -static int sdhci_s3c_resume(struct device *dev)
> -{
> - =A0 =A0 =A0 struct sdhci_host *host =3D dev_get_drvdata(dev);
> -
> - =A0 =A0 =A0 return sdhci_resume_host(host);
> + =A0 =A0 =A0 return ret;
> =A0}
>
> -static const struct dev_pm_ops sdhci_s3c_pmops =3D {
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D sdhci_s3c_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D sdhci_s3c_resume,
> -};
> -
> -#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
> -
> -#else
> -#define SDHCI_S3C_PMOPS NULL
> -#endif
> -
> =A0static struct platform_driver sdhci_s3c_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_s3c_remo=
ve),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "s3c-sdhci",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D SDHCI_S3C_PMOPS,

The SDHCI_PLTFM_PMOPS could be used here since the s3c specific ops
have been removed.

> =A0 =A0 =A0 =A0},
> =A0};
>
> -module_platform_driver(sdhci_s3c_driver);
> +static int __init sdhci_s3c_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&sdhci_s3c_driver);
> +}
> +module_init(sdhci_s3c_init);
> +
> +static void __exit sdhci_s3c_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&sdhci_s3c_driver);
> +}
> +module_exit(sdhci_s3c_exit);

Any reason to expand this into a boilerplate again?

>
> =A0MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
> =A0MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");

Thanks,
Thomas.
