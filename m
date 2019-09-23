From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: tegra: Implement ->set_dma_mask()
Date: Mon, 23 Sep 2019 09:41:20 +0300
Message-ID: <3532e035-d1b2-265d-1a02-37f10142eb38@intel.com>
References: <20190920145317.11972-1-thierry.reding@gmail.com>
 <20190920145317.11972-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920145317.11972-3-thierry.reding@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/09/19 5:53 PM, Thierry Reding wrote:
> From: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> The SDHCI controller on Tegra186 supports 40-bit addressing, which is
> usually enough to address all of system memory. However, if the SDHCI
> controller is behind an IOMMU, the address space can go beyond. This
> happens on Tegra186 and later where the ARM SMMU has an input address
> space of 48 bits. If the DMA API is backed by this ARM SMMU, the top-
> down IOVA allocator will cause IOV addresses to be returned that the
> SDHCI controller cannot access.
> 
> Unfortunately, prior to the introduction of the ->set_dma_mask() host
> operation, the SDHCI core would set either a 64-bit DMA mask if the
> controller claimed to support 64-bit addressing, or a 32-bit DMA mask
> otherwise.
> 
> Since the full 64 bits cannot be addressed on Tegra, this had to be
> worked around in commit 68481a7e1c84 ("mmc: tegra: Mark 64 bit dma
> broken on Tegra186") by setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA
> quirk, which effectively restricts the DMA mask to 32 bits.
> 
> One disadvantage of this is that dma_map_*() APIs will now try to use
> the swiotlb to bounce DMA to addresses beyond of the controller's DMA
> mask. This in turn caused degraded performance and can lead to
> situations where the swiotlb buffer is exhausted, which in turn leads
> to DMA transfers to fail.
> 
> With the recent introduction of the ->set_dma_mask() host operation,
> this can now be properly fixed. For each generation of Tegra, the exact
> supported DMA mask can be configured. This kills two birds with one
> stone: it avoids the use of bounce buffers because system memory never
> exceeds the addressable memory range of the SDHCI controllers on these
> devices, and at the same time when an IOMMU is involved, it prevents
> IOV addresses from being allocated beyond the addressible range of the
> controllers.
> 
> Since the DMA mask is now properly handled, the 64-bit DMA quirk can be
> removed.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> [treding@nvidia.com: provide more background in commit message]
> Signed-off-by: Thierry Reding <treding@nvidia.com>

And again with inux->mmc -> linux-mmc

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 02d8f524bb9e..7bc950520fd9 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -104,6 +105,7 @@
>  
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> +	u64 dma_mask;
>  	u32 nvquirks;
>  	u8 min_tap_delay;
>  	u8 max_tap_delay;
> @@ -1233,11 +1235,25 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
>  };
>  
> +static int tegra_sdhci_set_dma_mask(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *platform = sdhci_priv(host);
> +	struct sdhci_tegra *tegra = sdhci_pltfm_priv(platform);
> +	const struct sdhci_tegra_soc_data *soc = tegra->soc_data;
> +	struct device *dev = mmc_dev(host->mmc);
> +
> +	if (soc->dma_mask)
> +		return dma_set_mask_and_coherent(dev, soc->dma_mask);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops tegra_sdhci_ops = {
>  	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> +	.set_dma_mask = tegra_sdhci_set_dma_mask,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
> @@ -1257,6 +1273,7 @@ static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
>  	.pdata = &sdhci_tegra20_pdata,
> +	.dma_mask = DMA_BIT_MASK(32),
>  	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
>  		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
>  };
> @@ -1283,6 +1300,7 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  	.pdata = &sdhci_tegra30_pdata,
> +	.dma_mask = DMA_BIT_MASK(32),
>  	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104 |
> @@ -1295,6 +1313,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>  	.write_w    = tegra_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> +	.set_dma_mask = tegra_sdhci_set_dma_mask,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
> @@ -1316,6 +1335,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
>  	.pdata = &sdhci_tegra114_pdata,
> +	.dma_mask = DMA_BIT_MASK(32),
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> @@ -1325,22 +1345,13 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   /*
> -		    * The TRM states that the SD/MMC controller found on
> -		    * Tegra124 can address 34 bits (the maximum supported by
> -		    * the Tegra memory controller), but tests show that DMA
> -		    * to or from above 4 GiB doesn't work. This is possibly
> -		    * caused by missing programming, though it's not obvious
> -		    * what sequence is required. Mark 64-bit DMA broken for
> -		    * now to fix this for existing users (e.g. Nyan boards).
> -		    */
> -		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	.ops  = &tegra114_sdhci_ops,
>  };
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>  	.pdata = &sdhci_tegra124_pdata,
> +	.dma_mask = DMA_BIT_MASK(34),
>  };
>  
>  static const struct sdhci_ops tegra210_sdhci_ops = {
> @@ -1349,6 +1360,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
>  	.write_w    = tegra210_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> +	.set_dma_mask = tegra_sdhci_set_dma_mask,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> @@ -1369,6 +1381,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  	.pdata = &sdhci_tegra210_pdata,
> +	.dma_mask = DMA_BIT_MASK(34),
>  	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> @@ -1383,6 +1396,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> +	.set_dma_mask = tegra_sdhci_set_dma_mask,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> @@ -1398,20 +1412,13 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
> -		    * IOVA addresses are 48-bit wide on Tegra186.
> -		    * With 64-bit dma mask used for SDHCI, accesses can
> -		    * be broken. Disable 64-bit dma, which would fall back
> -		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
> -		    * But it is not supported as of now.
> -		    */
> -		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	.ops  = &tegra186_sdhci_ops,
>  };
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  	.pdata = &sdhci_tegra186_pdata,
> +	.dma_mask = DMA_BIT_MASK(40),
>  	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> @@ -1424,6 +1431,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
>  	.pdata = &sdhci_tegra186_pdata,
> +	.dma_mask = DMA_BIT_MASK(39),
>  	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> 
