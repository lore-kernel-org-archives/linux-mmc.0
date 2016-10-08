From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/10] mmc: sdhci: Export
 sdhci_start_signal_voltage_switch() in sdhci.c
Date: Sat, 8 Oct 2016 10:40:26 +0800
Message-ID: <9bfe6e9a-c06e-481a-b5ea-af58820093bf@rock-chips.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <9a660a813af58ad7c108fd06289513302426c9fb.1475853198.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9a660a813af58ad7c108fd06289513302426c9fb.1475853198.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Keji Zhang <keji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Liuliu Zhao <zhaoliul@m>
List-Id: linux-mmc@vger.kernel.org

Hi,

ÔÚ 2016/10/7 23:22, Gregory CLEMENT Ð´µÀ:
> From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Export sdhci_start_signal_voltage_switch() from sdhci.c.
> Thus vendor sdhci driver can implement its own signal voltage
> switch routine.
>

You can overwtite this callback within your driver itself.
That is what other sdhci variant drivers did, so patch 1-3 are
unnecessary.

> Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 5 +++--
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d4bb818c52d5..2250ea22231f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1828,8 +1828,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -					     struct mmc_ios *ios)
> +int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +				      struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	u16 ctrl;
> @@ -1921,6 +1921,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		return 0;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_start_signal_voltage_switch);
>
>  static int sdhci_card_busy(struct mmc_host *mmc)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 21dc80b8ae3d..c38ab65b9a97 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -687,6 +687,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> +int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +				      struct mmc_ios *ios);
>
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host);
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
