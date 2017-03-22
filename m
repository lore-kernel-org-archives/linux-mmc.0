From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 04/14] mmc: sdhci: Export sdhci_set_ios() from sdhci.c
Date: Wed, 22 Mar 2017 16:48:43 +0200
Message-ID: <05648b8f-26e8-8af7-5544-6e8ef1df7c43@intel.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <b95bc01da68874afbf85968d6181c60508fc56ff.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b95bc01da68874afbf85968d6181c60508fc56ff.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw@semihalf.c>
List-Id: linux-mmc@vger.kernel.org

On 14/02/17 19:01, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Export sdhci_set_ios() in sdhci.c.
> Thus vendor sdhci driver can implement its own set_ios() routine.
> 
> Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 23909804ffb8..0e9ed0fadff9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1570,7 +1570,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>  
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
> @@ -1730,6 +1730,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_ios);
>  
>  static int sdhci_get_cd(struct mmc_host *mmc)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0b66f210ae82..3563c0c384ca 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -691,6 +691,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host);
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
