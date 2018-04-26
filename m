From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 01/12] mmc: sdhci-omap: Fix when capabilities are
 obtained from SDHCI_CAPABILITIES reg
Date: Thu, 26 Apr 2018 10:57:33 +0300
Message-ID: <e083256d-96f8-3f1e-76d1-8062dcfd1a21@intel.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-2-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-2-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
> sdhci_omap_config_iodelay_pinctrl_state() requires caps and caps2 to be
> initialized (speed mode capabilities like UHS/HS200) before it is
> invoked. While mmc_of_parse() initializes caps/caps2 if capabilities is
> populated in device tree, it will remain uninitialized for capabilities
> obtained from SDHCI_CAPABILITIES register.
> Fix sdhci_omap_config_iodelay_pinctrl_state() to be used even while
> getting the capabilities from SDHCI_CAPABILITIES register by invoking
> sdhci_setup_host() before sdhci_omap_config_iodelay_pinctrl_state().
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 1456abd5eeb9..9bb53702e0e5 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -916,10 +916,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  		goto err_put_sync;
>  	}
>  
> -	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
> -	if (ret)
> -		goto err_put_sync;
> -
>  	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  					sdhci_omap_start_signal_voltage_switch;
> @@ -930,12 +926,23 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	sdhci_read_caps(host);
>  	host->caps |= SDHCI_CAN_DO_ADMA2;
>  
> -	ret = sdhci_add_host(host);
> +	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
>  
> +	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
>  	return 0;
>  
> +err_cleanup_host:
> +	sdhci_cleanup_host(host);
> +
>  err_put_sync:
>  	pm_runtime_put_sync(dev);
>  
> 
