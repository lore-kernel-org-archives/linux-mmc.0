From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: cqhci: data size depending on queue depth
Date: Thu, 31 Jan 2019 11:53:11 +0200
Message-ID: <16f9aaea-2e6c-a754-5029-dfbc1a2edba7@intel.com>
References: <20190115191356.32714-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115191356.32714-1-alamy.liu@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 15/01/19 9:13 PM, Alamy Liu wrote:
> CQE_DCMD is not necessary to be enabled when CQE is enabled.
> (Software could halt CQE to send command, or via DCMD)
> 
> In the case that CQE_DCMD is not enabled, it still needs to allocate
> space for data transfer. For instance:
>   CQE_DCMD is enabled:  32 slots space
>   CQE_DCMD is disabled: 31 slots space (is good enough)

Is that the right way around?

If DCMD is enabled then we need 31 slots for data transfer and 1 for DCMD.
If DCMD is disabled then we need 32 slots for data transfer.

> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
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

So there is not enough being allocated for the !(mmc->caps2 &
MMC_CAP2_CQE_DCMD) case, which means this is a fix?  In that case, please
add a fixes tag, cc stable, and make the commit message clear that this is a
fix.

>  
>  	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> 
