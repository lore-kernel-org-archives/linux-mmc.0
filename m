From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
Date: Wed, 4 Oct 2017 10:59:44 +0200
Message-ID: <CAPDyKFrX4HUpYO1Cp4Tca==3o35X04P1E=DPPACxCZHCgdaqtQ@mail.gmail.com>
References: <20171002145852.24729-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171002145852.24729-1-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hann
List-Id: linux-mmc@vger.kernel.org

On 2 October 2017 at 16:58, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
>
> The binding documentation is updating accordingly.
>
> Without this patch the kernel hand during boot if the mvpp2.2 network
> driver was not present in the kernel. Indeed the clock needed by the
> xenon controller was set by the network driver.
>
> Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core
> functionality)"
> CC: Stable <stable@vger.kernel.org>
> Tested-by: Zhoujie Wu <zjwu@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks, applied for fixes!

Next time, please split DT changes into separate patches - as that
simplifies the review process.

Kind regards
Uffe

> ---
> Hi Ulf and Adrian,
>
> This patch should be merged in 4.14-rc, as it fixes real issues.
>
> This patch may looks like just as a nice clean-up but it is not. On
> the earlier version of the series adding the support for the xenon
> controller there was already this axi bus clock. But at this moment
> the documentation for the clock on the Armada 7K/8K was missing and
> there was no driver for it, so we just use the clock set by the
> bootloader and never change them that's why it worked without any
> visible problem.
>
> Then as explained in the commit log the network driver enabled the
> clock for us, and it happened that it was setup before the xenon
> driver. It is only thanks the new information we received on the
> clocks of the SoC and with more exhaustive testes that we found this
> issue and the fix for it.
>
> Thanks,
>
> Gregory
>
> Changelog:
> v2->v3:
>  - remove useless test on clk pointer
>  - added tested-by from  Zhoujie Wu
>
> v1->v2:
>  - manage the -EPROBE_DEFER case
>  - remove warning message when axi clock is not present
>  - remove useless test before clk_disable_unprepare()
>
>  .../bindings/mmc/marvell,xenon-sdhci.txt           | 12 ++++++-----
>  drivers/mmc/host/sdhci-xenon.c                     | 24 ++++++++++++++++++----
>  drivers/mmc/host/sdhci-xenon.h                     |  1 +
>  3 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> index b878a1e305af..ed1456f5c94d 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> @@ -16,11 +16,13 @@ Required Properties:
>
>  - clocks:
>    Array of clocks required for SDHC.
> -  Require at least input clock for Xenon IP core.
> +  Require at least input clock for Xenon IP core. For Armada AP806 and
> +  CP110, the AXI clock is also mandatory.
>
>  - clock-names:
>    Array of names corresponding to clocks property.
>    The input clock for Xenon IP core should be named as "core".
> +  The input clock for the AXI bus must be named as "axi".
>
>  - reg:
>    * For "marvell,armada-3700-sdhci", two register areas.
> @@ -106,8 +108,8 @@ Example:
>                 compatible = "marvell,armada-ap806-sdhci";
>                 reg = <0xaa0000 0x1000>;
>                 interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> -               clocks = <&emmc_clk>;
> -               clock-names = "core";
> +               clocks = <&emmc_clk>,<&axi_clk>;
> +               clock-names = "core", "axi";
>                 bus-width = <4>;
>                 marvell,xenon-phy-slow-mode;
>                 marvell,xenon-tun-count = <11>;
> @@ -126,8 +128,8 @@ Example:
>                 interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>                 vqmmc-supply = <&sd_vqmmc_regulator>;
>                 vmmc-supply = <&sd_vmmc_regulator>;
> -               clocks = <&sdclk>;
> -               clock-names = "core";
> +               clocks = <&sdclk>, <&axi_clk>;
> +               clock-names = "core", "axi";
>                 bus-width = <4>;
>                 marvell,xenon-tun-count = <9>;
>         };
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 2eec2e652c53..0842bbc2d7ad 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -466,6 +466,7 @@ static int xenon_probe(struct platform_device *pdev)
>  {
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
> +       struct xenon_priv *priv;
>         int err;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> @@ -474,6 +475,7 @@ static int xenon_probe(struct platform_device *pdev)
>                 return PTR_ERR(host);
>
>         pltfm_host = sdhci_priv(host);
> +       priv = sdhci_pltfm_priv(pltfm_host);
>
>         /*
>          * Link Xenon specific mmc_host_ops function,
> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
>         if (err)
>                 goto free_pltfm;
>
> +       priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> +       if (IS_ERR(priv->axi_clk)) {
> +               err = PTR_ERR(priv->axi_clk);
> +               if (err == -EPROBE_DEFER)
> +                       goto err_clk;
> +       } else {
> +               err = clk_prepare_enable(priv->axi_clk);
> +               if (err)
> +                       goto err_clk;
> +       }
> +
>         err = mmc_of_parse(host->mmc);
>         if (err)
> -               goto err_clk;
> +               goto err_clk_axi;
>
>         sdhci_get_of_property(pdev);
>
> @@ -502,11 +515,11 @@ static int xenon_probe(struct platform_device *pdev)
>         /* Xenon specific dt parse */
>         err = xenon_probe_dt(pdev);
>         if (err)
> -               goto err_clk;
> +               goto err_clk_axi;
>
>         err = xenon_sdhc_prepare(host);
>         if (err)
> -               goto err_clk;
> +               goto err_clk_axi;
>
>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
> @@ -527,6 +540,8 @@ static int xenon_probe(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>         xenon_sdhc_unprepare(host);
> +err_clk_axi:
> +       clk_disable_unprepare(priv->axi_clk);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>  free_pltfm:
> @@ -538,6 +553,7 @@ static int xenon_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> @@ -546,7 +562,7 @@ static int xenon_remove(struct platform_device *pdev)
>         sdhci_remove_host(host, 0);
>
>         xenon_sdhc_unprepare(host);
> -
> +       clk_disable_unprepare(priv->axi_clk);
>         clk_disable_unprepare(pltfm_host->clk);
>
>         sdhci_pltfm_free(pdev);
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 2bc0510c0769..9994995c7c56 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -83,6 +83,7 @@ struct xenon_priv {
>         unsigned char   bus_width;
>         unsigned char   timing;
>         unsigned int    clock;
> +       struct clk      *axi_clk;
>
>         int             phy_type;
>         /*
> --
> 2.14.1
>
