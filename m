From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: duplicated trial with same freq when mmc_rescan_try_freq()
Date: Fri, 13 May 2011 12:48:40 -0400
Message-ID: <m3k4duo8bb.fsf@pullcord.laptop.org>
References: <4DCB97F3.9060704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56454 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759634Ab1EMQqd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 May 2011 12:46:33 -0400
In-Reply-To: <4DCB97F3.9060704@samsung.com> (Jaehoon Chung's message of "Thu,
	12 May 2011 17:18:59 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, andy.ross@windriver.com

Hi Jaehoon,

On Thu, May 12 2011, Jaehoon Chung wrote:
> when running mmc_rescan_try_freq(), try to init two times with last frequency.
> For example, assume that host->f_min is 400KHz, we can find the below message.
>
> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
>
> i didn't find to mention about this..why try to init the two times with same frequency?
> Is there any reason? If i missed the history, plz let me know them.
>
> I think that trial is not necessary. Trial needs to running with other frequency.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 61c6c0b..a330c58 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1618,7 +1618,7 @@ void mmc_rescan(struct work_struct *work)
>  	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>  		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
>  			break;
> -		if (freqs[i] < host->f_min)
> +		if (freqs[i] <= host->f_min)
>  			break;
>  	}
>  	mmc_release_host(host);
>

Thanks, merged to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
