From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 8 Jul 2010 14:46:26 -0700
Message-ID: <20100708144626.2091f6c1.akpm@linux-foundation.org>
References: <4C33DF98.10409@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50610 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755325Ab0GHVrE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2010 17:47:04 -0400
In-Reply-To: <4C33DF98.10409@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Wed, 07 Jul 2010 10:59:52 +0900
Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> This patch clears only necessary bit.
> 
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc.h |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 64f7d5d..7944604 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -82,10 +82,7 @@
> 
>  #define ack_mmc_irqs(host, i) \
>  	do { \
> -		u32 mask;\
> -		mask  = sd_ctrl_read32((host), CTL_STATUS); \
> -		mask &= ~((i) & TMIO_MASK_IRQ); \
> -		sd_ctrl_write32((host), CTL_STATUS, mask); \
> +		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
>  	} while (0)

Can we have a better changelog please?

What was wrong with the old code?

How does the patch fix it?

What are the user-visible runtime effects of the bug?

(It looks like that was a pretty gross bug - how did it pass testing??)
