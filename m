From: Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Thu, 26 Jul 2018 09:56:28 -0400
Message-ID: <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712073904.4705-3-stefan@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 07/12/2018 03:39 AM, Stefan Agner wrote:
> It seems that SD3.0 advertisement needs to be set for higher eMMC
> speed modes (namely DDR52) as well. The TRM states that the SD3.0
> advertisement bit should be set for all controller instances, even
> for those not supporting UHS-I mode...
> 
> When specifying vqmmc-supply as a fixed 1.8V regulator on a Tegra
> SD/MMC instance which is connected to a eMMC device, the stack
> enables SD3.0. However, enabling it has consequences: If SDHCI 3.0
> support is advertised the stack enables Auto-CMD23. Unfortunately
> Auto-CMD23 seems not to work well with Tegra 3 currently. It leads
> to regular warnings:
>    mmc2: Got command interrupt 0x00010000 even though no command operation was in progress.
> 
> It is not entirely clear why those errors happens. It seems that
> a Linux 3.1 based downstream kernel which has Auto-CMD23 support
> does not show those warnings.
> 
> Use quirk SDHCI_QUIRK2_ACMD23_BROKEN to prevent Auto-CMD23 being
> used for now. With this the eMMC works stable on high-speed mode
> while still announcing SD3.0.
> 
> This allows to use mmc-ddr-1_8v to enables DDR52 mode. In DDR52
> mode read speed improves from about 42MiB/s to 72MiB/s on an
> Apalis T30.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 888a1ad511db..11c0b2069c7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -336,7 +336,15 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>   		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>   		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_BROKEN_HS200,
> +		   SDHCI_QUIRK2_BROKEN_HS200 |
> +		   /*
> +		    * Auto-CMD23 leads to "Got command interrupt 0x00010000 even
> +		    * though no command operation was in progress."
> +		    *
> +		    * The exact reason is unknown, as the same hardware seems
> +		    * to support Auto CMD23 on a downstream 3.1 kernel.
> +		    */
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
>   	.ops  = &tegra_sdhci_ops,
>   };
>   

I finally got around to testing this on the Ouya (Tegra 3).

I found that the "Got command interrupt 0x00010000 even though no 
command operation was in progress." error occurred when the interface is 
unstable.
I've had a lot of problems with sdmmc4 stability on the Ouya above 34 
Mhz, probably due to the fact that they are using the internal cmd and 
clock pull-up resistors, against the TRM's instruction.
At 39Mhz, I saw the error this patch corrects.
With the patch, the error went away, but the interface is still unstable 
under load.

Lowering down to 32Mhz, without the patch there are no errors.
