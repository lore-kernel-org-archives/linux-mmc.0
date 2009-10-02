From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Fri, 2 Oct 2009 11:20:02 +0100
Message-ID: <20091002102002.GA6687@console-pimps.org>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com> <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com> <20090923102715.GA4307@console-pimps.org> <bd31ea570909300418y4f12bf3bu2d145b94a93319e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:39383 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909AbZJBKTZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 06:19:25 -0400
Content-Disposition: inline
In-Reply-To: <bd31ea570909300418y4f12bf3bu2d145b94a93319e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mahadev Cholachagudda <mgudda@gmail.com>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>

[Pierre, I dropped your old email address from CC, hope that's OK]

On Wed, Sep 30, 2009 at 04:48:26PM +0530, Mahadev Cholachagudda wrote:
> Dear Matt,
> Thank you very much. Attached is the re-written patch with comments
> included. This has been tested in our platform, where it recovers from
> CMD12 cmd_conflict errors.
> 

I may be looking at an out of date SD Host Controller Spec, but can you
point me at the place where it says that it's ok to retry the CMD12 if
it failed? I can find the part explaining that you can issue CMD13 to
see if CMD12 really failed or not, but not the place where it says you
can reissue CMD12.

In your testcase, do you always end up issuing the second CMD12?

> 
> diff -urNd linux-orig/drivers/mmc/card/block.c
> linux-current/drivers/mmc/card/block.c
> --- linux-orig/drivers/mmc/card/block.c	2009-09-16 15:43:03.667274139 +0530
> +++ linux-current/drivers/mmc/card/block.c	2009-09-30 16:41:50.605273759 +0530
> @@ -330,6 +330,67 @@
> 
>  		mmc_queue_bounce_post(mq);
> 
> +		/* cmd12 error recovery fix */
> +		if( (brq.stop.error) && (brq.data.blocks > 1) &&
> +				!mmc_host_is_spi(card->host) && mmc_card_sd(card) ) {

Are you sure that this recovery procedure is not valid over SPI when
doing a multiblock read?

> +
> +			/*
> +			 * if there is an error for CMD12, get the state of the card by
> +			 * sending cmd13 and then check the state of the card.
> +			 * If the card state is "tran", consider the cmd12 is successfull

"successfull" should be "successful"

> +			 * If not, then send again CMD12 to stop the data transfer. This
> +			 * time, any failure to get response, will result in to the card
> +			 * being non-recoverable.
> +			 */
> +			memset(&cmd, 0, sizeof(struct mmc_command));
> +			cmd.opcode = MMC_SEND_STATUS;
> +			cmd.arg = card->rca << 16;
> +			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +			mmc_wait_for_cmd(card->host, &cmd, 0);
> +
> +			if(!cmd.error && R1_CURRENT_STATE(cmd.resp[0]) == 4) {
> +				/* card is in "trans" state, so treat the CMD12 as succesfull */
> +				brq.stop.error = 0;
> +			} else {
> +				/*
> +				 * card is not still in trans state. Now send CMD12 again and
> +				 * repeat the process of checking the card status using CMD13
> +				 */
> +				memset(&cmd, 0, sizeof(struct mmc_command));
> +				cmd.opcode = MMC_STOP_TRANSMISSION;
> +				cmd.arg = 0;
> +				cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +				mmc_wait_for_cmd(card->host, &cmd, 0);
> +
> +				/* get the card status */
> +				memset(&cmd, 0, sizeof(struct mmc_command));
> +				cmd.opcode = MMC_SEND_STATUS;
> +				cmd.arg = card->rca << 16;
> +				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +				mmc_wait_for_cmd(card->host, &cmd, 0);
> +
> +				if(!cmd.error) {
> +					if(R1_CURRENT_STATE(cmd.resp[0]) == 4) {
> +						/* card is in "trans" state, so treat the CMD12 as succesfull */
> +						brq.stop.error = 0;
> +					} else {
> +						printk(KERN_ERR "%s: CMD12 error not recoverable\n",
> +								req->rq_disk->disk_name );
> +						/*
> +						 * card is not in "trans" state yet. Just post an error and
> +						 * error is not recoverable
> +						 */
> +					}
> +				} else {
> +					printk(KERN_ERR "%s: CMD13 returns an error!!\n",
> +							req->rq_disk->disk_name );
> +					/* error for cmd13!!, then something is wrong with the card */

I'm not entirely sure any of these errors are needed. The code below
this in drivers/mmc/card/block.c will print an error message if
brq.stop.error is non-zero (and we will have left it non-zero if we
haven't recovered).
