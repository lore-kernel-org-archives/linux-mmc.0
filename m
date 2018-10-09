From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/6] mmc: sdhci-of-arasan: Add a single data structure to
 incorporate pdata and soc_ctl_map
Date: Tue, 9 Oct 2018 09:30:22 +0200
Message-ID: <CAPDyKFq4YMAj5m6o26-dV5UHasg668GSk+SdhR7LQrEs5r582Q@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-5-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Currently, the driver passes platform data as a global structure
> and uses the .data of of_device_id to pass the soc_ctl_map. To
> make the implementation more flexible add a single data structure
> that incorporates both of the above and pass it in the .data of
> of_device_id.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 47 ++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b806b24a3e5f..c9e3e050ccc8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -107,6 +107,11 @@ struct sdhci_arasan_data {
>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
>  };
>
> +struct sdhci_arasan_of_data {
> +       const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +       const struct sdhci_pltfm_data *pdata;
> +};
> +
>  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>         .baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
>         .clockmultiplier = { .reg = 0xf02c, .width = 8, .shift = 0},
> @@ -307,6 +312,10 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>                         SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>
> +static struct sdhci_arasan_of_data sdhci_arasan_data = {
> +       .pdata = &sdhci_arasan_pdata,
> +};
> +
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>         int cmd_error = 0;
> @@ -363,6 +372,11 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> +       .soc_ctl_map = &rk3399_soc_ctl_map,
> +       .pdata = &sdhci_arasan_cqe_pdata,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -462,14 +476,21 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>         /* SoC-specific compatible strings w/ soc_ctl_map */
>         {
>                 .compatible = "rockchip,rk3399-sdhci-5.1",
> -               .data = &rk3399_soc_ctl_map,
> +               .data = &sdhci_arasan_rk3399_data,
>         },
> -
>         /* Generic compatible below here */
> -       { .compatible = "arasan,sdhci-8.9a" },
> -       { .compatible = "arasan,sdhci-5.1" },
> -       { .compatible = "arasan,sdhci-4.9a" },
> -
> +       {
> +               .compatible = "arasan,sdhci-8.9a",
> +               .data = &sdhci_arasan_data,
> +       },
> +       {
> +               .compatible = "arasan,sdhci-5.1",
> +               .data = &sdhci_arasan_data,
> +       },
> +       {
> +               .compatible = "arasan,sdhci-4.9a",
> +               .data = &sdhci_arasan_data,
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> @@ -707,14 +728,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_arasan_data *sdhci_arasan;
>         struct device_node *np = pdev->dev.of_node;
> -       const struct sdhci_pltfm_data *pdata;
> -
> -       if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-5.1"))
> -               pdata = &sdhci_arasan_cqe_pdata;
> -       else
> -               pdata = &sdhci_arasan_pdata;
> +       const struct sdhci_arasan_of_data *data;
>
> -       host = sdhci_pltfm_init(pdev, pdata, sizeof(*sdhci_arasan));
> +       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> +       data = match->data;
> +       host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
> @@ -723,8 +741,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>         sdhci_arasan->host = host;
>
> -       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> -       sdhci_arasan->soc_ctl_map = match->data;
> +       sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
>
>         node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
>         if (node) {
> --
> 2.18.0
>
