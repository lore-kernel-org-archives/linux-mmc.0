From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Tue, 01 Mar 2016 22:34:02 +0100
Message-ID: <10092864.HLRl1VM3vC@wuerfel>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com> <1456806764-16467-3-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456806764-16467-3-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 01 March 2016 13:32:44 Alexandre Courbot wrote:
> On T210, the sdhci controller can address more than 32 bits of address
> space. Failing to express this fact results in the use of bounce
> buffers and affects performance.
> 
> Signed-off-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I don't get this one. Why don't you just set the (SDHCI_USE_SDMA | SDHCI_USE_ADMA)
flags that are checked in the first patch?

> @@ -289,6 +291,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
>  	.pdata = &sdhci_tegra20_pdata,
>  	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
>  		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
> +	.dma_mask = DMA_BIT_MASK(32),
>  };

Can you describe what the specific bug is in these controllers? Do you mean they
support SDHCI_USE_SDMA or SDHCI_USE_ADMA in theory but you still have to prevent
them from using high addresses?

> @@ -353,6 +358,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  	.pdata = &sdhci_tegra210_pdata,
> +	.dma_mask = DMA_BIT_MASK(34),
>  };
>  
>  static const struct of_device_id sdhci_tegra_dt_match[] = {

This one still completely weirds me out. What kind of odd limitation does
the controller have in Tegra 210?

Are there actually any machines with more than 16GB?

	Arnd
