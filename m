From: Marc Koschewski <marc@osknowledge.org>
Subject: Re: [PATCH 1/1]mmc: fix division by zero when calculate mmc erase
 time
Date: Thu, 24 Feb 2011 12:37:56 +0100
Message-ID: <20110224113756.GB7260@marc.osknowledge.org>
References: <20110224111801.GA7169@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110224111801.GA7169@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, adrian.hunter@nokia.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

* Chuanxiao Dong <chuanxiao.dong@intel.com> [2011-02-24 19:18:01 +0800]:

> Since if clock gating feature is enabled, the clock frequency may be zero when
> host clock is gated. In such scenario, mmc_set_mmc_erase_timeout() may have a
> division by zero bug.
> 
> So this patch used mmc_host_clk_rate() to fix this.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/core/core.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 34a7e8c..12d0eb8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1201,8 +1201,14 @@ static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
>  		 * less but not that much less, so fudge it by multiplying by 2.
>  		 */
>  		timeout_clks <<= 1;
> -		timeout_us += (timeout_clks * 1000) /
> -			      (card->host->ios.clock / 1000);
> +
> +		/*
> +		 * at this moment, host controller maybe clock gated, so make
> +		 * sure we can get a correct host clock freq.
> +		 */
> +		if (mmc_host_clk_rate(card->host))
> +			timeout_us += (timeout_clks * 1000) /
> +				      (mmc_host_clk_rate(card->host) / 1000);

Why don't you just reuse mmc_host_clk_rate()'s result instead of calling it twice?

Cheers,
Marc

>  
>  		erase_timeout = timeout_us / 1000;
>  
> -- 
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Marc Koschewski
