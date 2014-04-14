From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix status error for Kingston brand SD cards
Date: Mon, 14 Apr 2014 17:08:47 +0900
Message-ID: <534B978F.7090704@samsung.com>
References: <1395957622-3428-1-git-send-email-dinguyen@altera.com>
 <000401cf4a81$d9433250$8bc996f0$%jun@samsung.com>
 <1396022007.32715.4.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46909 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbaDNIIt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 04:08:49 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4000ENRHAOCS60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Apr 2014 17:08:48 +0900 (KST)
In-reply-to: <1396022007.32715.4.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dinh.linux@gmail.com, linux-mmc@vger.kernel.org

Hi, Dinh.

On 03/29/2014 12:53 AM, Dinh Nguyen wrote:
> On Fri, 2014-03-28 at 21:32 +0900, Seungwon Jeon wrote:
>> Hi Dinh,
>>
>> On Fri, March 28, 2014, Dinh Nguyen wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> commits [90c2143a8f mmc: dw_mmc: guarantee stop-abort cmd in data errors]
>>> and [e352c813110 mmc: dw_mmc: rework the code related to cmd/data completion]
>>> cause the SD/MMC DMA interface to stop working on Kingston brand SD cards.
>>>
>>> ---
>>> Hi Seungwon,
>>>
>>> I am seeing this error on v3.13 kernel of the dw_mmc driver:
>>>
>>> mmc0: problem reading SD Status register.
>>> mmc0: error -110 whilst initialising SD card
>>>
>>> I only see this error on a Kingston brand card, although I have heard reports
>>> that it also fails a Samsung card. Also it only fails when with
>>> CONFIG_MMC_DW_IDMAC=y.
>>>
>>> The patch below seems to fix it for me. Any chance you have seen this error?
>> I didn't see but I'll try to find it.
>> And do you have any analysis for this issue?
> 
> Thanks. Here's the debug output that I am seeing. 

I didn't know what difference is "without patch" and "with patch".
Is it always occurred the data-error?
I didn't find this issue yet. Did you fix it without applied patch?

Best Regards,
Jaehoon Chung
> 
> With patch applied:
> 
> [    2.503394] mmc0: req done (CMD51): 0: 00000920 00000000 00000000
> 00000000
> [    2.510239] mmc0:     8 bytes transferred: 0
> [    2.514519] mmc0: starting CMD55 arg 00070000 flags 00000095
> [    2.520452] mmc0: req done (CMD55): 0: 00000920 00000000 00000000
> 00000000
> [    2.527324] mmc0: starting CMD13 arg 00000000 flags 000001b5
> [    2.532974] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [    2.541526] dwmmc_socfpga ff704000.dwmmc0: data error, status
> 0x00000800
> [    2.548203] mmc0: req done (CMD13): 0: 00000920 00000000 00000000
> 00000000
> [    2.555057] mmc0:     0 bytes transferred: -5
> [    2.559410] mmc0: problem reading SD Status register.
> [    2.564459] mmc0: starting CMD6 arg 00fffff0 flags 000000b5
> [    2.570008] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [    2.578703] mmc0: req done (CMD6): 0: 00000900 00000000 00000000
> 00000000
> [    2.585471] mmc0:     64 bytes transferred: 0
> [    2.589829] mmc_host mmc0: card is read-write
> [    2.594182] mmc0: starting CMD6 arg 80fffff1 flags 000000b5
> [    2.599733] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [    2.609308] mmc0: req done (CMD6): 0: 00000900 00000000 00000000
> 00000000
> [    2.616076] mmc0:     64 bytes transferred: 0
> [    2.620434] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
> width 0 timing 2
> [    2.628076] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21
> width 0 timing 2
> 
> 
> Without patch:
> 
> [    2.503381] mmc0: req done (CMD51): 0: 00000920 00000000 00000000
> 00000000
> [    2.510226] mmc0:     8 bytes transferred: 0
> [    2.514505] mmc0: starting CMD55 arg 00070000 flags 00000095
> [    2.520437] mmc0: req done (CMD55): 0: 00000920 00000000 00000000
> 00000000
> [    2.527309] mmc0: starting CMD13 arg 00000000 flags 000001b5
> [    2.532960] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [    2.541509] dwmmc_socfpga ff704000.dwmmc0: data error, status
> 0x00000080
> [    2.548185] mmc0: req done (CMD13): 0: 00000920 00000000 00000000
> 00000000
> [    2.555038] mmc0:     0 bytes transferred: -84
> [    2.559477] mmc0: problem reading SD Status register.
> [    2.564528] mmc0: starting CMD6 arg 00fffff0 flags 000000b5
> [    2.570078] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [    2.577814] mmc0: req done (CMD6): -110: 00000920 00000000 00000000
> 00000000
> [    2.584841] mmc0:     0 bytes transferred: -115
> [    2.589375] mmc0: error -110 whilst initialising SD card
> 
> 
>>
>>>
>>> Dinh
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |    8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 7833002..7dcaa30 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1312,7 +1312,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>>>  					       &host->pending_events)) {
>>>  				dw_mci_stop_dma(host);
>>> -				send_stop_abort(host, data);
>>> +				if (data->stop)
>>> +					send_stop_abort(host, data);
>> This routine is for error handing.
>> Is it effective to detect card normally?
>>
> 
> Yes, detecting the card works fine.
> 
> Thanks,
> Dinh
>> Thanks,
>> Seungwon Jeon
>>
>>>  				state = STATE_DATA_ERROR;
>>>  				break;
>>>  			}
>>> @@ -1334,6 +1335,11 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>  			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
>>>  			err = dw_mci_data_complete(host, data);
>>>
>>> +			if (!data->stop) {
>>> +				dw_mci_request_end(host, host->mrq);
>>> +				goto unlock;
>>> +			}
>>> +
>>>  			if (!err) {
>>>  				if (!data->stop || mrq->sbc) {
>>>  					if (mrq->sbc)
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> 

