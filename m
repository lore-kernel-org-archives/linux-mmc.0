From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/8] mmc: sdhci: add hooks for platform specific tuning
Date: Thu, 5 Sep 2013 11:14:04 +0800
Message-ID: <20130905031401.GA775@shlinux1.ap.freescale.net>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
 <1378299257-2980-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1378299257-2980-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, anton@enomsg.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 04, 2013 at 08:54:10PM +0800, Dong Aisheng wrote:
> The tuning of some platforms may not follow the standard host control
> spec v3.0, e.g. Freescale uSDHC on i.MX6Q/DL.
> Add a hook here to allow execute platform specific tuning instead of
> standard host controller tuning.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c |    8 ++++++++
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index dd2c083..2890cfd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1875,6 +1875,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		return 0;
>  	}
>  
> +	if (host->ops->platform_execute_tuning) {
> +		spin_unlock(&host->lock);
> +		enable_irq(host->irq);

Hmm, you want these two functions be called before
platform_execute_tuning()?  That probably means you do not need to call
spin_lock() and disable_irq() for platform_execute_tuning()?  In that
case, can we not just put this platform hook at the beginning of the
function, something like below?

	host = mmc_priv(mmc);

	if (host->ops->platform_execute_tuning) {
		sdhci_runtime_pm_get(host);
		err = host->ops->platform_execute_tuning(host, opcode);
		sdhci_runtime_pm_put(host);
	}

I guess that's more clear to tell that platform_execute_tuning hook is
there to replace sdhci_execute_tuning() completely.  Is it the case?

Shawn

> +		err = host->ops->platform_execute_tuning(host, opcode);
> +		sdhci_runtime_pm_put(host);
> +		return err;
> +	}
> +
>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
>  	/*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b037f18..976c14b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -288,6 +288,7 @@ struct sdhci_ops {
>  	unsigned int    (*get_ro)(struct sdhci_host *host);
>  	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
>  	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
> +	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>  	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
>  	void	(*platform_suspend)(struct sdhci_host *host);
> -- 
> 1.7.1
> 
> 
