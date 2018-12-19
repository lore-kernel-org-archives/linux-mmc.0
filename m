From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1] mmc: cqhci: DMA Configuration prior to CQE
Date: Wed, 19 Dec 2018 11:04:11 +0200
Message-ID: <15dbfe38-f9fe-fbb1-2c98-a60c0101200a@intel.com>
References: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14/12/18 8:21 PM, Sowjanya Komatineni wrote:
> eMMC-5.1 JESD85-B51 Spec (Section 6.6.39), mentions DMA selection

There is no JESD85-B51.  I presume you mean JESD84-B51, but I can't find any
reference to DMA in 6.6.39.  All the host controller relevant material seems
to be in Annex B.  Can you clarify this reference?

> and DMA Block size configuration on SDHCI Host need to be done
> prior to enabling Command Queue Engine.
> 
> This patch fixes the sequence to follow the spec.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947cf..f701342e7212 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -248,6 +248,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  	}
>  
> +	if (cq_host->ops->enable)
> +		cq_host->ops->enable(mmc);
> +
>  	cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
>  
>  	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
> @@ -273,9 +276,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	mmc->cqe_on = true;
>  
> -	if (cq_host->ops->enable)
> -		cq_host->ops->enable(mmc);
> -
>  	/* Ensure all writes are done before interrupts are enabled */
>  	wmb();
>  
> @@ -561,6 +561,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	int tag = cqhci_tag(mrq);
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	unsigned long flags;
> +	u32 cqcfg = 0;
>  
>  	if (!cq_host->enabled) {
>  		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
> @@ -579,8 +580,19 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> +		/* Configuration must not be changed while enabled */
> +		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> +		if (cqcfg & CQHCI_ENABLE) {
> +			cqcfg &= ~CQHCI_ENABLE;
> +			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +		}
> +
>  		if (cq_host->ops->enable)
>  			cq_host->ops->enable(mmc);
> +
> +		cqcfg |= CQHCI_ENABLE;
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
>  	}
>  
>  	if (mrq->data) {
> 
