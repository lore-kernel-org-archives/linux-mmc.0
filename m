From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1 02/11] mmc: sdhci: allow host to specify maximum tuning
 loops
Date: Fri, 8 Mar 2019 13:50:23 +0200
Message-ID: <e433341a-3c31-a2f9-d7ff-848d6cfbaf99@intel.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-2-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> As per the Host Controller Standard Specification Version 4.20,
> limitation of tuning iteration count is removed as PLL locking
> time can be longer than UHS-1 tuning due to larger PVT fluctuation
> and it will result in increase of tuning iteration to complete the
> tuning.
> 
> This patch creates a hook get_max_tuning_loop_count to allow hosts
> to specify maximum tuning iterations and updates execute_tuning
> to use the specified maximum tuning iteration count.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8141ff9be03..e9e919218006 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2366,12 +2366,15 @@ EXPORT_SYMBOL_GPL(sdhci_send_tuning);
>  static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	int i;
> +	int tuning_loop_count = MAX_TUNING_LOOP;
>  
> +	if (host->ops->get_max_tuning_loop_count)
> +		tuning_loop_count = host->ops->get_max_tuning_loop_count(host);

I would prefer to make tuning_loop_count a sdhci_host member initialized to
MAX_TUNING_LOOP in sdhci_alloc_host().

Then hook .execute_tuning e.g.

	host->mmc_host_ops.execute_tuning = tegra_sdhci_execute_tuning;

and set up host->tuning_loop_count


>  	/*
>  	 * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
> -	 * of loops reaches 40 times.
> +	 * of loops reaches tuning loop count.
>  	 */
> -	for (i = 0; i < MAX_TUNING_LOOP; i++) {
> +	for (i = 0; i < tuning_loop_count; i++) {
>  		u16 ctrl;
>  
>  		sdhci_send_tuning(host, opcode);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 01002cba1359..c80e0d6f9b10 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -638,6 +638,7 @@ struct sdhci_ops {
>  	unsigned int    (*get_ro)(struct sdhci_host *host);
>  	void		(*reset)(struct sdhci_host *host, u8 mask);
>  	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
> +	int	(*get_max_tuning_loop_count)(struct sdhci_host *host);
>  	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
> 
