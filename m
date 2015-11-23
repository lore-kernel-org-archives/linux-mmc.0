From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v3] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Mon, 23 Nov 2015 12:00:36 +0800
Message-ID: <56528F63.2020801@linux.intel.com>
References: <56488E6F.3090109@linux.intel.com> <CAPDyKFoFqG27xfYT2Dw_E5vavQKSxNMqkNj=Yv4LqZ68y2Z0Kw@mail.gmail.com> <564B3020.5060104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36934 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbbKWEAk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 22 Nov 2015 23:00:40 -0500
In-Reply-To: <564B3020.5060104@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Neil Brown <neilb@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>, Andreas Fenkart <afenkart@gmail.com>, Joe Perches <joe@perches.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 11/17/2015 9:48 PM, Fu, Zhonghui wrote:
>
> On 11/16/2015 7:30 PM, Ulf Hansson wrote:
>> On 15 November 2015 at 14:53, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>>> Now, PM core supports asynchronous suspend/resume mode for devices
>>> during system suspend/resume, and the power state transition of one
>>> device may be completed in separate kernel thread. PM core ensures
>>> all power state transition timing dependency between devices. This
>>> patch enables SDIO card and function devices to suspend/resume
>>> asynchronously. This will take advantage of multicore and improve
>>> system suspend/resume speed. After enabling the SDIO devices and all
>>> their child devices to suspend/resume asynchronously on ASUS T100TA,
>>> the system suspend-to-idle time is reduced from 1645ms to 1119ms, and
>>> the system resume time is reduced from 940ms to 918ms.
>>>
>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> I think this is an interesting change, but I wonder if you really
>> understand how this affects the order of how devices may be
>> suspended/resumed?
>>
>> Also, I believe you didn't answer my question for the earlier version
>> of the patch, so let me try again.
>>
>> There are a strict dependency chain when suspending/resuming devices
>> that must be maintained. Currently this is controlled via device
>> registration/probe order.
>>
>> An SDIO func driver/device must always be suspended *before* the SDIO
>> card device. Additionally the corresponding MMC host, must be
>> suspended after the SDIO card device. Vice verse applies to the resume
>> sequence.
>>
>> As this patch enables asynchronous suspend, I am worried that it will
>> break this dependency chain. What do you think?
> After enabling asynchronous suspend/resume, PM core still ensures the strict suspend/resume dependency between child and parent devices - child must be suspended before its parent, and parent must be resumed before its child. SDIO function is child of SDIO card, and SDIO card is child of MMC host, and MMC host is child of MMC controller. So the dependency chain is not broken. Actually,  many devices have been using asynchronous suspend/resume mode now.

Any comments are welcome.


Thanks,
Zhonghui
>
> Thanks,
> Zhonghui
>> Kind regards
>> Ulf Hansson
>>
>>> ---
>>> Changes in v3:
>>> - Add test result in commit message
>>>
>>>  drivers/mmc/core/sdio.c |    4 ++++
>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>> index 16d838e..530ce88 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -1113,6 +1113,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>                 pm_runtime_enable(&card->dev);
>>>         }
>>>
>>> +       device_enable_async_suspend(&card->dev);
>>> +
>>>         /*
>>>          * The number of functions on the card is encoded inside
>>>          * the ocr.
>>> @@ -1133,6 +1135,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>                  */
>>>                 if (host->caps & MMC_CAP_POWER_OFF_CARD)
>>>                         pm_runtime_enable(&card->sdio_func[i]->dev);
>>> +
>>> +               device_enable_async_suspend(&card->sdio_func[i]->dev);
>>>         }
>>>
>>>         /*
>>> -- 1.7.1
>>>

