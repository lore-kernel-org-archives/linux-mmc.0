From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: fix space allocated for transfer
 descriptor
Date: Wed, 27 Feb 2019 15:34:13 +0200
Message-ID: <0a656a92-9652-d0f7-05ad-18f849efae4e@intel.com>
References: <20190225192214.3881-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190225192214.3881-1-alamy.liu@gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 25/02/19 9:22 PM, Alamy Liu wrote:
> There is not enough space being allocated when DCMD is disabled.
> 
> CQE_DCMD is not necessary to be enabled when CQE is enabled.
> (Software could halt CQE to send command)
> 
> In the case that CQE_DCMD is not enabled, it still needs to allocate
> space for data transfer. For instance:
>   CQE_DCMD is enabled:  31 slots space (one slot used by DCMD)
>   CQE_DCMD is disabled: 32 slots space
> 
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 4cc7863c13..974997b6cb 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>  
>  	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -		(cq_host->num_slots - 1);
> +		cq_host->mmc->cqe_qdepth;
>  
>  	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> 
