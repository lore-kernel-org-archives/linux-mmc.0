From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from sg->offset
Date: Wed, 22 Jan 2014 18:26:29 +0800
Message-ID: <52DF9CD5.6060707@gtsys.com.hk>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk> <20140122101137.GX15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.fpasia.hk ([202.130.89.98]:60799 "EHLO fpa01n0.fpasia.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbaAVKY7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jan 2014 05:24:59 -0500
In-Reply-To: <20140122101137.GX15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: s.hauer@pengutronix.de, mpa@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

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
I agree, and this patch should not apply to the kernel,, . Its my fix 
for my production mainboard
only.  I report the Oops but not get any response back. I'm sorry to 
wast your time.

Chris
