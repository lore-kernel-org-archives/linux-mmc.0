From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date: Thu, 10 Jan 2019 16:11:33 +0200
Message-ID: <a960e9a7-ff86-b000-1319-df85741fb380@intel.com>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104104753.3383-1-thierry.reding@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 4/01/19 12:47 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The implementation of sdhci_set_dma_mask() is conflating two things: on
> one hand it uses the SDHCI_USE_64_BIT_DMA flag to determine whether or
> not to use the 64-bit addressing capability of the controller and on the
> other hand it also uses that flag to set a DMA mask for the controller's
> parent device.
> 
> However, a controller supporting 64-bit addressing doesn't mean that it
> needs to support addressing 64 bits of address range. It's perfectly
> acceptable to use 64-bit addressing for a 32-bit address range or even
> smaller, even if that makes little sense, considering the extra overhead
> of the 64-bit addressing descriptors.
> 
> But it is fairly common for hardware to support somewhere between 32 and
> 64 bits of address range. Tegra124 and Tegra210, for example, support 34
> bits and the newer Tegra186 and Tegra194 support 40 bits. The latter can
> also use an IOMMU for address translation, which has an input address
> range of 48 bits. This causes problems with the current algorithm in the
> SDHCI core for choosing the DMA mask. If the DMA mask is set to 64 bits,
> the DMA memory allocations can (and usually do because the allocator
> starts from the top) end up beyond the 40 bit boundary addressable by
> the SDHCI controller, causing IOMMU faults.
> 
> For Tegra specifically this problem is currently worked around by
> setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk. This causes the DMA
> mask to always be set to 32 bits and therefore all allocations will fit
> within the range addressable by the controller.
> 
> This commit reworks the code in sdhci_set_dma_mask() to fix the above
> issue. The rationale behind this change is that the SDHCI controller
> driver should be the authoritative source of the DMA mask setting. The
> SDHCI core has no way of knowing what the individual SDHCI controllers
> are capable of. So instead of overriding the DMA mask depending on
> whether or not 64-bit addressing mode is used, the DMA mask is only
> modified if absolutely necessary. On one hand, if the controller can
> only address 32 bits of memory or less, we disable use of 64-bit
> addressing mode because it is not needed. On the other hand, we also
> want to make sure that if we don't support 64-bit addressing mode, such
> as in the case where the BROKEN_64_BIT_DMA quirk is set, we do restrict
> the DMA mask to fit the capabilities. The latter is an inconsistency by
> the driver, so we warn about it to make sure it will be addressed in the
> driver.

sdhci_set_dma_mask() was added because people did want sdhci to set the DMA
mask.  Also using 64-bit DMA even with 32-bit systems has the advantage of
reducing exposure to problems i.e. the same logic is used with the same SoC
irrespective of whether or not it is in 32-bit compatibility mode.  So the
policy for sdhci is always to use 64-bit DMA if it is supported.

I suggest we add a new sdhci op for ->set_dma_mask() and call that instead
of sdhci_set_dma_mask() if it is not NULL.

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7c6c93e85b7e..01f81e96be23 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3499,27 +3499,35 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	struct device *dev = mmc_dev(mmc);
> -	int ret = -EINVAL;
> +	u64 dma_mask = dma_get_mask(dev);
> +	u64 dma32 = DMA_BIT_MASK(32);
> +	int ret = 0;
>  
>  	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
>  		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>  
> -	/* Try 64-bit mask if hardware is capable  of it */
> -	if (host->flags & SDHCI_USE_64_BIT_DMA) {
> -		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> -		if (ret) {
> -			pr_warn("%s: Failed to set 64-bit DMA mask.\n",
> -				mmc_hostname(mmc));
> -			host->flags &= ~SDHCI_USE_64_BIT_DMA;
> -		}
> +	/*
> +	 * Hardware that can't address more than the 32-bit address range does
> +	 * not need to use 64-bit addressing mode, even if it supports it.
> +	 */
> +	if ((host->flags & SDHCI_USE_64_BIT_DMA) && (dma_mask <= dma32)) {
> +		pr_debug("%s: controller needs addresses <= 32-bits\n",
> +			mmc_hostname(mmc));
> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>  	}
>  
> -	/* 32-bit mask as default & fallback */
> -	if (ret) {
> -		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	/*
> +	 * If the hardware doesn't support 64-bit addressing, make sure to
> +	 * restrict the DMA mask so we don't get buffers allocated beyond the
> +	 * 32-bit boundary.
> +	 */
> +	if (!(host->flags & SDHCI_USE_64_BIT_DMA) && (dma_mask > dma32)) {
> +		WARN(1, "64-bit DMA not supported, DMA mask %llx\n", dma_mask);
> +
> +		ret = dma_set_mask_and_coherent(dev, dma32);
>  		if (ret)
> -			pr_warn("%s: Failed to set 32-bit DMA mask.\n",
> -				mmc_hostname(mmc));
> +			pr_warn("%s: failed to set 32-bit DMA mask: %d\n",
> +				mmc_hostname(mmc), ret);
>  	}
>  
>  	return ret;
> 
