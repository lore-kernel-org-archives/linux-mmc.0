From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 13 Jun 2016 16:58:54 +0800
Message-ID: <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com>
 <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54038 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300AbcFMI7E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 04:59:04 -0400
In-Reply-To: <575E6C11.8060709@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Alex Lemberg <alex.lemberg@sandisk.com>

=E5=9C=A8 2016/6/13 16:17, Adrian Hunter =E5=86=99=E9=81=93:
> On 13/06/16 10:48, Shawn Lin wrote:
>> On 2016/6/13 14:29, Adrian Hunter wrote:
>>> On 06/06/16 06:07, Shawn Lin wrote:
>>>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>>>> for background operations.
>>>>
>>>> Host that wants to enable the device to perform background
>>>> operations during device idle time, should signal the device
>>>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>>>> this bit is set, the device may start or stop background operation=
s
>>>> whenever it sees fit, without any notification to the host.
>>>>
>>>> When AUTO_EN bit is set, the host should keep the device power
>>>> active. The host may set or clear this bit at any time based on
>>>> its power constraints or other considerations.
>>>>
>>>> Currently the manual bkops is only be used under the async req
>>>> circumstances and it's a bit complicated to be controlled as the
>>>> perfect method is that we should do some idle monitor just as rpm
>>>> and send HPI each time if receiving rd/wr req. But it will impact
>>>> performance significantly, especially for random iops since the
>>>> weight of executing HPI against r/w small piece of LBAs is
>>>> nonnegligible.
>>>>
>>>> So we now prefer to select the auto one unconditionally if support=
ed
>>>> which makes it as simple as possible. It should really good enough
>>>> for devices to manage its internal policy for bkops rather than th=
e
>>>> host, which makes us believe that we could achieve the best
>>>> performance for all the devices implementing auto bkops and the on=
ly
>>>> thing we should do is to disable it when cutting off the power.
>>>
>>> Do you know if there is really a requirement to do that?
>>
>> Even without bkops enable, no matter for manual or auto one, FTL sho=
uld
>> always do bkops like GC internally when needed to guarantee the
>> performance and balance the wear leveling. What I thought to do is t=
o
>> make it more explicitly.
>>
>> Because then, what
>>> is the point of power off notification?
>>
>> When power off notification is sent, bkops will be stopped
>> in _mmc_suspend. So I don't undertand your point here?
>
> I am trying to understand why we need to do anything for auto bkops.
> Since AUTO_EN is persistent, we can leave the decision whether to tur=
n it on
> to whomever provisions the device. Then we just leave it alone.
>

Hrm..

one possible way is to control it by mmc-utils on
user space?  So we should add a cmd for mmc-utils
there?

>
>
>


--=20
Best Regards
Shawn Lin

