From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/9] mmc: sdhci: add a callback for using tuning block
Date: Thu, 2 Mar 2017 16:25:54 +0200
Message-ID: <ffa07436-541f-5ad2-60f4-347847fd6104@intel.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
 <1488448050-7574-5-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488448050-7574-5-git-send-email-yangbo.lu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, Xiaobo Xie <xiaobo.xie@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 02/03/17 11:47, Yangbo Lu wrote:
> Some non-standard SD host controllers may use tuning block
> for executing tuning procedure.

If you need to set something up before tuning, you should be able to do that
by hooking the host operation, for example see xenon_execute_tuning() in
sdhci-xenon.c

> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3c9a924..051b192 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2166,6 +2166,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		goto out_unlock;
>  	}
>  
> +	if (host->ops->set_tuning_block)
> +		host->ops->set_tuning_block(host);
> +
>  	host->mmc->retune_period = tuning_count;
>  
>  	sdhci_start_tuning(host);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 04af687..d43519b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -568,6 +568,7 @@ struct sdhci_ops {
>  					 int card_drv, int *drv_type);
>  	int	(*start_signal_voltage_switch)(struct sdhci_host *host,
>  					       unsigned char signal_voltage);
> +	void	(*set_tuning_block)(struct sdhci_host *host);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
