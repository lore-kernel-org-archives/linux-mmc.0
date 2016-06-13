From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 13 Jun 2016 15:25:53 +0300
Message-ID: <575EA651.7060606@intel.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com>
 <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com>
 <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Alex Lemberg <alex.lemberg@sandisk.com>
List-Id: linux-mmc@vger.kernel.org

On 13/06/16 11:58, Shawn Lin wrote:
> =E5=9C=A8 2016/6/13 16:17, Adrian Hunter =E5=86=99=E9=81=93:
>> On 13/06/16 10:48, Shawn Lin wrote:
>>> On 2016/6/13 14:29, Adrian Hunter wrote:
>>>> On 06/06/16 06:07, Shawn Lin wrote:
>>>>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>>>>> for background operations.
>>>>>
>>>>> Host that wants to enable the device to perform background
>>>>> operations during device idle time, should signal the device
>>>>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>>>>> this bit is set, the device may start or stop background operatio=
ns
>>>>> whenever it sees fit, without any notification to the host.
>>>>>
>>>>> When AUTO_EN bit is set, the host should keep the device power
>>>>> active. The host may set or clear this bit at any time based on
>>>>> its power constraints or other considerations.
>>>>>
>>>>> Currently the manual bkops is only be used under the async req
>>>>> circumstances and it's a bit complicated to be controlled as the
>>>>> perfect method is that we should do some idle monitor just as rpm
>>>>> and send HPI each time if receiving rd/wr req. But it will impact
>>>>> performance significantly, especially for random iops since the
>>>>> weight of executing HPI against r/w small piece of LBAs is
>>>>> nonnegligible.
>>>>>
>>>>> So we now prefer to select the auto one unconditionally if suppor=
ted
>>>>> which makes it as simple as possible. It should really good enoug=
h
>>>>> for devices to manage its internal policy for bkops rather than t=
he
>>>>> host, which makes us believe that we could achieve the best
>>>>> performance for all the devices implementing auto bkops and the o=
nly
>>>>> thing we should do is to disable it when cutting off the power.
>>>>
>>>> Do you know if there is really a requirement to do that?
>>>
>>> Even without bkops enable, no matter for manual or auto one, FTL sh=
ould
>>> always do bkops like GC internally when needed to guarantee the
>>> performance and balance the wear leveling. What I thought to do is =
to
>>> make it more explicitly.
>>>
>>> Because then, what
>>>> is the point of power off notification?
>>>
>>> When power off notification is sent, bkops will be stopped
>>> in _mmc_suspend. So I don't undertand your point here?
>>
>> I am trying to understand why we need to do anything for auto bkops.
>> Since AUTO_EN is persistent, we can leave the decision whether to tu=
rn it on
>> to whomever provisions the device. Then we just leave it alone.
>>
>=20
> Hrm..
>=20
> one possible way is to control it by mmc-utils on
> user space?  So we should add a cmd for mmc-utils
> there?

That would be consistent with manual bkops.
