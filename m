From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference 'idata'
Date: Wed, 11 May 2011 00:03:39 -0400
Message-ID: <m31v0551es.fsf@pullcord.laptop.org>
References: <4DC7F4AB.90607@gmail.com>
	<Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
	<4DC802C0.9040302@gmail.com>
	<Pine.LNX.4.64.1105091713080.15483@pc-004.diku.dk>
	<4DC8117C.7060200@gmail.com>
	<Pine.LNX.4.64.1105091811320.15483@pc-004.diku.dk>
	<4DC85094.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35843 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab1EKEBd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 00:01:33 -0400
In-Reply-To: <4DC85094.4050401@gmail.com> (Vladimir Motyka's message of "Mon,
	09 May 2011 22:37:40 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Motyka <vladimir.motyka@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, May 09 2011, Vladimir Motyka wrote:
> When allocation of idata failed there was a null dereference. Also avoid
> calling kfree where it is needn't.
>
> ---
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 407836d..126c7f4 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -237,24 +237,24 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(

Thanks, I've pushed this version of the patch to mmc-next.

(The patch you sent was corrupted by gmail; it added a line break on the
last line quoted above where there shouldn't be one.  Please fix that
for next time.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
