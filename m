From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Thu, 23 Jun 2016 08:22:25 +0300
Message-ID: <576B7211.2030208@intel.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
 <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
 <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD@sandisk.com>
 <29966a6f-eb14-0307-08cc-f91a97f50382@rock-chips.com>
 <B7133967-23A7-46AF-9013-417BD282E005@sandisk.com>
 <23729258-7a6b-80ac-6c90-b48eed64e0ea@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55580 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbcFWF0e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2016 01:26:34 -0400
In-Reply-To: <23729258-7a6b-80ac-6c90-b48eed64e0ea@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>

On 23/06/16 04:33, Shawn Lin wrote:
> =E5=9C=A8 2016/6/22 22:08, Alex Lemberg =E5=86=99=E9=81=93:
>> HI Shawn,
>>
>> On 6/21/16, 4:44 AM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>>
>>> On 2016/6/20 21:33, Alex Lemberg wrote:
>>>> Hi Shawn,
>>>>
>>>> [=E2=80=A6]
>>>>
>>>>>>> +
>>>>>>> +static int mmc_stop_auto_bkops(struct mmc_card *card)
>>>>>>> +{
>>>>>>> +    int err =3D 0;
>>>>>>> +
>>>>>>> +    if (!card->ext_csd.auto_bkops_en)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>
>>>>>> Shouldn=E2=80=99t the BKOPS_STATUS be checked prior to disabling=
 the BKOPS
>>>>>> activity of the device?
>>>>>>
>>>>>
>>>>> Hrmm.. I read the whole section of spec for it, and I did find th=
is
>>>>> requirement for manul bkops but not for the auto one. So what sho=
uld we
>>>>> do if using the auto one?
>>>>>
>>>>
>>>> In case of AUTO BKOPS, the eMMC Device should perform internal GC
>>>> in the same way as in case of MANUAL BKOPS.
>>>> The only difference is a host awareness.
>>>
>>> agree.
>>>
>>>> Although there is no requirement in the spec, I think the driver c=
an
>>>> give some time to the device to perform/complete its internal GC d=
uring
>>>> the idle time.
>>>> Thus I think we can check the BKOPS_STATUS on Runtime suspend.
>>>
>>> We shouldn't diable bkops on *runtime* suspend as it's just the rig=
ht
>>> time for firmware to do GC. We could consider to check and wait for
>>> the status when doing poweroff, although it seems firmware should b=
e
>>> able to accept the disable cmd and deal the on-going work perfectly
>>> when doing bkops without host's awareness, just the same way as sud=
dent
>>> power loss cases.
>>
>> If I am not wrong, in current implementation of runtime suspend,
>> the driver stops BKOPS (send HPI) just before sending sleep command,
>> see _mmc_suspend(), depends on =E2=80=9CMMC_CAP_AGGRESSIVE_PM=E2=80=9D=
 flag.
>> In this case, the eMMC device will not have enough time to perform i=
nternal
>> BKOPS in both =E2=80=93 Manual and Auto BKOPS configurations.
>>
>=20
> ye, so it seems a pre-exiting issue before introducing auto bkops?
> I think we can push another patch to improve it but not handling
> it for this $SUBJECT, does it sound ok to you?

Runtime suspend for eMMC has a default auto-suspend delay of 3 seconds
(refer mmc_blk_probe()).  Isn't that when auto bkops would happen?

>=20
>> For the poweroff, it should be OK with a current implementation of
>> PON (mmc_poweroff_notify())
>>
>>>
>>> Also I don't know whether the firmware will reflect its status on
>>> BKOPS_STATUS or not when enabling the auto one. I will do more test=
=2E
>>>
>>> Anyway, thanks for sharing your thought.
>>> Also Adrian point out that currently we trigger manual bkosp from
>>> userspace via mmc-utils, and I agreed we shouldn't force kernel sta=
ck
>>> to enable it defaultly. So I'm prone not to update this $SUBJECT an=
d
>>> migrate it to mmc-utils later.
>>>
>>>>
>>>> [=E2=80=A6]
>>>>
>>>> Thanks,
>>>> Alex
>>>>
>>>
>>>
>>> --=20
>>> Best Regards
>>> Shawn Lin
>>>
>>
>=20
>=20

