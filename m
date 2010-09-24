From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch] sdhci: correct f_min in sd 3.0
Date: Fri, 24 Sep 2010 04:24:01 +0100
Message-ID: <20100924032401.GA10294@void.printf.net>
References: <AANLkTimp+4V9zvQtOqHoVmpH-+Vmb+0Sr1MzM-cNHAiC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46955 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab0IXDYG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 23:24:06 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimp+4V9zvQtOqHoVmpH-+Vmb+0Sr1MzM-cNHAiC@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

Hi,

On Mon, Sep 20, 2010 at 03:32:58AM -0400, zhangfei gao wrote:
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 15:15:18 -0400
> Subject: [PATCH 4/4] sdhci: correct f_min in sd 3.0
> 
> Change-Id: Ie8604dbb5296b15da67071164564f21c60652b60
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f980fb7..5346803 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1835,6 +1835,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  	mmc->ops = &sdhci_ops;
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
> +	else if (host->version >= SDHCI_SPEC_300)
> +		mmc->f_min = host->max_clk / 2046;
>  	else
>  		mmc->f_min = host->max_clk / 256;
>  	mmc->f_max = host->max_clk;

Oh, right -- it would be good to #define symbols for 256 and 2046,
since we're inserting them into sdhci.c for the second time.
Perhaps SDHCI_MAX_DIV_SPEC_{200,300}?

I can do that in a separate patch if you prefer, or you could roll
it into this one.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
