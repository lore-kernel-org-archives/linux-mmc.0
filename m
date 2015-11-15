From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: Re: [PATCH] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Sun, 15 Nov 2015 22:02:31 +0800
Message-ID: <56489077.6040702@linux.intel.com>
References: <55B9D4EF.2010704@linux.intel.com> <55D1546D.1070900@linux.intel.com> <55D183C1.1030209@intel.com> <55DAC2A1.4040901@linux.intel.com> <55FF95CA.4010108@linux.intel.com> <55FFBCBC.10309@intel.com> <55FFC2AD.4090901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20146 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbbKOODG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 15 Nov 2015 09:03:06 -0500
In-Reply-To: <55FFC2AD.4090901@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 9/21/2015 4:41 PM, Adrian Hunter wrote:
> On 21/09/15 11:15, Adrian Hunter wrote:
>> On 21/09/15 08:29, Fu, Zhonghui wrote:
>>>
>>> On 2015/8/24 15:07, Fu, Zhonghui wrote:
>>>> On 2015/8/17 14:48, Adrian Hunter wrote:
>>>>> On 17/08/15 06:26, Fu, Zhonghui wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Any comments are welcome.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Zhonghui
>>>>>>
>>>>>> On 2015/7/30 15:40, Fu, Zhonghui wrote:
>>>>>>> Enable SDIO card and function device to suspend/resume asynchro=
nously.
>>>>>>> This can improve system suspend/resume speed.
>>>>> For me, it needs more explanation.
>>>>>
>>>>> For example, why is this worth doing?  Can you give an example wh=
ere it does
>>>>> significantly improve suspend/resume speed?  Are there any cases =
where it
>>>>> could be worse?
>>>>>
>>>>> Why is it safe?  Presumably it is safe if there are no dependenci=
es on the
>>>>> device outside the device hierarchy. Is that so?  Are there any o=
ther
>>>>> potential pitfalls to enabling async_suspend?
>>>> Now, PM core support asynchronous device suspend/resume mode. If o=
ne device has been set to support asynchronous PM mode, it's suspend/re=
sume operation can be performed in a separate kernel thread and take ad=
vantage of multicore feature to improve overall system suspend/resume s=
peed. The worst case is that all device suspend/resume threads will be =
scheduled to the same CPU, it hardly occur.
>>>>
>>>> PM core ensure all the suspend/resume dependency related to one de=
vice. Actually, async suspend/resume mode is one feature of PM core, ev=
ery device subsystem may use it or not use it. Once one device subsyste=
m choose to use this feature, its safety is up to PM core as long as de=
vice subsystem has initialized fully this device.
>>> The original suspend time is 1645ms and resume time is 940ms on ASU=
S T100TA
>>> machine. After enabling "wiphy device", "SDIO device", "mmc host" a=
nd
>>> "sdhci-acpi device" to suspend/resume asynchronously, the suspend t=
ime is
>>> 1096ms and resume time is 908ms. The test environment is listed as =
follows:
>>>
>>> OS: Ubuntu 14.04
>>> Kernel: mainline v4.1
>>> Machine: ASUS T100TA(Baytrail-T platform)
>>> Tool: analyze_suspend
>>> =E2=80=9Canalyze_suspend.py =E2=80=93f =E2=80=93m freeze=E2=80=9D t=
o suspend system
>>> Press power button to resume system
>>>
>>> I have resent this patch with updated commit message - "[PATCH v2] =
MMC/SDIO:
>>> enable SDIO device to suspend/resume asynchronously".
>> It is really cool that you tested this.  Thank you!
>>
>> I am a bit baffled and bemused that you didn't put a summary of the =
testing
>> and results in the commit message.  Can you do that.
>>
>> As I wrote, we are assuming that there are no dependencies on the de=
vice
>> outside the device hierarchy. That is a reasonable assumption for an=
 SDIO
>> controller because it doesn't provide resources for other devices to=
 use,
>> except for the card itself which is a child device, and therefore a
>> dependency that PM core knows about.
>>
>> Does that make sense?  If it does then shouldn't that explanation be=
 added
>> to the commit message too.  i.e. this is why we think it is always g=
oing to
>> work?
> Just realized this patch is for the card, not the host controller, so=
 those
> last 2 paragraphs don't apply.

Sorry for replying this mail after long leave.

Thanks for your comments. I have added the test result into commit mess=
age and sent the latest version of this patch: "[PATCH v3] MMC/SDIO: en=
able SDIO device to suspend/resume asynchronously"


Thanks,
Zhonghui
>
>>>
>>> Thanks,
>>> Zhonghui
>>>>
>>>> Thanks,
>>>> Zhonghui =20
>>>>>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>>>>>> ---
>>>>>>>  drivers/mmc/core/sdio.c |    4 ++++
>>>>>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>>>>>> index b91abed..6719b77 100644
>>>>>>> --- a/drivers/mmc/core/sdio.c
>>>>>>> +++ b/drivers/mmc/core/sdio.c
>>>>>>> @@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host=
)
>>>>>>>  		pm_runtime_enable(&card->dev);
>>>>>>>  	}
>>>>>>> =20
>>>>>>> +	device_enable_async_suspend(&card->dev);
>>>>>>> +
>>>>>>>  	/*
>>>>>>>  	 * The number of functions on the card is encoded inside
>>>>>>>  	 * the ocr.
>>>>>>> @@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host=
)
>>>>>>>  		 */
>>>>>>>  		if (host->caps & MMC_CAP_POWER_OFF_CARD)
>>>>>>>  			pm_runtime_enable(&card->sdio_func[i]->dev);
>>>>>>> +
>>>>>>> +		device_enable_async_suspend(&card->sdio_func[i]->dev);
>>>>>>>  	}
>>>>>>> =20
>>>>>>>  	/*
>>>>>>> -- 1.7.1
>>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-k=
ernel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

