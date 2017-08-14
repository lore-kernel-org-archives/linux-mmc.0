From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc/sdhci-pci: use generic sdhci_set_bus_width()
Date: Mon, 14 Aug 2017 15:04:33 +0300
Message-ID: <01b41e73-37a0-ce34-af20-92f092eb9313@intel.com>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
 <b1a072bfd9f9d7934bef982e4a94734eccf0b8e4.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b1a072bfd9f9d7934bef982e4a94734eccf0b8e4.1502310654.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/08/17 23:36, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>

There always needs to be a commit message. i.e.

"Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
MMC_CAP_8_BIT_DATA capability flag, replace the sdhci-pci version with the
generic sdhci version."

Also subject should begin "mmc: sdhci-pci: "...

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 92fc3f7c538d..dfe217e7fbfe 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -35,7 +35,6 @@
>  #include "sdhci-pci-o2micro.h"
>  
>  static int sdhci_pci_enable_dma(struct sdhci_host *host);
> -static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -547,7 +546,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
> -	.set_bus_width		= sdhci_pci_set_bus_width,
> +	.set_bus_width		= sdhci_set_bus_width,
>  	.reset			= sdhci_reset,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.hw_reset		= sdhci_pci_hw_reset,
> @@ -1159,7 +1158,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>  static const struct sdhci_ops amd_sdhci_pci_ops = {
>  	.set_clock			= sdhci_set_clock,
>  	.enable_dma			= sdhci_pci_enable_dma,
> -	.set_bus_width			= sdhci_pci_set_bus_width,
> +	.set_bus_width			= sdhci_set_bus_width,
>  	.reset				= sdhci_reset,
>  	.set_uhs_signaling		= sdhci_set_uhs_signaling,
>  	.platform_execute_tuning	= amd_execute_tuning,
> @@ -1750,29 +1749,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
>  	return 0;
>  }
>  
> -static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width)
> -{
> -	u8 ctrl;
> -
> -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -
> -	switch (width) {
> -	case MMC_BUS_WIDTH_8:
> -		ctrl |= SDHCI_CTRL_8BITBUS;
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> -		break;
> -	case MMC_BUS_WIDTH_4:
> -		ctrl |= SDHCI_CTRL_4BITBUS;
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> -		break;
> -	default:
> -		ctrl &= ~(SDHCI_CTRL_8BITBUS | SDHCI_CTRL_4BITBUS);
> -		break;
> -	}
> -
> -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> -}
> -
>  static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -1799,7 +1775,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
>  static const struct sdhci_ops sdhci_pci_ops = {
>  	.set_clock	= sdhci_set_clock,
>  	.enable_dma	= sdhci_pci_enable_dma,
> -	.set_bus_width	= sdhci_pci_set_bus_width,
> +	.set_bus_width	= sdhci_set_bus_width,
>  	.reset		= sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.hw_reset		= sdhci_pci_hw_reset,
> 
