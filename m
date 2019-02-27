From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: cqhci: Fix a tiny potential memory leak on
 error condition
Date: Wed, 27 Feb 2019 15:44:18 +0200
Message-ID: <81a6b332-f6ac-a6fe-15e9-c6cf96a4a603@intel.com>
References: <20190225192214.3881-1-alamy.liu@gmail.com>
 <20190225192214.3881-2-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190225192214.3881-2-alamy.liu@gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 25/02/19 9:22 PM, Alamy Liu wrote:
> Free up the allocated memory in the case of error return
> 
> --- code study ---
> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() seems to be designed to disable and free
> all resources, not suitable to handle this corner case.
> 
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..795893ba47 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -218,12 +218,21 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  						 cq_host->desc_size,
>  						 &cq_host->desc_dma_base,
>  						 GFP_KERNEL);
> +	if (!cq_host->desc_base)
> +		return -ENOMEM;
> +
>  	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
>  					      cq_host->data_size,
>  					      &cq_host->trans_desc_dma_base,
>  					      GFP_KERNEL);
> -	if (!cq_host->desc_base || !cq_host->trans_desc_base)
> +	if (!cq_host->trans_desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +				   cq_host->desc_base,
> +				   cq_host->desc_dma_base);
> +		cq_host->desc_base = NULL;
> +		cq_host->desc_dma_base = 0;
>  		return -ENOMEM;
> +	}
>  
>  	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> 
