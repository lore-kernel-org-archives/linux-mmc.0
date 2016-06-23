From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 0/4] Introduce new caps to improve the card's init
 sequence
Date: Thu, 23 Jun 2016 09:35:33 +0800
Message-ID: <bded4371-5ebd-b4c3-5dd3-ea6e52a50214@rock-chips.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFp+ugPtHsxa1O9eeArkJjoM2sL2F7gqAekgus1qoi3UUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp+ugPtHsxa1O9eeArkJjoM2sL2F7gqAekgus1qoi3UUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/6/22 20:37, Ulf Hansson =E5=86=99=E9=81=93:
> On 8 June 2016 at 10:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Hi all,
>>
>> This patchset is gonna improve the card's init sequence
>> by exposing some caps to DT.
>>
>> The basic idea is to skip sending specific init cmd inspired
>> by Carlo Caione's commit[0].
>>
>> To make it possible, I firstly expose Carlo's MMC_CAP2_NO_SDIO
>> to DT and extend two new caps for similar usage of sd and mmc.
>> We probably need it because for most of the boards, each of the
>> slots should have a specific function when designed. It's impossible
>> for one slot which can either to be used as eMMC or a SD card for a
>> given board. The same for SDIO case.
>>
>> We could have two ways to improve it
>> A) Skip sending specific commands if knowing we don't support
>> the specific card type.
>> B) Allow sending specific commands if knowing we do support
>> the specific card type.
>>
>> A) and B) shouldn't have difference, but I take A) as the final
>> one as it looks more consistent with Carlo's way, which does not
>> seem to break anything as possible.
>>
>> The only roadblock for this patchset to be landed should be the
>> improvement we gain from it. Theoretically sdio-card doesn't get
>> improvment as it's already in the first place to be attached.
>> But considering the sd and (e)MMC case, we should gain more benifit
>> from it.
>>
>> From the test, we can save nearly 2ms for attaching emmc against the
>> original 8ms. And we gain more than 30us improvement for sd card for
>> each insert.
>>
>> [0]: http://permalink.gmane.org/gmane.linux.kernel.mmc/34774
>>
>>
>>
>> Shawn Lin (4):
>>   Documentation: mmc: add description for new caps
>>   mmc: core: expose MMC_CAP2_NO_SDIO to dt-binding
>>   mmc: core: add cap-no-sd and cap-no-mmc properties
>>   mmc: core: improve initialization flow
>>
>
> I would prefer that you restructure this series a bit.

I will do it and I think Doug was asking we to drop the "cap-"
prefix which I think need to be clarified before sending
non-RFC one. :)

>
> Start by adding each new MMC_CAP2* separately and without involving
> the DT parsing.
>
> Make the DT documentation patch come after the above, and add a new
> separate patch which exposes the caps to device tree.
>
> In that way, I can pick up the non DT parts and wait for Rob's
> ack/nack of the DT bindings.
>
> Kind regards
> Uffe
>
>>  Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
>>  drivers/mmc/core/core.c                       | 10 +++++-----
>>  drivers/mmc/core/host.c                       |  6 ++++++
>>  include/linux/mmc/host.h                      |  2 ++
>>  4 files changed, 16 insertions(+), 5 deletions(-)
>>
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


--=20
Best Regards
Shawn Lin
