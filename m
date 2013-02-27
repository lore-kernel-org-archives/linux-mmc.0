From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH RESEND v4 1/2] mmc: sdhci: update timeout clock setting
 if SDCLK is used
Date: Wed, 27 Feb 2013 07:35:23 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E1209B3A@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1359113698-14014-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:38974
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab3B0Hfn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Feb 2013 02:35:43 -0500
In-Reply-To: <1359113698-14014-1-git-send-email-kliu5@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Huang Changming-R66093 <r66093@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

Is there any feedback about this patch?
We also need this patch.


Regards
Haijun.


> -----Original Message-----
> From: Kevin Liu [mailto:kliu5@marvell.com]
> Sent: Friday, January 25, 2013 7:35 PM
> To: linux-mmc@vger.kernel.org; Chris Ball; Andy Shevchenko; Ulf Hansson
> Cc: Nicolas Pitre; Adrian Hunter; Philip Rakity; Aaron Lu; Shawn Guo;
> Johan Rudholm; Daniel Drake; Guennadi Liakhovetski; Huang Changming-
> R66093; Alexander Stein; Girish K S; Zhang Haijun-B42677; Viresh Kumar;
> Heiko Stuebner; Thomas Abraham; Chander Kashyap; Jaehoon Chung; Sebastian
> Hesselbarth; Zhangfei Gao; Haojian Zhuang; Chao Xie; Kevin Liu; Kevin Liu
> Subject: [PATCH RESEND v4 1/2] mmc: sdhci: update timeout clock setting
> if SDCLK is used
> 
> 1. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, getting timeout
> through register or callback function is useless. So skip current
> redundant code.
> 2. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, host uses SDCLK
> instead of TMCLK for data timeouts. So host->timeout_clk and mmc-
> >max_discard_to should be updated accordingly when SDCLK changed.
> 3. If callback function get_timeout_clock is used, the timeout clock will
> be returned directly and no need to multiply by the timeout clock unit
> read from register.
> 
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++++++++-------------
> ---
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 04af0fd..c31c30e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1082,6 +1082,11 @@ static void sdhci_finish_command(struct sdhci_host
> *host)
>  	}
>  }
> 
> +static inline void sdhci_set_max_discard_to(struct sdhci_host *host) {
> +	host->mmc->max_discard_to = (1 << 27) / host->timeout_clk; }
> +
>  static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> {
>  	int div = 0; /* Initialized for compiler warning */ @@ -1094,6
> +1099,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned
> int clock)
> 
>  	host->mmc->actual_clock = 0;
> 
> +	if ((host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) && clock)
> {
> +		/* The lowest permitted timeout clock frequency is 1Khz */
> +		host->timeout_clk = DIV_ROUND_UP(clock, 1000);
> +		sdhci_set_max_discard_to(host);
> +	}
> +
>  	if (host->ops->set_clock) {
>  		host->ops->set_clock(host, clock);
>  		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) @@ -2828,25
> +2839,25 @@ int sdhci_add_host(struct sdhci_host *host)
>  	} else
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
> 
> -	host->timeout_clk =
> -		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
> -	if (host->timeout_clk == 0) {
> -		if (host->ops->get_timeout_clock) {
> -			host->timeout_clk = host->ops->get_timeout_clock(host);
> -		} else if (!(host->quirks &
> -				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> -			pr_err("%s: Hardware doesn't specify timeout clock "
> -			       "frequency.\n", mmc_hostname(mmc));
> -			return -ENODEV;
> +	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
> +					SDHCI_TIMEOUT_CLK_SHIFT;
> +		if (host->timeout_clk == 0) {
> +			if (host->ops->get_timeout_clock) {
> +				host->timeout_clk =
> +					host->ops->get_timeout_clock(host);
> +			}
> +			if (host->timeout_clk == 0) {
> +				pr_err("%s: Hardware doesn't specify timeout "
> +					"clock frequency.\n", mmc_hostname(mmc));
> +				return -ENODEV;
> +			}
> +		} else if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT) {
> +			host->timeout_clk *= 1000;
>  		}
> +		sdhci_set_max_discard_to(host);
>  	}
> -	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> -		host->timeout_clk *= 1000;
> -
> -	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> -		host->timeout_clk = mmc->f_max / 1000;
> 
> -	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> 
>  	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
> 
> --
> 1.7.9.5
> 


