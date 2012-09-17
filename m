From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v12] mmc: support BKOPS feature for eMMC
Date: Mon, 17 Sep 2012 06:30:46 -0400
Message-ID: <m3wqztx7op.fsf@pullcord.laptop.org>
References: <5056E25A.6070207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45397 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab2IQKao (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 06:30:44 -0400
In-Reply-To: <5056E25A.6070207@samsung.com> (Jaehoon Chung's message of "Mon,
	17 Sep 2012 17:42:02 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Minchan Kim <minchan@kernel.org>

Hi Jaehoon,

On Mon, Sep 17 2012, Jaehoon Chung wrote:
> @@ -2334,7 +2471,13 @@ int mmc_suspend_host(struct mmc_host *host)
>  	mmc_bus_get(host);
>  	if (host->bus_ops && !host->bus_dead) {
>  
> -		if (host->bus_ops->suspend)
> +		if (host->bus_ops->suspend) {
> +			if (mmc_card_doing_bkops(host->card)) {
> +				err = mmc_stop_bkops(host->card);
> +				if (err)
> +					goto out;
> +			}
> +		}
>  			err = host->bus_ops->suspend(host);
>  
>  		if (err == -ENOSYS || !host->bus_ops->resume) {

Something's gone very wrong with the closing brace here.  Maybe you want
the closing brace to be a line later than it is?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
