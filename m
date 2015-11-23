From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Mon, 23 Nov 2015 16:26:04 +0100
Message-ID: <CAPDyKFrExmXndtwQCAoZMOa6HKojwZFgrgwq0DepbhO_zAyOmQ@mail.gmail.com>
References: <56488E6F.3090109@linux.intel.com>
	<CAPDyKFoFqG27xfYT2Dw_E5vavQKSxNMqkNj=Yv4LqZ68y2Z0Kw@mail.gmail.com>
	<564B3020.5060104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564B3020.5060104@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Neil Brown <neilb@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>, Andreas Fenkart <afenkart@gmail.com>, Joe Perches <joe@perches.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 November 2015 at 14:48, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>
>
> On 11/16/2015 7:30 PM, Ulf Hansson wrote:
>> On 15 November 2015 at 14:53, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>>> Now, PM core supports asynchronous suspend/resume mode for devices
>>> during system suspend/resume, and the power state transition of one
>>> device may be completed in separate kernel thread. PM core ensures
>>> all power state transition timing dependency between devices. This

What "timing dependency"?

>>> patch enables SDIO card and function devices to suspend/resume
>>> asynchronously. This will take advantage of multicore and improve
>>> system suspend/resume speed. After enabling the SDIO devices and all
>>> their child devices to suspend/resume asynchronously on ASUS T100TA,
>>> the system suspend-to-idle time is reduced from 1645ms to 1119ms, and
>>> the system resume time is reduced from 940ms to 918ms.

Are these improvements achieved by $subject patch on its own or you
need below patches:

[PATCH v3] mmc: enable mmc host device to suspend/resume asynchronously [1]

[PATCH v3] mmc/sdhci-acpi: enable sdhci-acpi device to suspend/resume
asynchronously [2]

Depending if you have SD/(e)MMC card slot(s), the below patch might
affect your results. So it might be a good idea to re-run your test to
get some fresh data.

[PATCH 1/2] mmc: core: Make runtime resume default behavior for MMC/SD [3]

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


I believe your view of how the PM core works for devices that *don't*
use async suspend is wrong! The PM core doesn't respect parent/child
relations during the device system PM phase for these devices.

Instead it relies on that devices in the "dpm list" are ordered
correctly. As I tried to describe earlier, that list is being updated
during device registration and probing (there are some other special
cases as well).

So, by enabling async suspend for a device it will trigger the PM core
durng device system PM, to start caring about device's parent/child
relations. I would appreciate if you could add some of this
information to the change log, as that's *why* it should work nicely
for mmc/sd/sdio to use async suspend.

>
> Thanks,
> Zhonghui
>>
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

This change will also affect SDIO combo cards. That means the when
there is a mmc blk device driver bound to the mmc card, its
->suspend() methods will be called asynchronously.

Have you considered that? Especially since there are nothing being
mentioned about it in the change-log?

Also, within this context I am wondering why you *only* enable async
suspend for SDIO cards and not all cards (SD/MMC)? Is there a problem
with doing that?

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
>

[1]
https://lkml.org/lkml/2015/11/15/83
[2]
https://lkml.org/lkml/2015/11/16/6
[3]
http://www.spinics.net/lists/linux-mmc/msg34004.html

Kind regards
Ulf Hansson
