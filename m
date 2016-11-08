From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 04/14] mmc: sdhci-msm: Change poor style writel/readl
 of registers
Date: Tue, 8 Nov 2016 15:07:24 -0800
Message-ID: <20161108230724.GO16026@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-5-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478517877-23733-5-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/07, Ritesh Harjani wrote:
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ef44a2a..42f42aa 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -137,8 +137,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
>  	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>  
>  	/* Set CK_OUT_EN bit of DLL_CONFIG register to 1. */
> -	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
> -			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
> +	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +	config |= CORE_CK_OUT_EN;
> +	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>  
>  	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
>  	rc = msm_dll_poll_ck_out_en(host, 1);
> @@ -305,6 +306,7 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	struct mmc_host *mmc = host->mmc;
>  	int wait_cnt = 50;
>  	unsigned long flags;
> +	u32 config = 0;

It needs to be initialized?

>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> @@ -313,33 +315,40 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	 * tuning is in progress. Keeping PWRSAVE ON may
>  	 * turn off the clock.
>  	 */
> -	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
> -			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
> +	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);

It's written here unconditionally though?

> +	config &= ~CORE_CLK_PWRSAVE;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
