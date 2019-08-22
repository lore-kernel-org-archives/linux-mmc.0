From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: use struct_size() helper
Date: Thu, 22 Aug 2019 14:13:07 +0200
Message-ID: <CAPDyKFoS3_RJvOxjQXpYT6YUgqJM7WXfvdHe1f6cTkab0rgsEQ@mail.gmail.com>
References: <20190808165301.GA30877@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808165301.GA30877@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 8 Aug 2019 at 18:53, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct sdhci_cdns_priv {
>         ...
>         struct sdhci_cdns_phy_param phy_params[0];
> };
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params
>
> with:
>
> struct_size(priv, phy_params, nr_phy_params)
>
> Also, notice that, in this case, variable priv_size is not necessary,
> hence it is removed.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-cadence.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 163d1cf4367e..1768a13f89be 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -337,7 +337,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
> -       size_t priv_size;
>         unsigned int nr_phy_params;
>         int ret;
>         struct device *dev = &pdev->dev;
> @@ -351,8 +350,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>                 return ret;
>
>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -       priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
> -       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
> +       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
> +                               struct_size(priv, phy_params, nr_phy_params));
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
>                 goto disable_clk;
> --
> 2.22.0
>
