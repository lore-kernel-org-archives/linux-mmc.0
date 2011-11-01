From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: fix the critical bug for multiple block read
Date: Tue, 01 Nov 2011 05:49:26 -0400
Message-ID: <m2d3dcb2ah.fsf@bob.laptop.org>
References: <4EAE7C76.1050104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36988 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab1KAJti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Nov 2011 05:49:38 -0400
In-Reply-To: <4EAE7C76.1050104@samsung.com> (Jaehoon Chung's message of "Mon,
	31 Oct 2011 19:46:14 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, paul@pwsan.com

Hi,

On Mon, Oct 31 2011, Jaehoon Chung wrote:
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4fd5723..1882149 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1037,7 +1037,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			brq->data.blocks = 1;
>  
>  		/* Some controllers can't do multiblock reads due to hw bugs */
> -		if (card->host->caps & MMC_CAP2_NO_MULTI_READ &&
> +		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
>  		    rq_data_dir(req) == READ)
>  			brq->data.blocks = 1;
>  	}
>

Already fixed in mmc-next, with a rebase.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
