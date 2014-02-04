From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from sg->offset
Date: Tue, 04 Feb 2014 15:03:33 +0800
Message-ID: <52F090C5.3070300@gtsys.com.hk>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk> <20140122101137.GX15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.fpasia.hk ([202.130.89.98]:37419 "EHLO fpa01n0.fpasia.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbaBDHCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Feb 2014 02:02:02 -0500
In-Reply-To: <20140122101137.GX15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: mpa@pengutronix.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

On Wednesday, January 22, 2014 06:11 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 22, 2014 at 12:32:39PM +0800, Chris Ruehl wrote:
>> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> index f7199c8..8645d6a 100644
>> --- a/drivers/mmc/host/mxcmmc.c
>> +++ b/drivers/mmc/host/mxcmmc.c
>> @@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>>   		return 0;
>>   
>>   	for_each_sg(data->sg, sg, data->sg_len, i) {
>> -		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
>> +		if (sg && (sg->offset & 3 || sg->length & 3 || sg->length < 512)) {
> sg should never be NULL here - so this is probably papering over a bug.
>

I'd had some time and look into the meaning of the sg->xx & 0x3 and 
understand this
check validate the alignment of the data. If failed the dma handling is 
canceled and a fall-back to pio is done.

In a earlier patch for the unexpected dma & interrupts are synchronized 
using the spinlock. I pickup this
idea and protect the setup-data using a look. Until now the oops are gone.

PLEASE comment!

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 8645d6a..b11d3c4 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host 
*host, struct mmc_data *data)
                 return 0;

         for_each_sg(data->sg, sg, data->sg_len, i) {
-               if (sg && (sg->offset & 3 || sg->length & 3 || 
sg->length < 512)) {
+               if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
                         host->do_dma = 0;
                         return 0;
                 }
@@ -800,9 +800,12 @@ static void mxcmci_request(struct mmc_host *mmc, 
struct mmc_request *req)
         struct mxcmci_host *host = mmc_priv(mmc);
         unsigned int cmdat = host->cmdat;
         int error;
+       unsigned long flags;

         WARN_ON(host->req != NULL);

+       spin_lock_irqsave(&host->lock, flags);
+
         host->req = req;
         host->cmdat &= ~CMD_DAT_CONT_INIT;

@@ -813,6 +816,7 @@ static void mxcmci_request(struct mmc_host *mmc, 
struct mmc_request *req)
                 error = mxcmci_setup_data(host, req->data);
                 if (error) {
                         req->cmd->error = error;
+                       spin_unlock_irqrestore(&host->lock, flags);
                         goto out;
                 }

@@ -823,6 +827,8 @@ static void mxcmci_request(struct mmc_host *mmc, 
struct mmc_request *req)
                         cmdat |= CMD_DAT_CONT_WRITE;
         }

+       spin_unlock_irqrestore(&host->lock, flags);



With kind regards
Chris


