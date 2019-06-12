From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
Date: Wed, 12 Jun 2019 15:53:57 +0300
Message-ID: <883dab7b-57fc-22dd-e111-72506544d0e8@intel.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, djkurtz@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 10/06/19 9:53 PM, Raul E Rangel wrote:
> sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> Without this patch the block size would be set incorrectly when the
> bus_width == 8 which results in tuning failing.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b29bf4e7dcb48..dd21315922c87 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	 */
>  	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>  		current_bus_width = mmc->ios.bus_width;
> +		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
>  		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
>  	}
>  
> @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	sdhci_end_tuning(host);
>  
> -	if (current_bus_width == MMC_BUS_WIDTH_8)
> +	if (current_bus_width == MMC_BUS_WIDTH_8) {
> +		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>  		sdhci_set_bus_width(host, current_bus_width);
> +	}
>  
>  	host->flags &= ~SDHCI_HS400_TUNING;
>  	return 0;
> 
