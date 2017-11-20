From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Optionally wait for signal level changes
Date: Mon, 20 Nov 2017 11:25:34 -0800
Message-ID: <20171120192534.GE18379@codeaurora.org>
References: <20171120183451.18966-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171120183451.18966-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>, Vijay Viswanath <vviswana@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 11/20, Bjorn Andersson wrote:
> Not all instances of the SDCC core supports changing signal voltage and
> as such will not generate a power interrupt when the software attempts
> to change the voltage. This results in probing the eMMC on some devices
> to take over 2 minutes.
> 
> Check that the SWITCHABLE_SIGNAL_VOLTAGE bit in MCI_GENERICS is set

T in SWITCHABLE_SIGNAL_VOLTAGE here.

> before waiting for the power interrupt.
> 
> Cc: Sahitya Tummala <stummala@codeaurora.org>
> Cc: Vijay Viswanath <vviswana@codeaurora.org>
> Fixes: c0309b3803fe ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> The offending patch is part of your v4.15 pull request, so please pick
> this up for the -rcs.
> 
>  drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3fb7d2eec93f..8f2dda73e6b4 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -29,6 +29,9 @@
>  #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
>  #define CORE_VERSION_MINOR_MASK		0xff
>  
> +#define CORE_MCI_GENERICS		0x70
> +#define SWICHABLE_SIGNALING_VOLTAGE	BIT(29)

But then the T isn't here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
