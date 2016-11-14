From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 08/14] mmc: sdhci-msm: Implement set_clock callback
 for sdhci-msm
Date: Mon, 14 Nov 2016 11:37:22 -0800
Message-ID: <20161114193004.GI5177@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-9-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934507AbcKNThZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 14:37:25 -0500
Content-Disposition: inline
In-Reply-To: <1479103248-9491-9-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org

On 11/14, Ritesh Harjani wrote:
> @@ -577,6 +578,90 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>  	return SDHCI_MSM_MIN_CLOCK;
>  }
>  
> +/**
> + * __sdhci_msm_set_clock - sdhci_msm clock control.
> + *
> + * Description:
> + * Implement MSM version of sdhci_set_clock.
> + * This is required since MSM controller does not
> + * use internal divider and instead directly control
> + * the GCC clock as per HW recommendation.
> + **/
> +void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +	unsigned long timeout;
> +
> +	/*
> +	 * Keep actual_clock as zero -
> +	 * - since there is no divider used so no need of having actual_clock.
> +	 * - MSM controller uses SDCLK for data timeout calculation. If
> +	 *   actual_clock is zero, host->clock is taken for calculation.
> +	 */
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	/*
> +	 * MSM controller do not use clock divider.
> +	 * Thus read SDHCI_CLOCK_CONTROL and only enable
> +	 * clock with no divider value programmed.
> +	 */
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 20 ms */
> +	timeout = 20;
> +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +		& SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout == 0) {
> +			pr_err("%s: Internal clock never stabilised\n",
> +			       mmc_hostname(host->mmc));
> +			return;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

This is almost a copy/paste of sdhci_set_clock(). Can we make
sdhci_set_clock() call a __sdhci_set_clock() function that takes
unsigned int clock, and also a flag indicating if we want to set
the internal clock divider or not? Then we can call
__sdhci_set_clock() from sdhci_set_clock() with (clock, true) as
arguments and (clock, false).

> +}
> +
> +/* sdhci_msm_set_clock - Called with (host->lock) spinlock held. */
> +static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int rc;
> +
> +	if (!clock) {
> +		msm_host->clk_rate = clock;
> +		goto out;
> +	}
> +
> +	spin_unlock_irq(&host->lock);
> +	if (clock != msm_host->clk_rate) {

Why do we need to check here? Can't we call clk_set_rate()
Unconditionally?

> +		rc = clk_set_rate(msm_host->clk, clock);
> +		if (rc) {
> +			pr_err("%s: Failed to set clock at rate %u\n",
> +			       mmc_hostname(host->mmc), clock);
> +			spin_lock_irq(&host->lock);
> +			goto out;

Or replace the above two lines with goto err;

> +		}
> +		msm_host->clk_rate = clock;
> +		pr_debug("%s: Setting clock at rate %lu\n",
> +			 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
> +	}

And put an err label here.

> +	spin_lock_irq(&host->lock);
> +out:
> +	__sdhci_msm_set_clock(host, clock);
> +}
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
