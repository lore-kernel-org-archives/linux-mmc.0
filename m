From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 05/14] mmc: sdhci-msm: Update DLL reset sequence
Date: Tue, 8 Nov 2016 15:06:22 -0800
Message-ID: <20161108230622.GN16026@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-6-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcKHXGY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 18:06:24 -0500
Content-Disposition: inline
In-Reply-To: <1478517877-23733-6-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org

On 11/07, Ritesh Harjani wrote:
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 42f42aa..32b0b79 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -58,11 +58,17 @@
>  #define CORE_DLL_CONFIG		0x100
>  #define CORE_DLL_STATUS		0x108
>  
> +#define CORE_DLL_CONFIG_2	0x1b4
> +#define CORE_FLL_CYCLE_CNT	BIT(18)
> +#define CORE_DLL_CLOCK_DISABLE	BIT(21)
> +
>  #define CORE_VENDOR_SPEC	0x10c
>  #define CORE_CLK_PWRSAVE	BIT(1)
>  
>  #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
>  
> +#define TCXO_FREQ		19200000

TCXO_FREQ could change based on the board. For example, IPQ has
it as 25 MHz.

> +
>  #define CDR_SELEXT_SHIFT	20
>  #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
>  #define CMUX_SHIFT_PHASE_SHIFT	24
> @@ -330,6 +349,24 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>  	msm_cm_dll_set_freq(host);
>  
> +	if (msm_host->use_14lpp_dll_reset) {
> +		u32 mclk_freq = 0;
> +
> +		if ((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
> +					& CORE_FLL_CYCLE_CNT))

I suggest you grow a local variable.

> +			mclk_freq = (u32)((host->clock / TCXO_FREQ) * 8);

Is the cast necessary?

> +		else
> +			mclk_freq = (u32)((host->clock / TCXO_FREQ) * 4);

Ditto

> +
> +		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +		config &= ~(0xFF << 10);
> +		config |= mclk_freq << 10;
> +
> +		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> +		/* wait for 5us before enabling DLL clock */

Usually there's a barrier between writel_relaxed() and delay
because we don't know when the writel will be posted out and the
delay is there to wait for the operation to happen. Probably
should change this to be a writel() instead.

> +		udelay(5);
> +	}
> +
>  	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
>  	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
>  	config &= ~CORE_DLL_RST;
> @@ -340,6 +377,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	config &= ~CORE_DLL_PDN;
>  	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>  
> +	if (msm_host->use_14lpp_dll_reset) {
> +		msm_cm_dll_set_freq(host);
> +		/* Enable the DLL clock */
> +		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +		config &= ~CORE_DLL_CLOCK_DISABLE;
> +		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> +	}
> +
>  	/* Set DLL_EN bit to 1. */
>  	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
>  	config |= CORE_DLL_EN;
> @@ -641,6 +686,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
>  		core_version, core_major, core_minor);
>  
> +	if ((core_major == 1) && (core_minor >= 0x42))

Why so many parenthesis?

> +		msm_host->use_14lpp_dll_reset = true;
> +
>  	/*

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
