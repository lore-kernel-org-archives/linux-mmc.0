From: Mahadev Cholachagudda <mgudda@gmail.com>
Subject: Re: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Wed, 30 Sep 2009 16:48:26 +0530
Message-ID: <bd31ea570909300418y4f12bf3bu2d145b94a93319e@mail.gmail.com>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com>
	 <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
	 <20090923102715.GA4307@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:55352 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZI3LSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 07:18:22 -0400
Received: by pxi32 with SMTP id 32so5365808pxi.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 04:18:26 -0700 (PDT)
In-Reply-To: <20090923102715.GA4307@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org
Cc: Pierre Ossman <pierre@ossman.eu>, Pierre Ossman <drzeus-list@drzeus.cx>

Dear Matt,
Thank you very much. Attached is the re-written patch with comments
included. This has been tested in our platform, where it recovers from
CMD12 cmd_conflict errors.

Regards,
Mahadev


diff -urNd linux-orig/drivers/mmc/card/block.c
linux-current/drivers/mmc/card/block.c
--- linux-orig/drivers/mmc/card/block.c	2009-09-16 15:43:03.667274139 +0530
+++ linux-current/drivers/mmc/card/block.c	2009-09-30 16:41:50.605273759 +0530
@@ -330,6 +330,67 @@

 		mmc_queue_bounce_post(mq);

+		/* cmd12 error recovery fix */
+		if( (brq.stop.error) && (brq.data.blocks > 1) &&
+				!mmc_host_is_spi(card->host) && mmc_card_sd(card) ) {
+
+			/*
+			 * if there is an error for CMD12, get the state of the card by
+			 * sending cmd13 and then check the state of the card.
+			 * If the card state is "tran", consider the cmd12 is successfull
+			 * If not, then send again CMD12 to stop the data transfer. This
+			 * time, any failure to get response, will result in to the card
+			 * being non-recoverable.
+			 */
+			memset(&cmd, 0, sizeof(struct mmc_command));
+			cmd.opcode = MMC_SEND_STATUS;
+			cmd.arg = card->rca << 16;
+			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+			mmc_wait_for_cmd(card->host, &cmd, 0);
+
+			if(!cmd.error && R1_CURRENT_STATE(cmd.resp[0]) == 4) {
+				/* card is in "trans" state, so treat the CMD12 as succesfull */
+				brq.stop.error = 0;
+			} else {
+				/*
+				 * card is not still in trans state. Now send CMD12 again and
+				 * repeat the process of checking the card status using CMD13
+				 */
+				memset(&cmd, 0, sizeof(struct mmc_command));
+				cmd.opcode = MMC_STOP_TRANSMISSION;
+				cmd.arg = 0;
+				cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+				mmc_wait_for_cmd(card->host, &cmd, 0);
+
+				/* get the card status */
+				memset(&cmd, 0, sizeof(struct mmc_command));
+				cmd.opcode = MMC_SEND_STATUS;
+				cmd.arg = card->rca << 16;
+				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+				mmc_wait_for_cmd(card->host, &cmd, 0);
+
+				if(!cmd.error) {
+					if(R1_CURRENT_STATE(cmd.resp[0]) == 4) {
+						/* card is in "trans" state, so treat the CMD12 as succesfull */
+						brq.stop.error = 0;
+					} else {
+						printk(KERN_ERR "%s: CMD12 error not recoverable\n",
+								req->rq_disk->disk_name );
+						/*
+						 * card is not in "trans" state yet. Just post an error and
+						 * error is not recoverable
+						 */
+					}
+				} else {
+					printk(KERN_ERR "%s: CMD13 returns an error!!\n",
+							req->rq_disk->disk_name );
+					/* error for cmd13!!, then something is wrong with the card */
+				}
+			}
+		}
+		/* cmd12 error recovery fix */
+
+
 		/*
 		 * Check for errors here, but don't jump to cmd_err
 		 * until later as we need to wait for the card to leave



2009/9/23 Matt Fleming <matt@console-pimps.org>:
> On Wed, Sep 16, 2009 at 04:09:11PM +0530, Mahadev Cholachagudda wrote:
>> Dear All,
>>
>> I've a kernel code base of 2.6.28.9, where in I find that CMD12 error
>> recovery is not been implemented. It is a wise idea to implement CMD12
>> error recovery, that involves sending CMD13 to get the status of the
>> card. If the card is in "trans" state, it means CMD12 error shall be
>> treated as successfull. If card state is not in "trans", then we have
>> to send CMD12 again to stop the data transfer and then checking of the
>> card status through CMD13. This sequence is detailed in the
>> "Simplified Host Controller specification" on SDCard website. I
>> believe this is the case for any controller, though I may be wrong.
>>
>> With the modification done to the code which is attached as patch to
>> the latest mmc git, it is working at our site. And we do see some
>> errors with the SDIO controller (proprietary but meets Standard SD
>> host controller specification) that we are using.
>>
>> Request you to comment on the patch.
>>
>
> In principal this patch seems OK. However, I recommend reading
> Documentation/CodingStyle and sending this patch again once you've fixed
> up the coding style and whitespace errors.
>
> Is there a specific reason that you have used mmc_wait_for_req() instead
> of mmc_wait_for_cmd() and reusing the "cmd" local variable? The empty
> "else" clauses can also probably be deleted.
>



-- 
Cheers,
Mahadev
