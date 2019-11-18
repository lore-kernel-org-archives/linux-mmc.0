From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Add Support for Command Queuing Engine
 to J721E
Date: Mon, 18 Nov 2019 11:57:14 +0530
Message-ID: <28fa7d6a-1067-f898-a2e0-28468092a39c@ti.com>
References: <20191115114009.20090-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191115114009.20090-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 15/11/19 5:10 PM, Faiz Abbas wrote:
> Add Support for CQHCI (Command Queuing Host Controller Interface)
> for each of the host controllers present in TI's J721E devices.
> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..25f12ef813ff 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
>  	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>  	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select CONFIG_MMC_CQHCI

Oops, this should just be select MMC_CQHCI. Sending v2.

Thanks,
Faiz
