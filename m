From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] omap-mmc: Fix possible NULL pointer deref
Date: Mon, 11 Apr 2011 17:02:54 -0400
Message-ID: <m3y63ga4ch.fsf@pullcord.laptop.org>
References: <1299089903.13604.19.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1299089903.13604.19.camel@marge> (Michael Buesch's message of
	"Wed, 02 Mar 2011 19:18:23 +0100")
Sender: linux-omap-owner@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 02 2011, Michael Buesch wrote:
> Either OMAP_MMC_STAT_CARD_ERR or OMAP_MMC_STAT_END_OF_CMD might
> fire if there is no host->cmd pointer.
> Check for a valid host->cmd pointer before calling mmc_omap_cmd_done().
>
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> Fixes
>
> [    3.814483] Unable to handle kernel NULL pointer dereference at virtual address 00000018
> ...
> [    3.841247] CPU: 0    Not tainted  (2.6.38-rc6 #5)
> [    3.846374] PC is at mmc_omap_cmd_done+0x1c/0x154
> [    3.851379] LR is at mmc_omap_cmd_done+0x1c/0x154
> ...
> [    4.140014] [<c0234af0>] (mmc_omap_cmd_done+0x1c/0x154) from [<c0234ea4>] (mmc_omap_irq+0x27c/0x32c)
> [    4.149749] [<c0234ea4>] (mmc_omap_irq+0x27c/0x32c) from [<c008645c>] (handle_IRQ_event+0x24/0xe4)
> [    4.159332] [<c008645c>] (handle_IRQ_event+0x24/0xe4) from [<c0087dac>] (handle_level_irq+0xbc/0x13c)
> [    4.169158] [<c0087dac>] (handle_level_irq+0xbc/0x13c) from [<c002b070>] (asm_do_IRQ+0x70/0x94)
> [    4.178466] [<c002b070>] (asm_do_IRQ+0x70/0x94) from [<c003016c>] (__irq_svc+0x4c/0xb8)
>
>
> Index: linux-omap-2.6/drivers/mmc/host/omap.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mmc/host/omap.c	2011-02-27 12:32:03.051061690 +0100
> +++ linux-omap-2.6/drivers/mmc/host/omap.c	2011-02-27 12:32:27.622530875 +0100
> @@ -832,7 +832,7 @@
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (end_command)
> +	if (end_command && host->cmd)
>  		mmc_omap_cmd_done(host, host->cmd);
>  	if (host->data != NULL) {
>  		if (transfer_error)
>
>

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
