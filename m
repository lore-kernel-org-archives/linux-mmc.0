From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Mon, 24 Aug 2015 15:07:13 +0800
Message-ID: <55DAC2A1.4040901@linux.intel.com>
References: <55B9D4EF.2010704@linux.intel.com> <55D1546D.1070900@linux.intel.com> <55D183C1.1030209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47572 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbbHXHHU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Aug 2015 03:07:20 -0400
In-Reply-To: <55D183C1.1030209@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/8/17 14:48, Adrian Hunter wrote:
> On 17/08/15 06:26, Fu, Zhonghui wrote:
>> Hi,
>>
>> Any comments are welcome.
>>
>>
>> Thanks,
>> Zhonghui
>>
>> On 2015/7/30 15:40, Fu, Zhonghui wrote:
>>> Enable SDIO card and function device to suspend/resume asynchronously.
>>> This can improve system suspend/resume speed.
> For me, it needs more explanation.
>
> For example, why is this worth doing?  Can you give an example where it does
> significantly improve suspend/resume speed?  Are there any cases where it
> could be worse?
>
> Why is it safe?  Presumably it is safe if there are no dependencies on the
> device outside the device hierarchy. Is that so?  Are there any other
> potential pitfalls to enabling async_suspend?

Now, PM core support asynchronous device suspend/resume mode. If one device has been set to support asynchronous PM mode, it's suspend/resume operation can be performed in a separate kernel thread and take advantage of multicore feature to improve overall system suspend/resume speed. The worst case is that all device suspend/resume threads will be scheduled to the same CPU, it hardly occur.

PM core ensure all the suspend/resume dependency related to one device. Actually, async suspend/resume mode is one feature of PM core, every device subsystem may use it or not use it. Once one device subsystem choose to use this feature, its safety is up to PM core as long as device subsystem has initialized fully this device.


Thanks,
Zhonghui  
>
>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>> ---
>>>  drivers/mmc/core/sdio.c |    4 ++++
>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>> index b91abed..6719b77 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>  		pm_runtime_enable(&card->dev);
>>>  	}
>>>  
>>> +	device_enable_async_suspend(&card->dev);
>>> +
>>>  	/*
>>>  	 * The number of functions on the card is encoded inside
>>>  	 * the ocr.
>>> @@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>  		 */
>>>  		if (host->caps & MMC_CAP_POWER_OFF_CARD)
>>>  			pm_runtime_enable(&card->sdio_func[i]->dev);
>>> +
>>> +		device_enable_async_suspend(&card->sdio_func[i]->dev);
>>>  	}
>>>  
>>>  	/*
>>> -- 1.7.1
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

