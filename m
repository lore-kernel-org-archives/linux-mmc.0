From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-aspeed: enable
 CONFIG_MMC_SDHCI_IO_ACCESSORS
Date: Wed, 20 Nov 2019 09:44:56 +0200
Message-ID: <e181d523-bc57-3eb4-cddc-92299e888f5f@intel.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-3-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118104646.3838-3-i.mikhaylov@yadro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On 18/11/19 12:46 PM, Ivan Mikhaylov wrote:
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. The read_l
> callback is used for inverted card detection.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..c9c1bb722368 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -159,6 +159,7 @@ config MMC_SDHCI_OF_ASPEED
>  	tristate "SDHCI OF support for the ASPEED SDHCI controller"
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF && OF_ADDRESS
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the ASPEED Secure Digital Host Controller Interface.
>  
> 
