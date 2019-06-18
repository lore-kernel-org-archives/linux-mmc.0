From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
Date: Tue, 18 Jun 2019 09:56:45 +0300
Message-ID: <866e6b54-7e4b-472d-7134-e322b2f0810e@intel.com>
References: <20190617201014.84503-1-rrangel@chromium.org>
 <20190617201014.84503-2-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617201014.84503-2-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, djkurtz@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 17/06/19 11:10 PM, Raul E Rangel wrote:
> The O2 controller supports 8-bit EMMC access.
> 
> JESD84-B51 section A.6.3.a defines the bus testing procedure that
> `mmc_select_bus_width()` implements. This is used to determine the actual
> bus width of the eMMC.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> I tested this on an AMD chromebook.
> 
> $ cat /sys/kernel/debug/mmc1/ios
> clock:          200000000 Hz
> actual clock:   200000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> Before this patch only 4 bit was negotiated.
> 
>  drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index dd21315922c87..9dc4548271b4b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> -	u32 reg;
> +	u32 reg, caps;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> +
> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +
> +	/*
> +	 * mmc_select_bus_width() will test the bus to determine the actual bus
> +	 * width.
> +	 */
> +	if (caps & SDHCI_CAN_DO_8BIT)
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> 
