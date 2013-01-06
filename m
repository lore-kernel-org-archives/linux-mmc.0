From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH 1/2] mmc: sdhci: update timeout clock setting if SDCLK
 is used
Date: Sun, 6 Jan 2013 10:17:41 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E119CA9F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1357464704-17419-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:7745 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752660Ab3AFKSI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Jan 2013 05:18:08 -0500
In-Reply-To: <1357464704-17419-1-git-send-email-kliu5@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Huang Changming-R66093 <r66093@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, "keyuan.liu@gmail.com" <keyuan.liu@gmail.com>

Hi, Kevin

My host also has this quirk(SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK), I had sent a patch use the same way as yours to calculate the max_discard_to and host->timeout_clk. But I place the code in host->ops->set_clock which in my sdhci-esdhci.h. also my host has quirk SDHCI_QUIRK_NONSTANDARD_CLOCK, just return in the beginning.

So if you can place this code in the beginning of the function, it will also work for my host, and one of my patch will no need to be merge. Also it will work for other host with the same quirk.

if (host->ops->set_clock) {
	host->ops->set_clock(host, clock);
	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
		return;
}

BTW, I have a card: MMC + PLUS 256MB Kingston. Its max_dtr was 26MHz so after calculate the real-clock, we can get the working clock 25MHz, but it will encounter timeout when cmd25 send. All other cmds work fine.
One method I found was to reduce its clock to 16MHz, it work with no issue for all cmds. Did you met this issue before? 


Regards
Haijun.


> -----Original Message-----
> From: Kevin Liu [mailto:kliu5@marvell.com]
> Sent: Sunday, January 06, 2013 5:32 PM
> To: linux-mmc@vger.kernel.org; Chris Ball; Andy Shevchenko; Mark Brown;
> Adrian Hunter
> Cc: Philip Rakity; Aaron Lu; Shawn Guo; Ulf Hansson; Johan Rudholm;
> Daniel Drake; Guennadi Liakhovetski; Huang Changming-R66093; Alexander
> Stein; Girish K S; Zhang Haijun-B42677; Viresh Kumar; Heiko Stuebner;
> Thomas Abraham; Chander Kashyap; Jaehoon Chung; Sebastian Hesselbarth;
> Zhangfei Gao; Haojian Zhuang; Chao Xie; keyuan.liu@gmail.com; Kevin Liu
> Subject: [PATCH 1/2] mmc: sdhci: update timeout clock setting if SDCLK is
> used
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
> ---
>  drivers/mmc/host/sdhci.c |   38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 04af0fd..c13415c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1159,8 +1159,14 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  		div >>= 1;
>  	}
> 
> -	if (real_div)
> +	if (real_div) {
>  		host->mmc->actual_clock = (host->max_clk * clk_mul) /
> real_div;
> +		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
> +			host->timeout_clk = host->mmc->actual_clock / 1000;
> +			host->mmc->max_discard_to =
> +				(1 << 27) / host->timeout_clk;
> +		}
> +	}
> 
>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) @@ -
> 2828,23 +2834,21 @@ int sdhci_add_host(struct sdhci_host *host)
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
> -		}
> +	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
> +					SDHCI_TIMEOUT_CLK_SHIFT;
> +		if (host->timeout_clk == 0) {
> +			if (host->ops->get_timeout_clock) {
> +				host->timeout_clk =
> +					host->ops->get_timeout_clock(host);
> +			} else {
> +				pr_err("%s: Hardware doesn't specify timeout "
> +					"clock frequency.\n", mmc_hostname(mmc));
> +				return -ENODEV;
> +			}
> +		} else if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> +			host->timeout_clk *= 1000;
>  	}
> -	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> -		host->timeout_clk *= 1000;
> -
> -	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> -		host->timeout_clk = mmc->f_max / 1000;
> 
>  	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> 
> --
> 1.7.9.5
> 


