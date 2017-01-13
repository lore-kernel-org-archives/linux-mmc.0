From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [RFC PATCH 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Fri, 13 Jan 2017 14:21:25 -0800
Message-ID: <20170113222125.GA22862@mini-rhel.redhat.com>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
 <1483097531-9991-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483097531-9991-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 30, 2016 at 05:02:09PM +0530, Ritesh Harjani wrote:
> From: Sahitya Tummala <stummala@codeaurora.org>
> 
> Add new host operation ->platform_dumpregs to provide a
> mechanism through which host drivers can dump platform
> specific registers in addition to SDHC registers
> during error conditions.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 4 insertions(+)
>

This change and 2/3 look like they can be squished together into
one patch.  At least that is how I did it, 

https://patchwork.kernel.org/patch/9442449/

-jeremy


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
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
> a Linux Foundation Collaborative Project.
> 
