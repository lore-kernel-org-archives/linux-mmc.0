From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Wed, 22 Jun 2016 12:21:51 +0200
Message-ID: <CAPDyKFq7Pr1YiacwpeDq3eAYmApydTj8Kbkyh=Cb6+vJC9BV3Q@mail.gmail.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com> <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com> <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
 <575EA651.7060606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36220 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcFVKV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 06:21:56 -0400
Received: by mail-lf0-f41.google.com with SMTP id q132so70358942lfe.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 03:21:55 -0700 (PDT)
In-Reply-To: <575EA651.7060606@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Alex Lemberg <alex.lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 13 June 2016 at 14:25, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
> On 13/06/16 11:58, Shawn Lin wrote:
>> =E5=9C=A8 2016/6/13 16:17, Adrian Hunter =E5=86=99=E9=81=93:
>>> On 13/06/16 10:48, Shawn Lin wrote:
>>>> On 2016/6/13 14:29, Adrian Hunter wrote:
>>>>> On 06/06/16 06:07, Shawn Lin wrote:
>>>>>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>>>>>> for background operations.
>>>>>>
>>>>>> Host that wants to enable the device to perform background
>>>>>> operations during device idle time, should signal the device
>>>>>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>>>>>> this bit is set, the device may start or stop background operati=
ons
>>>>>> whenever it sees fit, without any notification to the host.
>>>>>>
>>>>>> When AUTO_EN bit is set, the host should keep the device power
>>>>>> active. The host may set or clear this bit at any time based on
>>>>>> its power constraints or other considerations.
>>>>>>
>>>>>> Currently the manual bkops is only be used under the async req
>>>>>> circumstances and it's a bit complicated to be controlled as the
>>>>>> perfect method is that we should do some idle monitor just as rp=
m
>>>>>> and send HPI each time if receiving rd/wr req. But it will impac=
t
>>>>>> performance significantly, especially for random iops since the
>>>>>> weight of executing HPI against r/w small piece of LBAs is
>>>>>> nonnegligible.
>>>>>>
>>>>>> So we now prefer to select the auto one unconditionally if suppo=
rted
>>>>>> which makes it as simple as possible. It should really good enou=
gh
>>>>>> for devices to manage its internal policy for bkops rather than =
the
>>>>>> host, which makes us believe that we could achieve the best
>>>>>> performance for all the devices implementing auto bkops and the =
only
>>>>>> thing we should do is to disable it when cutting off the power.
>>>>>
>>>>> Do you know if there is really a requirement to do that?
>>>>
>>>> Even without bkops enable, no matter for manual or auto one, FTL s=
hould
>>>> always do bkops like GC internally when needed to guarantee the
>>>> performance and balance the wear leveling. What I thought to do is=
 to
>>>> make it more explicitly.
>>>>
>>>> Because then, what
>>>>> is the point of power off notification?
>>>>
>>>> When power off notification is sent, bkops will be stopped
>>>> in _mmc_suspend. So I don't undertand your point here?
>>>
>>> I am trying to understand why we need to do anything for auto bkops=
=2E
>>> Since AUTO_EN is persistent, we can leave the decision whether to t=
urn it on
>>> to whomever provisions the device. Then we just leave it alone.
>>>
>>
>> Hrm..
>>
>> one possible way is to control it by mmc-utils on
>> user space?  So we should add a cmd for mmc-utils
>> there?
>
> That would be consistent with manual bkops.
>

=46rom my first impression I agree, as that is the policy we have been
sticking to when writing to persistent EXT_CSD registers.
Although, in this case, I am actually wondering on what is the best app=
roach.

Is there really ever a case when we don't want auto BKOPS to be default=
 enabled?
I think BKOPS is a fundamental feature of an FTL and I can't see a
reason to why we need to involve mmc-utils/userspace to enable it. Am
I wrong?

Kind regards
Uffe
