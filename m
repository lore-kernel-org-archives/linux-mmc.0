From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
Date: Wed, 12 Jun 2019 16:09:47 +0300
Message-ID: <d4939761-317c-ee78-b1e5-c2cdd86a12b4@intel.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <20190610185354.35310-2-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610185354.35310-2-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, djkurtz@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 10/06/19 9:53 PM, Raul E Rangel wrote:
> The O2 controller supports 8-bit EMMC access. mmc_select_bus_width()
> will be used to determine if the MMC supports 8-bit or 4-bit access.

The problem is that the bit indicates a host controller capability, not how
many data lines there actually are on the board.  Will this break something
that does not have 8 lines?

> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index dd21315922c87..07bb91cbdf1f8 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -395,11 +395,16 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
> +	if (caps & SDHCI_CAN_DO_8BIT)
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> 
