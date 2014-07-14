From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [PATCH] mmc: blk: add emmc cache flush in shutdown callback
Date: Mon, 14 Jul 2014 11:09:08 +0000
Message-ID: <0AA7DC03D52A654FA5AF208AE38A967D01D53990@shsmsx102.ccr.corp.intel.com>
References: <1405330459-2335-1-git-send-email-yunpeng.gao@intel.com>
 <53C3A818.7030107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14068 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360AbaGNLJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jul 2014 07:09:12 -0400
In-Reply-To: <53C3A818.7030107@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Thanks a lot for the review and comments.

This patch was derived from our old mmc driver code base, which was based on kernel 3.10 and did not implemented the mmc_shutdown() callback in mmc.c yet.
So it added shutdown callback in drivers/mmc/card/block.c to fix data corruption issue observed at that time.

Since flush eMMC cache in mmc_shutdown() callback is better than in mmc_blk_shutdown(), I think my patch is not needed for current upstream mmc driver any more.
Please ignore it :-)

Thanks.

Regards,
Yunpeng

-----Original Message-----
From: Jaehoon Chung [mailto:jh80.chung@samsung.com] 
Sent: Monday, July 14, 2014 5:51 PM
To: Gao, Yunpeng; linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: blk: add emmc cache flush in shutdown callback

Hi,

On 07/14/2014 06:34 PM, Yunpeng Gao wrote:
> If eMMC Cache feature enabled, we'd better flush eMMC cache in the 
> shutdown callback. Otherwise data corruption issue may be observed.

I knew mmc_flush_cache() is called into mmc_shutdown() (driver/mmc/core/mmc.c) Which data corruption is occurred? Could you explain more?

Best Regards,
Jaehoon Chung 

> 
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> ---
>  drivers/mmc/card/block.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index 
> 452782b..8a4010e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2509,6 +2509,10 @@ static int _mmc_blk_suspend(struct mmc_card 
> *card)  static void mmc_blk_shutdown(struct mmc_card *card)  {
>  	_mmc_blk_suspend(card);
> +
> +	mmc_claim_host(card->host);
> +	mmc_flush_cache(card);
> +	mmc_release_host(card->host);
>  }
>  
>  #ifdef CONFIG_PM
> 

