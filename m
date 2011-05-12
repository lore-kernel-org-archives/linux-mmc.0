From: Huang Changming-R66093 <R66093@freescale.com>
Subject: RE: [PATCH] mmc: duplicated trial with same freq when
 mmc_rescan_try_freq()
Date: Thu, 12 May 2011 08:57:45 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
References: <4DCB97F3.9060704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:31048
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795Ab1ELI6s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2011 04:58:48 -0400
In-Reply-To: <4DCB97F3.9060704@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, "andy.ross@windriver.com" <andy.ross@windriver.com>

The required min frequency (f_min) is 400KHz during identify stage, is it necessary to use the  frequency table (freqs[], including 300KHz, 200KHz and 100KHz)?

Thanks and Best Regards
Jerry Huang


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
> Sent: Thursday, May 12, 2011 4:19 PM
> To: linux-mmc@vger.kernel.org
> Cc: Chris Ball; Kyungmin Park; andy.ross@windriver.com
> Subject: [PATCH] mmc: duplicated trial with same freq when
> mmc_rescan_try_freq()
> 
> when running mmc_rescan_try_freq(), try to init two times with last
> frequency.
> For example, assume that host->f_min is 400KHz, we can find the below
> message.
> 
> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> 
> i didn't find to mention about this..why try to init the two times with
> same frequency?
> Is there any reason? If i missed the history, plz let me know them.
> 
> I think that trial is not necessary. Trial needs to running with other
> frequency.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 61c6c0b..a330c58 100644
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


