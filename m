From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2 v2] mmc: tmio: fix CMD irq handling
Date: Wed, 5 Jan 2011 22:48:10 +0000
Message-ID: <20110105224810.GB13209@void.printf.net>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de> <1293628874-8140-3-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293628874-8140-3-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Wed, Dec 29, 2010 at 02:21:14PM +0100, Arnd Hannemann wrote:
> With current code card insert/eject interrupts will acknowledge outstanding
> commands. Normally this seems to be no problem, however if the hardware gets
> stuck and no interrupts for CMD_TIMEOUT or CMD_RESPEND are generated, then
> inserting and ejecting cards will falsely acknowledge outstanding commands from
> the core.
> 
> This patch changes the behavior so that CMDs are only acked, if
> CMD_TIMEOUT or CMD_RESPEND is received.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> ---
>  drivers/mmc/host/tmio_mmc.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index f980042..e4926c7 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -728,8 +728,10 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
>   */
>  
>  		/* Command completion */
> -		if (ireg & TMIO_MASK_CMD) {
> -			ack_mmc_irqs(host, TMIO_MASK_CMD);
> +		if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
> +			ack_mmc_irqs(host,
> +				     TMIO_STAT_CMDRESPEND |
> +				     TMIO_STAT_CMDTIMEOUT);
>  			tmio_mmc_cmd_irq(host, status);
>  		}
>  

Thanks, pushed to mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
