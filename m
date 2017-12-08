From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: blk-mq: Potential NULL deref on
 mmc_blk_alloc_req() failure
Date: Fri, 8 Dec 2017 14:02:25 +0200
Message-ID: <c8db220d-4ec6-3cad-ce11-92342aeb93d3@intel.com>
References: <20171208115516.3h55rvjq54hyfecq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:3084 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752209AbdLHMCr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Dec 2017 07:02:47 -0500
In-Reply-To: <20171208115516.3h55rvjq54hyfecq@mwanda>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

On 08/12/17 13:55, Dan Carpenter wrote:
> mmc_blk_alloc_req() is supposed to return error pointers but there is
> one path where we forget to set the error code and accidentally return
> NULL.  The callers are not expecting that and will have a NULL pointer
> dereference.
> 
> Fixes: 23da8bed11f2 ("mmc: block: Simplify cleaning up the queue")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ab384ba6cb37..6af2b660b1f7 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3037,6 +3037,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	 */
>  	if (!blk_get_queue(md->queue.queue)) {
>  		mmc_cleanup_queue(&md->queue);
> +		ret = -ENODEV;
>  		goto err_putdisk;
>  	}
>  
> 

