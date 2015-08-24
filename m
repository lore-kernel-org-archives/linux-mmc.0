From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] mmc/sdhci-acpi: enable sdhci-acpi device to suspend/resume
 asynchronously
Date: Mon, 24 Aug 2015 23:14:01 +0800
Message-ID: <55DB34B9.40303@linux.intel.com>
References: <55BF6843.4050502@linux.intel.com> <55D15718.9080107@linux.intel.com> <55D18479.50506@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60917 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbbHXPOG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Aug 2015 11:14:06 -0400
In-Reply-To: <55D18479.50506@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, andriy.shevchenko@linux.intel.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, yunpeng.gao@intel.com, peter.griffin@linaro.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/8/17 14:51, Adrian Hunter wrote:
> On 17/08/15 06:38, Fu, Zhonghui wrote:
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
>> On 2015/8/3 21:10, Fu, Zhonghui wrote:
>>> Enable sdhci-acpi device to suspend/resume asynchronously.
>>> This can improve system suspend/resume speed.
>>>
>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci-acpi.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>> index 22d929f..67e6263 100644
>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>> @@ -379,6 +379,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>>  		pm_runtime_enable(dev);
>>>  	}
>>>  
>>> +	device_enable_async_suspend(dev);
>>> +
>>>  	return 0;
>>>  
>>>  err_free:
>>> -- 1.7.1
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

