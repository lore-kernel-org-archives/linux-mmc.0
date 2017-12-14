From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 06/12] mmc: sdhci_omap: Add support to set IODELAY values
Date: Thu, 14 Dec 2017 07:04:57 -0800
Message-ID: <20171214150457.GH14441@atomide.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-7-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171214130941.26666-7-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [171214 13:13]:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.
...

> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -105,6 +109,20 @@ struct sdhci_omap_host {
>  	struct sdhci_host	*host;
>  	u8			bus_mode;
>  	u8			power_mode;
> +	u8			timing;
> +	u8			flags;
> +
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pinctrl_state;
> +	struct pinctrl_state	*default_pinctrl_state;
> +	struct pinctrl_state	*sdr104_pinctrl_state;
> +	struct pinctrl_state	*hs200_1_8v_pinctrl_state;
> +	struct pinctrl_state	*ddr50_pinctrl_state;
> +	struct pinctrl_state	*sdr50_pinctrl_state;
> +	struct pinctrl_state	*sdr25_pinctrl_state;
> +	struct pinctrl_state	*sdr12_pinctrl_state;
> +	struct pinctrl_state	*hs_pinctrl_state;
> +	struct pinctrl_state	*ddr_1_8v_pinctrl_state;
>  };


You can make the pinctrl code more generic by allocating an array
of states and have just:

	struct pinctrl_state **pinctrl_state;

Then access it with omap_host->pinctrl_state[MMC_TIMING_MMC_HS200]
and so on.

This way the code gets simplified and you can do a generic function
to initialize things and call it from a for loop etc.

Just remember that pinctrl use can be optional as the pins can be
set up in the bootloader alone. Then you can just continue with the
default iodelay state like we are currently doing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
