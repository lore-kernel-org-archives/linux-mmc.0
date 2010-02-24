From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mxcmmc: fixed max_seg_size value on initialization.
Date: Wed, 24 Feb 2010 12:35:47 -0800
Message-ID: <20100224123547.ab622be2.akpm@linux-foundation.org>
References: <1264506004-17827-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47129 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757966Ab0BXUgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2010 15:36:07 -0500
In-Reply-To: <1264506004-17827-1-git-send-email-vzapolskiy@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>

On Tue, 26 Jan 2010 14:40:04 +0300 Vladimir Zapolskiy <vzapolskiy@gmail.com> wrote:

> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pierre Ossman <pierre@ossman.eu>
> ---
>  drivers/mmc/host/mxcmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 60a2b69..faa7b76 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -708,7 +708,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>  	mmc->max_blk_size = 2048;
>  	mmc->max_blk_count = 65535;
>  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -	mmc->max_seg_size = mmc->max_seg_size;
> +	mmc->max_seg_size = mmc->max_req_size;
>  
>  	host = mmc_priv(mmc);
>  	host->base = ioremap(r->start, resource_size(r));

Please don't send unchangelogged patches.

I am not able to determine the user-visible impact of this bug hence I
am not able to determine which kernel(s) we should merge this patch
into.

