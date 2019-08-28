From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Date: Wed, 28 Aug 2019 09:47:14 -0400
Message-ID: <20190828134714.GA30547@people.danlj.org>
References: <20190827003335.2494-1-benchuanggli@gmail.com>
 <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 28, 2019 at 04:13:03PM +0300, Adrian Hunter wrote:
> On 27/08/19 3:33 AM, Ben Chuang wrote:
> Looks good, one minor comment
...
> > +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
> Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
> making the accessors always available.  So for now, I'd prefer to select
> MMC_SDHCI_IO_ACCESSORS:
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 14d89a108edd..c3bd967d8a1a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
>  	depends on MMC_SDHCI && PCI
>  	select MMC_CQHCI
>  	select IOSF_MBI if X86
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the PCI Secure Digital Host Controller Interface.
>  	  Most controllers found today are PCI devices.

Unless I'm missing something, this seems like a separate patch;
are you asking for it first, as a predecessor to the GLI patch?
