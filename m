From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 11/16] mmc: sdhci: Program a relatively accurate SW
 timeout value
Date: Fri, 16 Feb 2018 12:47:41 +0530
Message-ID: <aa30bb13-7271-a426-f606-59f21961806f@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-12-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205125029.21570-12-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Monday 05 February 2018 06:20 PM, Kishon Vijay Abraham I wrote:
> sdhci has a 10 second timeout to catch devices that stop responding.
> Instead of programming 10 second arbitrary value, calculate the total time
> it would take for the entire transfer to happen and program the timeout
> value accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0489572d1892..d52f9e7eabe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -673,6 +673,37 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd,
> +				  unsigned int target_timeout)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned long long transfer_time;
> +	struct mmc_ios *ios = &mmc->ios;
> +	unsigned char bus_width = ios->bus_width;

This should have been 1 << ios->bus_width.

-Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
