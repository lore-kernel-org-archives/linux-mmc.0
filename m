From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add pinctrl support
Date: Wed, 20 Jan 2016 08:54:52 +0800
Message-ID: <569EDADC.4020302@rock-chips.com>
References: <1453197165-20194-1-git-send-email-shawn.lin@rock-chips.com>
 <7857448.fZE0EdmvdR@phil> <569E18E4.7050509@rock-chips.com>
 <569E21C3.2080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37709 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbcATAzO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 19:55:14 -0500
In-Reply-To: <569E21C3.2080606@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/1/19 19:45, Caesar Wang wrote:
>
> =E5=9C=A8 2016=E5=B9=B401=E6=9C=8819=E6=97=A5 19:07, Shawn Lin =E5=86=
=99=E9=81=93:
>> On 2016/1/19 18:07, Heiko Stuebner wrote:
>>> Hi Shawn,
>>>
>>> Am Dienstag, 19. Januar 2016, 17:52:45 schrieb Shawn Lin:
>>>> We find rk3368 fail to enumerate sd card since
>>>> the default state is gpio function. Meahwhile, lots of
>>>> rockchip platform dts file assign pinctrl to dw_mmc but actually
>>>> dw_mmc never use it. Fortunately, those platforms' default io
>>>> state is sdmmc function, but no always right for all.
>>>>
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> I do believe any issue you see, must come from somewhere else,
>>> because the
>>> driver-core does in drivers/base/dd.c really_probe():
>>>     pinctrl_bind_pins()
>>
>> yes, pinctrl_bind_pins does turn pinctrl state. But I try debug a li=
ttle
>> more and seems somewhere else switch the state before dw_mmc probe.
>> Now I *guess* that may relate to our ATF or MCU firmware since
>> rk3368's sdmmc io can also be used as mcu_jtag for system debug. I
>> need to double check that point, thanks.
>>
>
> Yep,  maybe that's related to the firmware setting.
> I guess you can repro this issue on RK3368 platform.
> At least until now, the RK3036, RK3288....that's work well.
>

Hi Caesar,

Then I check this issue with MCU firmware guys and it does force
pin setting into mcu_jtag function=E3=80=82 Now I can see only 3368 app=
ly
MCU firmware, right? Another thing, seems old version firmware didn't
break the sdmmc function.

I think it's better to slove this problem in firmware side,
not Linux.  So, abandon this patch!


>
>> Hi Caesar,
>> does your patch able to consider adding SDMMC/CPU_JTAG/MCU_JTAG
>> managment for rk3368 as well?
>>
>
> That's no related,  I will add the sdmmc node and check it on tomorro=
w
> if the time can be availabled.
>
>
>>> which in turn already does the needed pinctrl state handling.
>>>
>>> So that default-state should be set up even before the dwmmc probe
>>> function
>>> is called.
>>>
>>> The sharing between sdmmc and uart2 pins is the same on the rk3036
>>> and so
>>> far Caesar seems to have been able to switch the pin-state to sdmmc
>>> without
>>> touching the dw_mmc driver itself.
>>>
>
> Yep, that's working on rk3036 kylin board.
>
>
> ---
> Thanks,
> Caesar
>
>
>


--=20
Best Regards
Shawn Lin

