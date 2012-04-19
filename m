From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Thu, 19 Apr 2012 09:35:01 -0400
Message-ID: <87vckvkfp6.fsf@laptop.org>
References: <1334760358-17568-1-git-send-email-svenkatr@ti.com>
	<1334810595-20316-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54677 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab2DSNet (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 09:34:49 -0400
In-Reply-To: <1334810595-20316-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Thu, 19 Apr 2012 10:13:15 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Apr 19 2012, Venkatraman S wrote:
> mmc_execute_hpi should send the HPI command only
> once, only if the card is in PRG state.
>
> According to eMMC spec, the command's completion time is
> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
> defined to begin at the end of sending the command itself.
>
> Specify the default timeout for the actual sending of HPI
> command, and then use OUT_OF_INTERRUPT_TIME to wait for
> the transition out of PRG state.
>
> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
> 	v1->v2:	Fix formatting inside debug prints
>  drivers/mmc/core/core.c    |   44 ++++++++++++++++++++++++--------------------
>  drivers/mmc/core/mmc_ops.c |    1 -
>  2 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e541efb..d57c8f3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>  {
>  	int err;
>  	u32 status;
> +	unsigned long starttime;
>  
>  	BUG_ON(!card);
>  
> @@ -421,27 +422,30 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>  	/*
>  	 * If the card status is in PRG-state, we can send the HPI command.
>  	 */
> -	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> -		do {
> -			/*
> -			 * We don't know when the HPI command will finish
> -			 * processing, so we need to resend HPI until out
> -			 * of prg-state, and keep checking the card status
> -			 * with SEND_STATUS.  If a timeout error occurs when
> -			 * sending the HPI command, we are already out of
> -			 * prg-state.
> -			 */
> -			err = mmc_send_hpi_cmd(card, &status);
> -			if (err)
> -				pr_debug("%s: abort HPI (%d error)\n",
> -					 mmc_hostname(card->host), err);
> +	if (R1_CURRENT_STATE(status) != R1_STATE_PRG) {
> +		pr_debug("%s: Can't send HPI: Card state=%d\n",
> +			mmc_hostname(card->host), R1_CURRENT_STATE(status));
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
> -			err = mmc_send_status(card, &status);
> -			if (err)
> -				break;
> -		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> -	} else
> -		pr_debug("%s: Left prg-state\n", mmc_hostname(card->host));
> +	starttime = jiffies;
> +	err = mmc_send_hpi_cmd(card, &status);
> +	if (err) {
> +		pr_debug("%s:HPI could not be sent. err=%d\n",

You're still missing a space in "%s: HPI".

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
