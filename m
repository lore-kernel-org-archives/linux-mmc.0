From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCHv1 6/8] mmc: sdhci: Clear SDHCI_HS400_TUNING flag
 after platform_execute_tuning
Date: Thu, 19 Jan 2017 12:10:26 +0200
Message-ID: <540a0163-f6ea-494d-b90f-f818f8030153@intel.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <1484031652-12059-7-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484031652-12059-7-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de
List-Id: linux-mmc@vger.kernel.org

On 10/01/17 09:00, Ritesh Harjani wrote:
> Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
> so that platform_execute_tuning may use it if needed.

Sorry for the slow reply.

platform_execute_tuning() should not really exist because it doesn't do
anything useful.

If it is not too much trouble please consider just hooking
->execute_tuning() directly i.e.

	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;

Then you can use and clear the flag in sdhci_msm_execute_tuning().

> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2390980..2658f89 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2114,7 +2114,6 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
> -	host->flags &= ~SDHCI_HS400_TUNING;
>  
>  	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
>  		tuning_count = host->tuning_count;
> @@ -2156,7 +2155,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	if (host->ops->platform_execute_tuning) {
>  		spin_unlock_irqrestore(&host->lock, flags);
> -		return host->ops->platform_execute_tuning(host, opcode);
> +		err = host->ops->platform_execute_tuning(host, opcode);
> +		spin_lock_irqsave(&host->lock, flags);
> +		goto out_unlock;
>  	}
>  
>  	host->mmc->retune_period = tuning_count;
> @@ -2167,6 +2168,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	sdhci_end_tuning(host);
>  out_unlock:
> +	host->flags &= ~SDHCI_HS400_TUNING;
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	return err;
> 
