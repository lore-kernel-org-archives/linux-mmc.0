From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V3 06/10] mmc: cqhci: allow hosts to update dcmd cmd desc
Date: Thu, 14 Mar 2019 11:02:28 +0530
Message-ID: <8a90c2e5-fd0a-9ea3-59a5-c237c0003a3b@codeaurora.org>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-6-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-6-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 3/14/2019 3:15 AM, Sowjanya Komatineni wrote:
> This patch adds update_dcmd_desc interface to cqhci_host_ops to
> allow hosts to update any of the DCMD task descriptor attributes
> and parameters.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Thanks,

Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>

> ---
>   drivers/mmc/host/cqhci.c | 2 ++
>   drivers/mmc/host/cqhci.h | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index a8af682a9182..d59cb0a51964 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -537,6 +537,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>   		 CQHCI_ACT(0x5) |
>   		 CQHCI_CMD_INDEX(mrq->cmd->opcode) |
>   		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
> +	if (cq_host->ops->update_dcmd_desc)
> +		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
>   	*task_desc |= data;
>   	desc = (u8 *)task_desc;
>   	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 9e68286a07b4..8c8ec6f01c45 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -210,6 +210,8 @@ struct cqhci_host_ops {
>   	u32 (*read_l)(struct cqhci_host *host, int reg);
>   	void (*enable)(struct mmc_host *mmc);
>   	void (*disable)(struct mmc_host *mmc, bool recovery);
> +	void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
> +				 u64 *data);
>   };
>   
>   static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
