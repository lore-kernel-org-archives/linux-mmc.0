From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Thu, 23 Jun 2016 10:08:20 +0800
Message-ID: <64ed1ed2-09ff-659e-01f8-87a1071883d1@rock-chips.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com>
 <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com>
 <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
 <575EA651.7060606@intel.com>
 <CAPDyKFq7Pr1YiacwpeDq3eAYmApydTj8Kbkyh=Cb6+vJC9BV3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:53340 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcFWCI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 22:08:28 -0400
In-Reply-To: <CAPDyKFq7Pr1YiacwpeDq3eAYmApydTj8Kbkyh=Cb6+vJC9BV3Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Alex Lemberg <alex.lemberg@sandisk.com>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

=E5=9C=A8 2016/6/22 18:21, Ulf Hansson =E5=86=99=E9=81=93:
> On 13 June 2016 at 14:25, Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>> On 13/06/16 11:58, Shawn Lin wrote:
>>> =E5=9C=A8 2016/6/13 16:17, Adrian Hunter =E5=86=99=E9=81=93:
>>>> On 13/06/16 10:48, Shawn Lin wrote:
>>>>> On 2016/6/13 14:29, Adrian Hunter wrote:
>>>>>> On 06/06/16 06:07, Shawn Lin wrote:
>>>>>>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>>>>>>> for background operations.
>>>>>>>
>>>>>>> Host that wants to enable the device to perform background
>>>>>>> operations during device idle time, should signal the device
>>>>>>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>>>>>>> this bit is set, the device may start or stop background operat=
ions
>>>>>>> whenever it sees fit, without any notification to the host.
>>>>>>>
>>>>>>> When AUTO_EN bit is set, the host should keep the device power
>>>>>>> active. The host may set or clear this bit at any time based on
>>>>>>> its power constraints or other considerations.
>>>>>>>
>>>>>>> Currently the manual bkops is only be used under the async req
>>>>>>> circumstances and it's a bit complicated to be controlled as th=
e
>>>>>>> perfect method is that we should do some idle monitor just as r=
pm
>>>>>>> and send HPI each time if receiving rd/wr req. But it will impa=
ct
>>>>>>> performance significantly, especially for random iops since the
>>>>>>> weight of executing HPI against r/w small piece of LBAs is
>>>>>>> nonnegligible.
>>>>>>>
>>>>>>> So we now prefer to select the auto one unconditionally if supp=
orted
>>>>>>> which makes it as simple as possible. It should really good eno=
ugh
>>>>>>> for devices to manage its internal policy for bkops rather than=
 the
>>>>>>> host, which makes us believe that we could achieve the best
>>>>>>> performance for all the devices implementing auto bkops and the=
 only
>>>>>>> thing we should do is to disable it when cutting off the power.
>>>>>>
>>>>>> Do you know if there is really a requirement to do that?
>>>>>
>>>>> Even without bkops enable, no matter for manual or auto one, FTL =
should
>>>>> always do bkops like GC internally when needed to guarantee the
>>>>> performance and balance the wear leveling. What I thought to do i=
s to
>>>>> make it more explicitly.
>>>>>
>>>>> Because then, what
>>>>>> is the point of power off notification?
>>>>>
>>>>> When power off notification is sent, bkops will be stopped
>>>>> in _mmc_suspend. So I don't undertand your point here?
>>>>
>>>> I am trying to understand why we need to do anything for auto bkop=
s.
>>>> Since AUTO_EN is persistent, we can leave the decision whether to =
turn it on
>>>> to whomever provisions the device. Then we just leave it alone.
>>>>
>>>
>>> Hrm..
>>>
>>> one possible way is to control it by mmc-utils on
>>> user space?  So we should add a cmd for mmc-utils
>>> there?
>>
>> That would be consistent with manual bkops.
>>
>
>>From my first impression I agree, as that is the policy we have been
> sticking to when writing to persistent EXT_CSD persistent .
> Although, in this case, I am actually wondering on what is the best a=
pproach.

I don't know what is the real meaning of "persistent". :)
I don't know should we count auto bkops as the persistent
registers....HS_TIMING and BUS_WIDTH should also be persistent
registers as them are always used after initialization if not changing
them?

IHMO the more reasonable way is that:
IIRC many settings for  EXT_CSD should be OTP, like hw-reset(162),
reliable write(167) fw-configure(169)..etc, which are marked as R/W.
These should be controlled by userpace or even by firmware when
flashing emmc, like reliable write...


I'm not sure whether should I updete this $SUBJUCT or migirating it to
userspace... We need to come to an agreement :)


>
> Is there really ever a case when we don't want auto BKOPS to be defau=
lt enabled?
> I think BKOPS is a fundamental feature of an FTL and I can't see a
> reason to why we need to involve mmc-utils/userspace to enable it. Am
> I wrong?
>
> Kind regards
> Uffe
>
>
>


--=20
Best Regards
Shawn Lin

