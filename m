From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 13/14] mmc: sdhci-msm: Add calibration tuning for
 CDCLP533 circuit
Date: Mon, 14 Nov 2016 11:59:28 -0800
Message-ID: <20161114195928.GK5177@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-14-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479103248-9491-14-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/14, Ritesh Harjani wrote:
> @@ -575,6 +729,15 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
>  		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +	spin_unlock_irq(&host->lock);
> +	/* CDCLP533 HW calibration is only required for HS400 mode*/
> +	if (host->clock > CORE_FREQ_100MHZ &&
> +	    msm_host->tuning_done && !msm_host->calibration_done &&
> +	    (mmc->ios.timing == MMC_TIMING_MMC_HS400))

Drop useless parenthesis.

> +		if (!sdhci_msm_cdclp533_calibration(host))
> +			msm_host->calibration_done = true;
> +	spin_lock_irq(&host->lock);
>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
