From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 3/7] mmc: sdhci: Add callback to set bus mode
Date: Tue, 15 Aug 2017 10:38:24 +0300
Message-ID: <c561b463-bf4b-1ad1-e053-19cec6d8fc28@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-4-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753232AbdHOHow (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Aug 2017 03:44:52 -0400
In-Reply-To: <20170807160142.12134-4-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
> Add callback to set bus mode in sdhci library so that the
> controller driver can perform any bus mode specific configurations
> in the callback function.

A quirk isn't needed.  Just hook ->set_ios() e.g.

	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;

Then sdhci_omap_set_ios() can call sdhci_set_ios() and then do the bus mode
setting.

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fff0baadbc3e..d5050ec42481 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1747,6 +1747,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
>  		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  
> +	if (host->ops->set_bus_mode)
> +		host->ops->set_bus_mode(host, ios->bus_mode);
> +
>  	mmiowb();
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_ios);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d778034e324d..39c7a2723906 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -583,6 +583,7 @@ struct sdhci_ops {
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>  	void    (*card_event)(struct sdhci_host *host);
>  	void	(*voltage_switch)(struct sdhci_host *host);
> +	void	(*set_bus_mode)(struct sdhci_host *host, unsigned int mode);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 

