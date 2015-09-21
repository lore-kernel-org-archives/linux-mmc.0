From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] MMC/SDIO: enable SDIO device to suspend/resume
 asynchronously
Date: Mon, 21 Sep 2015 11:41:17 +0300
Message-ID: <55FFC2AD.4090901@intel.com>
References: <55B9D4EF.2010704@linux.intel.com>
 <55D1546D.1070900@linux.intel.com> <55D183C1.1030209@intel.com>
 <55DAC2A1.4040901@linux.intel.com> <55FF95CA.4010108@linux.intel.com>
 <55FFBCBC.10309@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64354 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756133AbbIUIoK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Sep 2015 04:44:10 -0400
In-Reply-To: <55FFBCBC.10309@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21/09/15 11:15, Adrian Hunter wrote:
> On 21/09/15 08:29, Fu, Zhonghui wrote:
>>
>>
>> On 2015/8/24 15:07, Fu, Zhonghui wrote:
>>>
>>> On 2015/8/17 14:48, Adrian Hunter wrote:
>>>> On 17/08/15 06:26, Fu, Zhonghui wrote:
>>>>> Hi,
>>>>>
>>>>> Any comments are welcome.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Zhonghui
>>>>>
>>>>> On 2015/7/30 15:40, Fu, Zhonghui wrote:
>>>>>> Enable SDIO card and function device to suspend/resume asynchron=
ously.
>>>>>> This can improve system suspend/resume speed.
>>>> For me, it needs more explanation.
>>>>
>>>> For example, why is this worth doing?  Can you give an example whe=
re it does
>>>> significantly improve suspend/resume speed?  Are there any cases w=
here it
>>>> could be worse?
>>>>
>>>> Why is it safe?  Presumably it is safe if there are no dependencie=
s on the
>>>> device outside the device hierarchy. Is that so?  Are there any ot=
her
>>>> potential pitfalls to enabling async_suspend?
>>> Now, PM core support asynchronous device suspend/resume mode. If on=
e device has been set to support asynchronous PM mode, it's suspend/res=
ume operation can be performed in a separate kernel thread and take adv=
antage of multicore feature to improve overall system suspend/resume sp=
eed. The worst case is that all device suspend/resume threads will be s=
cheduled to the same CPU, it hardly occur.
>>>
>>> PM core ensure all the suspend/resume dependency related to one dev=
ice. Actually, async suspend/resume mode is one feature of PM core, eve=
ry device subsystem may use it or not use it. Once one device subsystem=
 choose to use this feature, its safety is up to PM core as long as dev=
ice subsystem has initialized fully this device.
>>
>> The original suspend time is 1645ms and resume time is 940ms on ASUS=
 T100TA
>> machine. After enabling "wiphy device", "SDIO device", "mmc host" an=
d
>> "sdhci-acpi device" to suspend/resume asynchronously, the suspend ti=
me is
>> 1096ms and resume time is 908ms. The test environment is listed as f=
ollows:
>>
>> OS: Ubuntu 14.04
>> Kernel: mainline v4.1
>> Machine: ASUS T100TA(Baytrail-T platform)
>> Tool: analyze_suspend
>> =E2=80=9Canalyze_suspend.py =E2=80=93f =E2=80=93m freeze=E2=80=9D to=
 suspend system
>> Press power button to resume system
>>
>> I have resent this patch with updated commit message - "[PATCH v2] M=
MC/SDIO:
>> enable SDIO device to suspend/resume asynchronously".
>=20
> It is really cool that you tested this.  Thank you!
>=20
> I am a bit baffled and bemused that you didn't put a summary of the t=
esting
> and results in the commit message.  Can you do that.
>=20
> As I wrote, we are assuming that there are no dependencies on the dev=
ice
> outside the device hierarchy. That is a reasonable assumption for an =
SDIO
> controller because it doesn't provide resources for other devices to =
use,
> except for the card itself which is a child device, and therefore a
> dependency that PM core knows about.
>=20
> Does that make sense?  If it does then shouldn't that explanation be =
added
> to the commit message too.  i.e. this is why we think it is always go=
ing to
> work?

Just realized this patch is for the card, not the host controller, so t=
hose
last 2 paragraphs don't apply.

>=20
>>
>>
>> Thanks,
>> Zhonghui
>>>
>>>
>>> Thanks,
>>> Zhonghui =20
>>>>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>>>>> ---
>>>>>>  drivers/mmc/core/sdio.c |    4 ++++
>>>>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>>>>> index b91abed..6719b77 100644
>>>>>> --- a/drivers/mmc/core/sdio.c
>>>>>> +++ b/drivers/mmc/core/sdio.c
>>>>>> @@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>>>>  		pm_runtime_enable(&card->dev);
>>>>>>  	}
>>>>>> =20
>>>>>> +	device_enable_async_suspend(&card->dev);
>>>>>> +
>>>>>>  	/*
>>>>>>  	 * The number of functions on the card is encoded inside
>>>>>>  	 * the ocr.
>>>>>> @@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>>>>>  		 */
>>>>>>  		if (host->caps & MMC_CAP_POWER_OFF_CARD)
>>>>>>  			pm_runtime_enable(&card->sdio_func[i]->dev);
>>>>>> +
>>>>>> +		device_enable_async_suspend(&card->sdio_func[i]->dev);
>>>>>>  	}
>>>>>> =20
>>>>>>  	/*
>>>>>> -- 1.7.1
>>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ke=
rnel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>=20
>=20

