From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from sg->offset
Date: Wed, 22 Jan 2014 15:47:24 +0800
Message-ID: <52DF778C.108@gtsys.com.hk>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk> <20140122064231.GZ16215@pengutronix.de> <52DF7114.9070609@gtsys.com.hk> <20140122072358.GE16215@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.fpasia.hk ([202.130.89.98]:55010 "EHLO fpa01n0.fpasia.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaAVHpy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jan 2014 02:45:54 -0500
In-Reply-To: <20140122072358.GE16215@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: mpa@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

On Wednesday, January 22, 2014 03:23 PM, Sascha Hauer wrote:
> On Wed, Jan 22, 2014 at 03:19:48PM +0800, Chris Ruehl wrote:
>> On Wednesday, January 22, 2014 02:42 PM, Sascha Hauer wrote:
>>> On Wed, Jan 22, 2014 at 12:32:39PM +0800, Chris Ruehl wrote:
>>>> Function mxcmci_request() throw an exception on a imx27 cpu.
>>>> This patch fix the problem by test the pointer before access it.
>>>>
>>>> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>>>> index f7199c8..8645d6a 100644
>>>> --- a/drivers/mmc/host/mxcmmc.c
>>>> +++ b/drivers/mmc/host/mxcmmc.c
>>>> @@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>>>>   		return 0;
>>>>   	for_each_sg(data->sg, sg, data->sg_len, i) {
>>>> -		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
>>>> +		if (sg && (sg->offset & 3 || sg->length & 3 || sg->length < 512)) {
>>> The question is why sg is NULL. I think this shouldn't happen.
>>>
>>> Sascha
>>>
>> Thats was my idea too. But had no time to debug it out.
>> As for_each_sg() iterate over the sg-list may its not set properly
>> before - In an earlier post
>> I ask for help but no-one returned so I quick fixed it.  Maybe now
>> the bell is loud enough ;-)
> Please try to track it further down. Does this happen every time you are
> in this function or does it happen only every once in a while? Does it
> happen in the first iteration of the loop? is it an SDIO card or regular
> SD card?
>
> Sascha
>
Its happened once in a while unexpected. I used a Kingston MicroSD HC 
Class 4
4/8GB and Samsung HC Class 10 16GB.
I was not able to debug it online, my boards are mounted in RFID reader. 
All I had was
the OOPS in the Serial output. After it happen I cannot access the board 
any more - doomed

Chris


