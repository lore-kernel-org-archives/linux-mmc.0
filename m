From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
Date: Thu, 20 Dec 2018 14:37:46 +0200
Message-ID: <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
 <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/12/18 1:42 AM, Sowjanya Komatineni wrote:
> eMMC-5.1 JESD84-B51 Spec (Section 6.6.39.1), mentions "Prior to
> enabling command queuing, the block size shall be set to 512 B.
> Device may respond with an error to CMD46/CMD47 if block size
> is not 512 B".

This doesn't seem to relate to the host controller implementation.  "The
device" means the eMMC.

We don't want to disable and re-enable in the request function, so that
change is not good for controllers that don't have your problem.  Another
thing to consider is that the block size register may not need to be changed
- for example when cqhci is halted to allow a manual discard, the block size
register is not updated, so I would expect its value to be unchanged.

There are ways you can solve this in your driver.  You could look at using
SDHCI I/O accessors, and/or implement your own ->enable() instead of calling
sdhci_cqe_enable() directly.  Would that be feasible?

> 
> This patch fixes the sequence to follow exact as per the spec.
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
