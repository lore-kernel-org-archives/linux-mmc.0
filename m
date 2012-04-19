From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Fix the HPI execution sequence
Date: Thu, 19 Apr 2012 10:52:36 +0900
Message-ID: <4F8F6FE4.5010303@samsung.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <1334760358-17568-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38242 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2DSBwz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 21:52:55 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2P00BFLEJER9H0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Apr 2012 10:52:54 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M2P00605EK5PH60@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Apr 2012 10:52:54 +0900 (KST)
In-reply-to: <1334760358-17568-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 04/18/2012 11:45 PM, Venkatraman S wrote:

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
>  drivers/mmc/core/core.c    |   44 ++++++++++++++++++++++++--------------------
>  drivers/mmc/core/mmc_ops.c |    1 -
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e541efb..4e696e6 100644
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
> +		pr_debug("%s:HPI could not be sent.err=%d)\n",
> +			mmc_hostname(card->host), err);
> +		goto out;
> +	}
> +
> +	do {
> +		err = mmc_send_status(card, &status);
> +
> +		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
> +			break;
> +		if (jiffies_to_msecs(jiffies - starttime) >=
> +			card->ext_csd.out_of_int_time)
> +			err = -ETIMEDOUT;
> +	} while (!err);
>  
>  out:
>  	mmc_release_host(card->host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..0ed2cc5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
>  
>  	cmd.opcode = opcode;
>  	cmd.arg = card->rca << 16 | 1;
> -	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
>  
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {


