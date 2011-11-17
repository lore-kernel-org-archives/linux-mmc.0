From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix typo at mmc_card_sleep
Date: Wed, 16 Nov 2011 23:41:18 -0500
Message-ID: <8762ijicnl.fsf@laptop.org>
References: <20111117043433.GA32665@july>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51755 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094Ab1KQElN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Nov 2011 23:41:13 -0500
In-Reply-To: <20111117043433.GA32665@july> (Kyungmin Park's message of "Thu,
	17 Nov 2011 13:34:33 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Wed, Nov 16 2011, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Fix wrong bus_ops->sleep check.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5278ffb..193e449 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2196,7 +2196,7 @@ int mmc_card_sleep(struct mmc_host *host)
>  
>  	mmc_bus_get(host);
>  
> -	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
> +	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
>  		err = host->bus_ops->sleep(host);
>  
>  	mmc_bus_put(host);
>

Thanks, applied to mmc-next for 3.2.

(My understanding is that this isn't going to have any real-world
consequences, since the only bus that defines awake or sleep is
core/mmc.c, and it defines both of them.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
