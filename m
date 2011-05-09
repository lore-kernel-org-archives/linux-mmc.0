From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference
 'idata'
Date: Mon, 9 May 2011 18:12:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
References: <4DC7F4AB.90607@gmail.com> <Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
 <4DC802C0.9040302@gmail.com> <Pine.LNX.4.64.1105091713080.15483@pc-004.diku.dk>
 <4DC8117C.7060200@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:38548 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab1EIQMM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2011 12:12:12 -0400
In-Reply-To: <4DC8117C.7060200@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Motyka <vladimir.motyka@gmail.com>
Cc: cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

I guess there is also a point at which idata has been successfully 
allocated but idata->buf has not.

julia


On Mon, 9 May 2011, Vladimir Motyka wrote:

> When allocation of idata fails there was a null dereference.
> 
> Signed-off-by: Vladimir Motyka <vladimir.motyka@gmail.com>
> ---
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 407836d..a03cdc6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -237,7 +237,7 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
>  	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
>  	if (!idata) {
>  		err = -ENOMEM;
> -		goto copy_err;
> +		goto alloc_err;
>  	}
> 
>  	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
> @@ -268,8 +268,8 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
>  copy_err:
>  	kfree(idata->buf);
>  	kfree(idata);
> +alloc_err:
>  	return ERR_PTR(err);
> -
>  }
> 
>  static int mmc_blk_ioctl_cmd(struct block_device *bdev,
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
