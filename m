From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v4] mmc: core: Fix the HPI execution sequence
Date: Thu, 21 Jun 2012 21:07:26 +0530
Message-ID: <003a01cd4fc3$c5e21ec0$51a65c40$@codeaurora.org>
References: <002d01cd4f9e$33cb7010$9b625030$@codeaurora.org> <1340287982-8534-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21995 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759462Ab2FUPhe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 11:37:34 -0400
In-Reply-To: <1340287982-8534-1-git-send-email-svenkatr@ti.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, subashj@codeaurora.org, 'Kostya' <kdorfman@codeaurora.org>

One comment inline below:

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Venkatraman S
> Sent: Thursday, June 21, 2012 7:43 PM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
> jh80.chung@samsung.com; alex.lemberg@sandisk.com;
> subashj@codeaurora.org; Venkatraman S; Kostya
> Subject: [PATCH v4] mmc: core: Fix the HPI execution sequence
> 
> mmc_execute_hpi should send the HPI command only once, and only if the
> card is in PRG state.
> 
> According to eMMC spec, the command's completion time is not dependent on
> OUT_OF_INTERRUPT_TIME. Only the transition out of PRG STATE is guarded by
> OUT_OF_INTERRUPT_TIME - which is defined to begin at the end of sending
> the command itself.
> 
> Specify the default timeout for the actual sending of HPI command, and
then
> use OUT_OF_INTERRUPT_TIME to wait for the transition out of PRG state.
> 
> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Kostya <kdorfman@codeaurora.org>
> ---
> v3->v4: Fix coding style issues as suggested by Chris Ball.
> 	Use time_after() for safe time diff calculations as
> 	 suggested by Subash Jadavani.
> 
>  drivers/mmc/core/core.c    |   55
++++++++++++++++++++++++++-----------------
> -
>  drivers/mmc/core/mmc_ops.c |    1 -
>  2 files changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 80ec427..0d4bb19 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)  {
>  	int err;
>  	u32 status;
> +	unsigned long prg_wait;
> 
>  	BUG_ON(!card);
> 
> @@ -419,30 +420,38 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>  		goto out;
>  	}
> 
> -	/*
> -	 * If the card status is in PRG-state, we can send the HPI command.
> -	 */
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
> +	switch (R1_CURRENT_STATE(status)) {
> +	case R1_STATE_IDLE:
> +	case R1_STATE_READY:
> +	case R1_STATE_STBY:
> +		/*
> +		 * In idle states, HPI is not needed and the caller
> +		 * can issue the next intended command immediately
> +		 */
> +		goto out;
> +	case R1_STATE_PRG:
> +		break;
> +	default:
> +		/* In all other states, it's illegal to issue HPI */
> +		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
> +			mmc_hostname(card->host),
> R1_CURRENT_STATE(status));
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
> +	prg_wait = jiffies +
msecs_to_jiffies(card->ext_csd.out_of_int_time);

According to commit text, you should be calculating timeout duration after
the HPI command is sent to card. So this prg_wait calculation should be
moved after mmc_send_hpi_cmd().

> +	err = mmc_send_hpi_cmd(card, &status);
> +	if (err)
> +		goto out;
> +
> +	do {
> +		err = mmc_send_status(card, &status);
> +
> +		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
> +			break;
> +		if (time_after(jiffies, prg_wait))
> +			err = -ETIMEDOUT;
> +	} while (!err);
> 
>  out:
>  	mmc_release_host(card->host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..0ed2cc5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
> *status)
> 
>  	cmd.opcode = opcode;
>  	cmd.arg = card->rca << 16 | 1;
> -	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
> 
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {
> --
> 1.7.10.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

