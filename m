From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: remove the MMC_DATA_STREAM flag
Date: Mon, 25 Jan 2016 11:10:26 +0900
Message-ID: <56A58412.8060401@samsung.com>
References: <56978FBF.1080509@samsung.com> <87y4bgb2iu.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57221 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbcAYCKs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2016 21:10:48 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1H01A77KPKUB50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 25 Jan 2016 11:10:32 +0900 (KST)
In-reply-to: <87y4bgb2iu.fsf@belgarion.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fabio Estevam <fabio.estevam@freescale.com>, Ben Dooks <ben-linux@fluff.org>, Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Shyti <andi.shyti@samsung.com>

Hi, Robert.

On 01/24/2016 02:59 AM, Robert Jarzmik wrote:
> Jaehoon Chung <jh80.chung@samsung.com> writes:
> 
>> It's not set to MMC_DATA_STREAM anywhere.
>> It seems that it had used with CMD11/20. But now CMD11/20 didn't also use.
>> I didn't know what is exactly, so i sent the patch as just RFC. 
>> If i get some comments for this, i will resend the patch after separate to each host controller.
>>
>> If MMC_DATA_STREAM can be removed, then flags of data should be then one of
>> MMC_DATA_READ and MMC_DATA_WRITE.
> The commit message won't pass checkpatch, will it ?

As you know, I mentioned if i get other comments, i will resend the patch.
This patch is RFC patch.

> 
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1525,13 +1525,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>  	}
>>  	if (rq_data_dir(req) == READ) {
>>  		brq->cmd.opcode = readcmd;
>> -		brq->data.flags |= MMC_DATA_READ;
>> +		brq->data.flags = MMC_DATA_READ;
> Why this chunk ? If the caller had already set some flags of its own, why
> overwrite them ? That has no connection to MMC_DATA_STREAM I can see.

If MMC_DATA_STREAM is removed, there are only two flags MMC_DATA_READ and MMC_DATA_WRITE.
Are there other flags, except MMC_DATA_READ, MMC_DATA_WRITE?
READ and WRITE can not use together.

If i missed other flags, let me know, plz. 

Best Regards,
Jaehoon Chung

> ...
>> -		brq->data.flags |= MMC_DATA_WRITE;
>> +		brq->data.flags = MMC_DATA_WRITE;
> Ditto.
>> -	brq->data.flags |= MMC_DATA_WRITE;
>> +	brq->data.flags = MMC_DATA_WRITE;
> Ditto.
> 
> ... drivers not within my area zapped ...
> 
>> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
>> index ce08896..4285d3a 100644
>> --- a/drivers/mmc/host/pxamci.c
>> +++ b/drivers/mmc/host/pxamci.c
> Works for me.
> 
> Cheers.
> 

