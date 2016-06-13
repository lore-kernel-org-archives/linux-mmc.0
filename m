From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback
 function
Date: Mon, 13 Jun 2016 11:46:20 +0300
Message-ID: <575E72DC.5090604@intel.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465456218-28354-6-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/06/16 10:10, Gregory CLEMENT wrote:
> From: Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Some host controller such as Xenon needs additional setting when
> switching signal voltage in eMMC mode. They also need to re-enable
> internal clock before a voltage switch.
> 
> This commit adds a callback routine "voltage_switch_pre" in the struct
> sdhci_ops, which is used by some host controllers which need re-enable
> the internal clock before a voltage switch.

Don't want to add sdhci host ops for the "do something before a mmc host op"
case.

Instead, export sdhci_start_signal_voltage_switch() and  hook
host->mmc_host_ops.start_signal_voltage_switch. Then in sdhci-xenon.c:

int xenon__start_signal_voltage_switch(struct mmc_host *mmc,
				       struct mmc_ios *ios)
{
	blah blah
	return sdhci_start_signal_voltage_switch(mmc, ios);
}


> 
> [gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: split the initial commit and
> reformulate the log]
> 
> Signed-off-by: Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b07219426d39..cad03ffa9d9b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1729,6 +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
> +	/* Some controller need to do more before switching */
> +	if (host->ops->voltage_switch_pre)
> +		host->ops->voltage_switch_pre(host);
> +
>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  
>  	switch (ios->signal_voltage) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 49c6c5b0e33b..6bec1b0368d2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -550,6 +550,7 @@ struct sdhci_ops {
>  					 unsigned int max_dtr, int host_drv,
>  					 int card_drv, int *drv_type);
>  	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
> +	void	(*voltage_switch_pre)(struct sdhci_host *host);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
