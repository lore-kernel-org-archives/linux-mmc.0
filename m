From: "Beel, Koen" <Koen.Beel@barco.com>
Subject: mxs-mmc: sdio not working, keep resetting
Date: Fri, 10 Jun 2011 16:21:10 +0200
Message-ID: <35A77C07F2FC8D4293360737046C9EF3041DFB23@KUUMEX03.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail201.messagelabs.com ([216.82.254.211]:36060 "HELO
	mail201.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755519Ab1FJOY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2011 10:24:59 -0400
Content-Class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

We are using a Freescale i.MX233 and are running on mainline Linux.
A wifi chip company (Redpine Signals) is doing a port of their sdio driver for their Wifi module for our platform. But they are running into problems with the sdio.
We have tested the mxs-mmc port using normal sd card which is working, but now with sdio we keep on getting these error messages in our serial console:

[   45.180000] mmc0: new high speed SDIO card at address fffd 
[   46.200000] mmc0: card fffd removed 
[   46.370000] mmc0: new high speed SDIO card at address fffd 
[   47.390000] mmc0: card fffd removed 
[   47.560000] mmc0: new high speed SDIO card at address fffd 
[   48.580000] mmc0: card fffd removed 
[   48.750000] mmc0: new high speed SDIO card at address fffd 
[   49.770000] mmc0: card fffd
These are printed in drivers/mmc/core/bus.c:

void mmc_remove_card(struct mmc_card *card)
{
#ifdef CONFIG_DEBUG_FS
        mmc_remove_card_debugfs(card);
#endif

        if (mmc_card_present(card)) {
                if (mmc_host_is_spi(card->host)) {
                        printk(KERN_INFO "%s: SPI card removed\n",
                                mmc_hostname(card->host));
                } else {
                        printk(KERN_INFO "%s: card %04x removed\n",
                                mmc_hostname(card->host), card->rca);
                }
                device_del(&card->dev);
        }

        put_device(&card->dev);
}

This function is being invoked from mmc.c file from mmc_attach_mmc() in failure cases (label remove_card).
Normal SD cards are working, but the sdio seems to be causing issues.

Is this a known problem? 
We have tested this since linux 2.6.39-rc5 and now on mainline things are still the same.

Any idea on where to look for a solution?
Might this have something to do with a timeout which is triggering this?


Thanks
Koen Beel


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
