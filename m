From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 3/4] mmc: sdhci-msm: Change the desc_sz on
 cqe_enable/disable.
Date: Thu, 31 Aug 2017 09:42:08 +0300
Message-ID: <10276dbc-81ec-5f4a-fa49-627b25e53ae2@intel.com>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
 <1504098251-27739-4-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504098251-27739-4-git-send-email-riteshh@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 30/08/17 16:04, Ritesh Harjani wrote:
> When CMDQ is halted the HW expects descriptor size to
> be same which is using in CMDQ mode.
> Thus adjust the desc_sz of sdhci accordingly.
> 
> Without this patch below command gives ADMA error
> when CQE is enabled.
> cat /sys/kernel/debug/mmc0/mmc0:0001/ext_csd
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 346cdfb..baa3409 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1111,9 +1111,29 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> +void sdhci_msm_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +		host->desc_sz = 12;

This has no effect.

> +
> +	sdhci_cqe_enable(mmc);
> +}
> +
> +void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +		host->desc_sz = 16;

You can't change the descriptor size this way.  If you need 128-bit ADMA
descriptors it must be done in sdhci_setup_host().

> +
> +	sdhci_cqe_disable(mmc, recovery);
> +}
> +
>  static const struct cqhci_host_ops sdhci_msm_cqhci_ops = {
> -	.enable		= sdhci_cqe_enable,
> -	.disable	= sdhci_cqe_disable,
> +	.enable		= sdhci_msm_cqe_enable,
> +	.disable	= sdhci_msm_cqe_disable,
>  };
>  
>  #ifdef CONFIG_MMC_CQHCI
> 
