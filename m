From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RESEND RFC 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Tue, 10 Jan 2017 17:15:21 +0800
Message-ID: <7cfc2b6c-fa3f-a8cb-d684-472c3dbacf2f@rock-chips.com>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:40009 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758030AbdAJJQH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 04:16:07 -0500
In-Reply-To: <1484030515-16722-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

On 2017/1/10 14:41, Ritesh Harjani wrote:
> From: Sahitya Tummala <stummala@codeaurora.org>
>
> Add new host operation ->platform_dumpregs to provide a
> mechanism through which host drivers can dump platform
> specific registers in addition to SDHC registers
> during error conditions.
>

Although we have been preventing from adding new callback
for sdhci core, this one makes sense as there are more and more
vendor registers outside the scope of SDHCI spec.


> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2390980..73a8918 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -101,6 +101,9 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>  			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
>  	}
>
> +	if (host->ops->platform_dumpregs)
> +		host->ops->platform_dumpregs(host);
> +
>  	pr_err(DRIVER_NAME ": ===========================================\n");
>  }
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0b66f21..400f3a1 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -564,6 +564,7 @@ struct sdhci_ops {
>  					 struct mmc_card *card,
>  					 unsigned int max_dtr, int host_drv,
>  					 int card_drv, int *drv_type);
> +	void	(*platform_dumpregs)(struct sdhci_host *host);
>  };
>
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>


-- 
Best Regards
Shawn Lin

