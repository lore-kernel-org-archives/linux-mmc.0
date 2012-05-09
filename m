From: kdorfman@codeaurora.org
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 9 May 2012 06:17:02 -0700 (PDT)
Message-ID: <edaffb8a034e4ed87b2f7c63d759c1d2.squirrel@www.codeaurora.org>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:36712 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759392Ab2EINRD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 09:17:03 -0400
In-Reply-To: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Namjae Jeon <linkinjeon@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>

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
> CC: Namjae Jeon <linkinjeon@gmail.com>
> CC: Jae hoon Chung <jh80.chung@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> Changes since v1:
> 	Skip looping over send_status indefinitely
> 	Correct the interpretation of OUT_OF_INTERRUPT_TIME
>
>  drivers/mmc/core/core.c    |   45
> ++++++++++++++++++++++++--------------------
>  drivers/mmc/core/mmc_ops.c |    2 +-
>  2 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e541efb..027c579 100644
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
> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card)
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
You can't return error here, because the card status may be:
0 = Idle 1 = Ready 2 = Ident 3 = Stby 4 = Tran 5 = Data 6 = Rcv 7 = Prg 8
= Dis 9 = Btst 10
Not every value is error here: the card state may be Idle/Ready and then
you do not need to return error.


> +
> +	starttime = jiffies;
> +	err = mmc_send_hpi_cmd(card, &status);
> +	if (err) {
> +		pr_debug("%s:HPI could not be sent.err=%d)\n",
> +			mmc_hostname(card->host), err);
> +		goto out;
> +	}
> +
> +	do {
> +		err = mmc_send_status(card, &status);
> +
> +		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
> +			goto out;
> +		if (jiffies_to_msecs(jiffies - starttime) >
> +			card->ext_csd.out_of_int_time)
> +			err = -ETIMEDOUT;
> +	} while (!err);
>
> -			err = mmc_send_status(card, &status);
> -			if (err)
> -				break;
> -		} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> -	} else
> -		pr_debug("%s: Left prg-state\n", mmc_hostname(card->host));
>
>  out:
>  	mmc_release_host(card->host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..f2235d6 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -569,7 +569,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
> *status)
>
>  	cmd.opcode = opcode;
>  	cmd.arg = card->rca << 16 | 1;
> -	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
> +	cmd.cmd_timeout_ms = 0;
>
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {
> --
> 1.7.10.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Thanks,
Kostya
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum





