From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] Powerpc eSDHC: Convert the cmd_timeou_ms to u64 to avoid
 overflow
Date: Mon, 26 Nov 2012 01:12:12 -0800
Message-ID: <20121126091212.GB11065@lizard>
References: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2KZJPb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 04:15:31 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7870843pbc.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Nov 2012 01:15:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

On Mon, Nov 26, 2012 at 04:35:58PM +0800, Haijun Zhang wrote:
> Convert the cmd_timeou_ms to u64 to avoid overflow
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

But I think you should merge the two patches...

Thanks,

> CC: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/card/block.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 21056b9..51903de 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -469,7 +469,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>  			 *     mrq.data = NULL;
>  			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
>  			 */
> -			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
> +			data.timeout_ns = (u64)idata->ic.cmd_timeout_ms *
> +						1000000;
>  		}
>  
>  		mrq.data = &data;
> -- 
> 1.7.0.4
