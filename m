From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: omap_hsmmc: Add fclk frequency to debufs
Date: Wed, 18 Apr 2012 20:04:54 -0400
Message-ID: <87obqolh7d.fsf@laptop.org>
References: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
	<1334742553-11060-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35829 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2DSAEo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 20:04:44 -0400
In-Reply-To: <1334742553-11060-2-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Wed, 18 Apr 2012 15:19:12 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Viswanath Puttagunta <vishp@ti.com>

Hi,

On Wed, Apr 18 2012, Venkatraman S wrote:
> From: Viswanath Puttagunta <vishp@ti.com>
>
> Add mmc functional clock frequency to list of
> internal state variables to display for debug.
>
> Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d15b149..d046ba2 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1683,8 +1683,9 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>  	if (host->pdata->get_context_loss_count)
>  		context_loss = host->pdata->get_context_loss_count(host->dev);
>  
> -	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
> -			mmc->index, host->context_loss, context_loss);
> +	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\t%lu Hz\n\nregs:\n",
> +		mmc->index, host->context_loss, context_loss,

Minor nit, but it looks like this line breaks indentation.

> +			clk_get_rate(host->fclk));
>  
>  	if (host->suspended) {
>  		seq_printf(s, "host suspended, can't read registers\n");

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
