From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/7] mmc: sdhci: Add quirk for disabling DTO during erase
 command
Date: Thu, 24 Jan 2019 14:08:48 +0200
Message-ID: <8c5875db-016c-c416-7356-d7a26d8d2a0e@intel.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111110851.6805-5-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: zhang.chunyan@linaro.org, kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/01/19 1:08 PM, Faiz Abbas wrote:
> Some controllers might prematurely issue a data timeout during an erase
> command. Add a quirk to disable the interrupt when an erase command is
> issued.

I might have already asked this, but would it be possible to use the
existing SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk?

> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4a9044c06e21..cfd716aee552 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1560,6 +1560,14 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	/* Initially, a command has no error */
>  	cmd->error = 0;
>  
> +	if (cmd->opcode == MMC_ERASE &&
> +	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
> +		mask = sdhci_readl(host, SDHCI_INT_ENABLE);
> +		mask &= ~SDHCI_INT_DATA_TIMEOUT;
> +		sdhci_writel(host, mask, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
> +	}
> +
>  	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
>  	    cmd->opcode == MMC_STOP_TRANSMISSION)
>  		cmd->flags |= MMC_RSP_BUSY;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7a52823ebef4..d0c6d4fe5371 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -479,6 +479,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Controller needs to disable DTO for erase command */
> +#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 
