From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Mon, 17 Aug 2015 09:48:33 +0300
Message-ID: <55D183C1.1030209@intel.com>
References: <55B9D4EF.2010704@linux.intel.com> <55D1546D.1070900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24324 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbbHQGvQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Aug 2015 02:51:16 -0400
In-Reply-To: <55D1546D.1070900@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17/08/15 06:26, Fu, Zhonghui wrote:
> 
> Hi,
> 
> Any comments are welcome.
> 
> 
> Thanks,
> Zhonghui
> 
> On 2015/7/30 15:40, Fu, Zhonghui wrote:
>> Enable SDIO card and function device to suspend/resume asynchronously.
>> This can improve system suspend/resume speed.

For me, it needs more explanation.

For example, why is this worth doing?  Can you give an example where it does
significantly improve suspend/resume speed?  Are there any cases where it
could be worse?

Why is it safe?  Presumably it is safe if there are no dependencies on the
device outside the device hierarchy. Is that so?  Are there any other
potential pitfalls to enabling async_suspend?

>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/mmc/core/sdio.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index b91abed..6719b77 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>  		pm_runtime_enable(&card->dev);
>>  	}
>>  
>> +	device_enable_async_suspend(&card->dev);
>> +
>>  	/*
>>  	 * The number of functions on the card is encoded inside
>>  	 * the ocr.
>> @@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>  		 */
>>  		if (host->caps & MMC_CAP_POWER_OFF_CARD)
>>  			pm_runtime_enable(&card->sdio_func[i]->dev);
>> +
>> +		device_enable_async_suspend(&card->sdio_func[i]->dev);
>>  	}
>>  
>>  	/*
>> -- 1.7.1
>>
> 
> 
> 

