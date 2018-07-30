From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 1/7] mmc: sdhci: add sd host v4 mode
Date: Mon, 30 Jul 2018 16:04:17 +0300
Message-ID: <87ecfb68-775a-2a17-5b42-ae02b354e3d7@intel.com>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-2-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532340508-8749-2-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 23/07/18 13:08, Chunyan Zhang wrote:
> For SD host controller version 4.00 or later ones, there're two
> modes of implementation - Version 3.00 compatible mode or
> Version 4 mode.  This patch introduced an interface to enable
> v4 mode.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  5 +++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0..cab5350 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -123,6 +123,30 @@ EXPORT_SYMBOL_GPL(sdhci_dumpregs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
> +{
> +	u16 ctrl2;
> +
> +	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
> +	if (ctrl2 & SDHCI_CTRL_V4_MODE)
> +		return;
> +
> +	ctrl2 |= SDHCI_CTRL_V4_MODE;
> +	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
> +}
> +
> +/*
> + * Vendor's Host Controller which supports v4 mode can call
> + * this function to enable v4 mode before calling
> + * __sdhci_add_host().
> + */
> +void sdhci_enable_v4_mode(struct sdhci_host *host)
> +{
> +	host->v4_mode = true;
> +	sdhci_do_enable_v4_mode(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
> +
>  static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>  	return cmd->data || cmd->flags & MMC_RSP_BUSY;
> @@ -224,6 +248,10 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  
>  		/* Resetting the controller clears many */
>  		host->preset_enabled = false;
> +
> +		if (host->v4_mode)
> +			sdhci_do_enable_v4_mode(host);

Instead of sdhci_do_reset() I would rather add this to sdhci_init() and
__sdhci_read_caps()

> +
>  	}
>  }
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f8..519d939 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -184,6 +184,7 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -565,6 +566,9 @@ struct sdhci_host {
>  
>  	u64			data_timeout;
>  
> +	/* Host Version 4 Enable */
> +	bool			v4_mode;

Let's put this with the other bools i.e. after bool irq_wake_enabled;

> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> @@ -747,5 +751,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  		   int *data_error);
>  
>  void sdhci_dumpregs(struct sdhci_host *host);
> +void sdhci_enable_v4_mode(struct sdhci_host *host);
>  
>  #endif /* __SDHCI_HW_H */
> 
