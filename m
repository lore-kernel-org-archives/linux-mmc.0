From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 12:45:13 +0800
Message-ID: <CAA+hA=QApBAak-g9X637_8S_3nfAgiE-ueMY3giiVUvJ=cRd1A@mail.gmail.com>
References: <20170106004114.GA22893@archie.localdomain> <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain> <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com> <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <5e8ad3d0-7b45-ff4d-feaf-8cf2e78bd3b8@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e8ad3d0-7b45-ff4d-feaf-8cf2e78bd3b8@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Fri, Jan 13, 2017 at 12:03 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:

[...]

>
>> 2) root cause, in __mmc_switch, the process is   send CMD6 --> set DDR52
>> timing --> polling for busy.
>> For the DDR52 timing setting, we call set_ios(), in the set_ios, we first
>> set DDR_EN to config sdhc in ddr mode,
>> and then config the sd clock again.   Here it is, after CMD6 complete, we
>> find data0 still low, which means card
>> busy. At this time, if we set DDR_EN, there is a risk. For i.MX usdhc,
>> DDR_EN setting becomes active only when
>> the DATA and CMD line are idle. So, at this time for HW, DDR_EN do not
>> active, but software think DDR_EN already
>> active, and set the clock again to 49.5MHz, but actually the HW out put
>> the clock as 198MHz. So there is clock glitch.
>> This is the root cause--set DDR_EN when card is still busy.
>>
>
> Make sense. But it makes me more worried about the problem.
> Does it impact other controllers if changing timing settings when
> it's in busy state? It seems very likely possible. So I'm afraid
> that we now just break hs_ddr mode for your platform but on the
> contrary your case exposes this potention risk here. Thought?
>

Yes, i got the same concern as i replied in my last email.
Not sure if any other controllers exposes the same issue
since the kernel having this issue is quite new.

Regards
Dong Aisheng

>> The following method can fix this issue
>> a) change the HW behavior, DDR_EN setting becomes active at once no matter
>> what the state of the DATA and
>> CMD line are.   This can fix this issue, but our IC guys do not prefer
>> this, this method still not safe enough.
>>
>> b) add 1ms delay before DDR_EN to wait bus idle.  But we still not know
>> whether the time 1ms is appropriate. Better
>> to poll for busy before set DDR_EN.
>>
>> c) set DDR52 timing after CMD6 and pull for busy. This is what Shawn's
>> patch do.
>>
>> Hi Aisheng,
>> Correct me if anything wrong.
>>
>> My suggestion is that,  in __mmc_switch(), move the mmc_set_timing() after
>> the function mmc_poll_for_busy().
>>
>>
>> Best Regards
>> Haibo Chen
>>
>>
>>
>>>> if that can be done. So I will give Haibo/Dong etc a couple of more
>>>> days to investigate, before applying Shawn Lin's fix for the core.
>>>> Hope that approach is okay with all of you?
>>>>
>>>> Kind regards
>>>> Uffe
>>>>
>>>>
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Shawn Lin
>>
>>
>
>
> --
> Best Regards
> Shawn Lin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
