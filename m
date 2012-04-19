From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Thu, 19 Apr 2012 00:29:00 -0400
Message-ID: <877gxcl4z7.fsf@laptop.org>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
	<1334319854-5989-5-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59765 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab2DSE2s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 00:28:48 -0400
In-Reply-To: <1334319854-5989-5-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Fri, 13 Apr 2012 17:54:14 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 13 2012, Venkatraman S wrote:
> Try to send HPI only a fixed number of times till it is
> successful. One successful transfer is enough - but wait
> till the card comes out of transfer state.
> Return an error if the card was not in programming state to
> begin with - so that the caller knows that HPI was not sent.
>
> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/core/core.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e541efb..ceabef5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -401,7 +401,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
>   */
>  int mmc_interrupt_hpi(struct mmc_card *card)
>  {
> -	int err;
> +	int err, i;
>  	u32 status;
>  
>  	BUG_ON(!card);
> @@ -421,27 +421,29 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>  	/*
>  	 * If the card status is in PRG-state, we can send the HPI command.
>  	 */
> +	err = -EINVAL;
>  	if (R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> -		do {
> -			/*
> -			 * We don't know when the HPI command will finish
> -			 * processing, so we need to resend HPI until out
> -			 * of prg-state, and keep checking the card status
> -			 * with SEND_STATUS.  If a timeout error occurs when
> -			 * sending the HPI command, we are already out of
> -			 * prg-state.
> -			 */
> +		/* To prevent an infinite lockout, try to send HPI
> +		 * a fixed number of times and bailout if it can't
> +		 * succeed.
> +		 */
> +		for (i = 0; i < 10 && err != 0 ; i++)
>  			err = mmc_send_hpi_cmd(card, &status);
> -			if (err)
> +		/* Once HPI was sent successfully, the card is
> +		 * supposed to be back to transfer state.
> +		 */

Minor nit: for consistency, please always use:

                /*
                 * Kernel-style comment blocks.
                 */

.. even though they waste the first line.  :)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
