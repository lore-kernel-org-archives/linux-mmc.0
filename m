From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] mmc: enable mmc host device to suspend/resume asynchronously
Date: Mon, 24 Aug 2015 23:11:00 +0800
Message-ID: <55DB3404.6090200@linux.intel.com>
References: <55BF60F5.8040602@linux.intel.com> <55D156B1.7060501@linux.intel.com> <55D184AD.4050904@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53032 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbbHXPLG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Aug 2015 11:11:06 -0400
In-Reply-To: <55D184AD.4050904@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org, Markus.Niebel@tq-group.com, lars@metafoo.de, s.hauer@pengutronix.de, kristina.martsenko@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/8/17 14:52, Adrian Hunter wrote:
> On 17/08/15 06:36, Fu, Zhonghui wrote:
>> Hi,
>>
>> Any comments are welcome.
> Same comments as here:
>
> 	http://marc.info/?l=linux-kernel&m=143979428424353&w=2

Now, PM core support asynchronous device suspend/resume mode. If one device has been set to support asynchronous PM mode, it's suspend/resume operation can be performed in a separate kernel thread and take advantage of multicore feature to improve overall system suspend/resume speed. The worst case is that all device suspend/resume threads will be scheduled to the same CPU, it hardly occur.

PM core ensure all the suspend/resume dependency related to one device. Actually, async suspend/resume mode is one feature of PM core, every device subsystem may use it or not use it. Once one device subsystem choose to use this feature, its safety is up to PM core as long as device subsystem has initialized fully this device.


Thanks,
Zhonghui 


>
>>
>> Thanks,
>> Zhonghui
>>
>> On 2015/8/3 20:39, Fu, Zhonghui wrote:
>>> Enable mmc host device to suspend/resume asynchronously.
>>> This can improve system suspend/resume speed.
>>>
>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>> ---
>>>  drivers/mmc/core/host.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index 99a9c90..85f2bbb 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -577,6 +577,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>>>  	host->class_dev.parent = dev;
>>>  	host->class_dev.class = &mmc_host_class;
>>>  	device_initialize(&host->class_dev);
>>> +	device_enable_async_suspend(&host->class_dev);
>>>  
>>>  	if (mmc_gpio_alloc(host)) {
>>>  		put_device(&host->class_dev);
>>> -- 1.7.1
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

