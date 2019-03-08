From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1 03/11] mmc: sdhci: add support for post tuning process
Date: Fri, 8 Mar 2019 13:55:11 +0200
Message-ID: <d3fa9c16-0561-e708-dec2-12d2526027cd@intel.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-3-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> This patch adds support for post tuning process needed for some hosts
> to perform after successful completion of HW tuning.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 +++++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9e919218006..976d4d1e2400 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2392,8 +2392,12 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  
>  		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> -			if (ctrl & SDHCI_CTRL_TUNED_CLK)
> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> +				if (host->ops->post_tuning)
> +					host->ops->post_tuning(host);
>  				return 0; /* Success! */

I think you can hook .execute_tuning and just check if the return value is
zero before doing post tuning. i.e. something like:

	host->mmc_host_ops.execute_tuning = tegra_sdhci_execute_tuning;

int tegra_sdhci_execute_tuning(blah)
{
	int err;

	err = sdhci_execute_tuning(blah);
	if (!err)
		tegra_sdhci_post_tuning(host);
}

> +			}
> +
>  			break;
>  		}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c80e0d6f9b10..236d67778645 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -639,6 +639,7 @@ struct sdhci_ops {
>  	void		(*reset)(struct sdhci_host *host, u8 mask);
>  	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>  	int	(*get_max_tuning_loop_count)(struct sdhci_host *host);
> +	void	(*post_tuning)(struct sdhci_host *host);
>  	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
> 
