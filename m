From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: cqhci: Fix a tiny potential memory leak on error
 condition
Date: Thu, 31 Jan 2019 12:10:08 +0200
Message-ID: <a596ffb2-770c-08f8-f170-d69082876f14@intel.com>
References: <20190116002440.1678-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116002440.1678-1-alamy.liu@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16/01/19 2:24 AM, Alamy Liu wrote:
> In the error case:
>    either cq_host->desc_base
>        or cq_host->trans_desc_base
> might have been granted memory successfully.
> 
> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() is designed to disable and free all resources,
> not suitable to handle this corner case.
> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..58ad8cd613 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -223,7 +223,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  					      &cq_host->trans_desc_dma_base,
>  					      GFP_KERNEL);
>  	if (!cq_host->desc_base || !cq_host->trans_desc_base)
> -		return -ENOMEM;
> +		goto err_free_dma;
>  
>  	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> @@ -234,6 +234,24 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  		setup_trans_desc(cq_host, i);
>  
>  	return 0;
> +
> +err_free_dma:
> +	if (cq_host->desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +				   cq_host->desc_base,
> +				   cq_host->desc_dma_base);
> +		cq_host->desc_base = NULL;
> +		cq_host->desc_dma_base = 0;
> +	}
> +	if (cq_host->trans_desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->data_size,
> +				   cq_host->trans_desc_base,
> +				   cq_host->trans_desc_dma_base);
> +		cq_host->trans_desc_base = NULL;
> +		cq_host->trans_desc_dma_base = 0;
> +	}
> +
> +	return -ENOMEM;
>  }
>  
>  static void __cqhci_enable(struct cqhci_host *cq_host)
> 

Normally, error handling is done step-by-step e.g.

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 26d63594b7ea..d015b465ade4 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -217,12 +217,15 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 						 cq_host->desc_size,
 						 &cq_host->desc_dma_base,
 						 GFP_KERNEL);
+	if (!cq_host->desc_base)
+		return -ENOMEM;
+
 	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
 					      cq_host->data_size,
 					      &cq_host->trans_desc_dma_base,
 					      GFP_KERNEL);
-	if (!cq_host->desc_base || !cq_host->trans_desc_base)
-		return -ENOMEM;
+	if (!cq_host->trans_desc_base)
+		goto err_free_dma;
 
 	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
@@ -233,6 +236,13 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 		setup_trans_desc(cq_host, i);
 
 	return 0;
+
+err_free_dma:
+	dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
+			   cq_host->desc_base, cq_host->desc_dma_base);
+	cq_host->desc_base = NULL;
+	cq_host->desc_dma_base = 0;
+	return NULL;
 }
 
 static void __cqhci_enable(struct cqhci_host *cq_host)
