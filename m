From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] mmc: sdhci-tegra: get_ro(): Retrieve pdata correctly
Date: Tue, 23 Aug 2011 11:17:56 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A38C1@HQMAIL01.nvidia.com>
References: <1312913798-32564-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312913798-32564-1-git-send-email-swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Stephen Warren wrote at Tuesday, August 09, 2011 12:17 PM:
> The active platform data pointer is stored as pltfm_host->priv, and not
> always in the platform device itself. In particular, the platform data in
> the platform device is NULL when the platform data comes from Device Tree.
> 
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Grant, this patch is for branch devicetree/next; the Tegra DT support
> doesn't appear to be in other branches yet.

Grant, you can ignore this patch now; I just posted a complete version
suitable for inclusion in mainline.

>  drivers/mmc/host/sdhci-tegra.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 9329465..406d360 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -74,10 +74,8 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
> 
>  static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
>  {
> -	struct platform_device *pdev = to_platform_device(mmc_dev(sdhci->mmc));
> -	struct tegra_sdhci_platform_data *plat;
> -
> -	plat = pdev->dev.platform_data;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(sdhci);
> +	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> 
>  	if (!gpio_is_valid(plat->wp_gpio))
>  		return -1;
> --
> 1.7.0.4

-- 
nvpublic
