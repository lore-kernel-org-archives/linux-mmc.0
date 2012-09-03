From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 1/1] mmc: debugfs: Set frequency to maximum possible on
 higher request
Date: Mon, 03 Sep 2012 17:20:02 +0530
Message-ID: <5044996A.2050502@codeaurora.org>
References: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:40357 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab2ICLuH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Sep 2012 07:50:07 -0400
In-Reply-To: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinit Shenoy <vinit.shenoy@st.com>
Cc: cjb@laptop.org, per.forlin@linaro.org, andy.shevchenko@gmail.com, viresh.kumar@linaro.org, linux-mmc@vger.kernel.org, spear-devel@list.st.com

On 9/3/2012 4:38 PM, Vinit Shenoy wrote:
> Currently if we enter a frequency greater than maximum supported,
> -EINVAL is returned. Due to this clock is not switched to maximum
> supported frequency.
>
> For example consider the max supported frequency to be 48MHz
>
> echo 20000000 > /sys/kernel/debug/mmc0/clock Here clock is switched to 20Mhz.
>
> echo 80000000 > /sys/kernel/debug/mmc0/clock
> Ideally clock should be set back to 48MHz, but it is still set to 20MHz.
>
> This patch sets value to f_max when the requested frequency is greater
> than f_max
>
> Signed-off-by: Vinit Shenoy <vinit.shenoy@st.com>
> ---
>   drivers/mmc/core/debugfs.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9ab5b17..c71d3eb 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -174,7 +174,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
>   
>   	/* We need this check due to input value is u64 */
>   	if (val > host->f_max)
> -		return -EINVAL;
> +		val = host->f_max;

As such this is ok if you want this behaviour. But i see other issue 
which is not related to your patch.

Let's say if the host supports 400KHz, 25 MHz,  50MHz, 100MHz and 
currently card is operating in HS (High Speed) mode@50MHz. and now if 
someone tries to change the frequency to 100MHz, then we should just 
don't let the clock change to 100MHz before we put the card in 
appropriate bus speed mode (in SD cards case, it would be SDR50 and eMMC 
case it would be HS200). Although this is anyway not an issue created by 
your patch but this is just to let you know that frequency can't be 
changed indepently without informing the card beforehand.

As far as this patch is concerned, it looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

>   
>   	mmc_claim_host(host);
>   	mmc_set_clock(host, (unsigned int) val);

