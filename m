From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 13/41] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Tue, 23 May 2017 09:55:42 -0500
Message-ID: <20170523145542.s4y5r5t2uynnrv6f@rob-hp-laptop>
References: <20170519081541.26753-1-kishon@ti.com>
 <20170519081541.26753-14-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519081541.26753-14-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

On Fri, May 19, 2017 at 01:45:13PM +0530, Kishon Vijay Abraham I wrote:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [nsekhar@ti.com: introduce OMAP_HSMMC_SETUP_PINCTRL()]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   5 +
>  drivers/mmc/host/omap_hsmmc.c                      | 124 ++++++++++++++++++++-
>  include/linux/platform_data/hsmmc-omap.h           |   3 +
>  3 files changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 258e25af10f7..dcf0b777c031 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -20,6 +20,11 @@ Optional properties:
>  ti,dual-volt: boolean, supports dual voltage cards
>  <supply-name>-supply: phandle to the regulator device tree node
>  "supply-name" examples are "vmmc", "vmmc_aux" etc
> +pinctrl-names: Should be a list of pinctrl state names and can be "sdr104",
> +"hs200_1_8v", "ddr50", "sdr50", "sdr25", "sdr12", "hs", "ddr_1_8v" or
> +"default".
> +pinctrl-<num>: Phandle referencing pin configuration of the sd/emmc controller.
> +See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed

Binding looks fine, but...

> @@ -2388,6 +2427,73 @@ static inline struct omap_hsmmc_platform_data
>  }
>  #endif
>  
> +#define OMAP_HSMMC_SETUP_PINCTRL(capvar, capmask, mode)			\
> +	do {								\

This is kind of ugly. Why not make it a function. Just return 
pinctrl_state ptr.

> +		struct pinctrl_state *s = ERR_PTR(-ENODEV);		\
> +		char str[20];						\
> +		char *version = host->pdata->version;			\
> +									\
> +		if (!(mmc->capvar & (capmask)))				\
> +			break;						\
> +									\
> +		if (host->pdata->version) {				\
> +			sprintf(str, "%s-%s", #mode, version);		\
> +			s = pinctrl_lookup_state(host->pinctrl, str);	\
> +		}							\
> +									\
> +		if (IS_ERR(s)) {					\
> +			sprintf(str, "%s", #mode);			\
> +			s = pinctrl_lookup_state(host->pinctrl, str);	\
> +		}							\
> +									\
> +		if (IS_ERR(s)) {					\
> +			dev_err(host->dev, "no pinctrl state for %s "	\
> +				"mode\n", #mode);			\
> +			mmc->capvar &= ~(capmask);			\
> +		} else {						\
> +			host->mode##_pinctrl_state = s;			\
> +		}							\
> +									\
> +	} while (0)
> +
> +static int omap_hsmmc_get_iodelay_pinctrl_state(struct omap_hsmmc_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	if (!(host->pdata->controller_flags & OMAP_HSMMC_REQUIRE_IODELAY))
> +		return 0;
> +
> +	host->pinctrl = devm_pinctrl_get(host->dev);
> +	if (IS_ERR(host->pinctrl)) {
> +		dev_err(host->dev, "Cannot get pinctrl\n");
> +		return PTR_ERR(host->pinctrl);
> +	}
> +
> +	host->default_pinctrl_state = pinctrl_lookup_state(host->pinctrl,
> +							   "default");
> +	if (IS_ERR(host->default_pinctrl_state)) {
> +		dev_err(host->dev,
> +			"no pinctrl state for default mode\n");
> +		return PTR_ERR(host->default_pinctrl_state);
> +	}
> +
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_UHS_SDR104,	sdr104);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_UHS_DDR50,	ddr50);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_UHS_SDR50,	sdr50);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_UHS_SDR25,	sdr25);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_UHS_SDR12,	sdr12);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,	MMC_CAP_1_8V_DDR,	ddr_1_8v);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps,
> +				 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
> +				 hs);
> +	OMAP_HSMMC_SETUP_PINCTRL(caps2,	MMC_CAP2_HS200_1_8V_SDR,
> +				 hs200_1_8v);
> +
> +	host->pinctrl_state = host->default_pinctrl_state;
> +
> +	return 0;
> +}
> +
>  static int omap_hsmmc_probe(struct platform_device *pdev)
>  {
>  	struct omap_hsmmc_platform_data *pdata = pdev->dev.platform_data;
