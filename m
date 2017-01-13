From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 12:03:11 +0800
Message-ID: <5e8ad3d0-7b45-ff4d-feaf-8cf2e78bd3b8@rock-chips.com>
References: <20170106004114.GA22893@archie.localdomain>
 <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain>
 <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com>
 <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:37678 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750900AbdAMEEB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 23:04:01 -0500
In-Reply-To: <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>

On 2017/1/13 11:12, Bough Chen wrote:
>> -----Original Message-----
>> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
>> Sent: Friday, January 13, 2017 10:11 AM
>> To: Ulf Hansson <ulf.hansson@linaro.org>; Clemens Gruber
>> <clemens.gruber@pqgruber.com>
>> Cc: shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; Linus Walleij
>> <linus.walleij@linaro.org>; Adrian Hunter <adrian.hunter@intel.com>; A.S.
>> Dong <aisheng.dong@nxp.com>; linux-kernel@vger.kernel.org; Bough Chen
>> <haibo.chen@nxp.com>; Gary Bisson <gary.bisson@boundarydevices.com>;
>> Fabio Estevam <festevam@gmail.com>; Shawn Guo <shawnguo@kernel.org>
>> Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
>>
>> On 2017/1/13 0:51, Ulf Hansson wrote:
>>> + Haibo, Gary, Fabio, Shawn Gou
>>>
>>> On 6 January 2017 at 16:56, Clemens Gruber
>> <clemens.gruber@pqgruber.com> wrote:
>>>> On Fri, Jan 06, 2017 at 10:33:49AM +0800, Shawn Lin wrote:
>>>>> On 2017/1/6 8:41, Clemens Gruber wrote:
>>>>>> Hi,
>>>>>>
>>>>>> with the current mainline 4.10-rc2 kernel, I can no longer boot
>>>>>> from the eMMC on my i.MX6Q board.
>>>>>>
>>>>>> Details:
>>>>>> The eMMC is a Micron MTFC4GACAJCN-1M WT but as the i.MX6Q only
>>>>>> supports eMMC 4.41 features and we did not implement voltage
>>>>>> switching from 3.3V to 1.8V or lower, I did add no-1-8-v; (but none
>>>>>> of the mmc-ddr or mmc-hs
>>>>>> options) to the device tree. The bus-width is 8.
>>>>>>
>>>>>> With 4.9 the board booted fine, now with the current mainline 4.10
>>>>>> tree, I get the following (repeating) errors at boot:
>>>>>>
>>>>>> [    4.326834] Waiting for root device /dev/mmcblk0p2...
>>>>>> [   14.563861] mmc0: Timeout waiting for hardware cmd interrupt.
>>>>>> [   14.569619] sdhci: =========== REGISTER DUMP
>> (mmc0)===========
>>>>>> [   14.575461] sdhci: Sys addr: 0x4e726000 | Version:  0x00000002
>>>>>> [   14.581300] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>>>>>> [   14.587140] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>>>>>> [   14.592979] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>>>>>> [   14.598816] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>>>>> [   14.604654] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>>>>>> [   14.610493] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>>>>>> [   14.616332] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>>>>>> [   14.622168] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>>>>> [   14.628007] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>>>>>> [   14.633845] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>>>>>
>>>>> it shows you always fail to get resp of sending status within the
>>>>> expected period of time.
>>>>>
>>>>>
>>>>>> [   14.639682] sdhci: Host ctl2: 0x00000000
>>>>>> [   14.643611] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x4e6f7208
>>>>>> [   14.649447] sdhci:
>> ===========================================
>>>>>>
>>>>>> This repeats a few times, then more information is shown at the bottom:
>>>>>>
>>>>>> [   86.893859] mmc0: Timeout waiting for hardware cmd interrupt.
>>>>>> [   86.899615] sdhci: =========== REGISTER DUMP
>> (mmc0)===========
>>>>>> [   86.905453] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
>>>>>> [   86.911291] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>>>>>> [   86.917129] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>>>>>> [   86.922967] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>>>>>> [   86.928804] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>>>>> [   86.934642] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>>>>>> [   86.940479] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>>>>>> [   86.946316] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>>>>>> [   86.952154] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>>>>> [   86.957992] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>>>>>> [   86.963830] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>>>>>> [   86.969668] sdhci: Host ctl2: 0x00000000
>>>>>> [   86.973596] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
>>>>>> [   86.979433] sdhci:
>> ===========================================
>>>>>> [   86.986356] mmc0: switch to bus width 8 ddr failed
>>>>>> [   86.991163] mmc0: error -110 whilst initialising MMC card
>>>>>> [   97.773859] mmc0: Timeout waiting for hardware cmd interrupt.
>>>>>>
>>>>>> --
>>>>>>
>>>>>> After looking through the latest commits to mmc/core, I found the
>>>>>> culprit:
>>>>>> Commit e173f8911f091fa50ccf8cc1fa316dd5569bc470 ("mmc: core:
>> Update
>>>>>> CMD13 polling policy when switch to HS DDR mode")
>>>>>>
>>>>>> Reverting it fixes the problem. But I am unsure if that's the right
>>>>>> course of action?
>>>>>>
>>>>>> Feel free to send me patches for testing!
>>>>>
>>>>> By looking the changes itself, it should be good from the view of spec.
>>>>> Maybe you could try the patch below, but don't beat me if that
>>>>> doesn't help at all. :)
>>>>>
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -1074,7 +1074,7 @@ static int mmc_select_hs_ddr(struct mmc_card
>> *card)
>>>>>                            EXT_CSD_BUS_WIDTH,
>>>>>                            ext_csd_bits,
>>>>>                            card->ext_csd.generic_cmd6_time,
>>>>> -                          MMC_TIMING_MMC_DDR52,
>>>>> +                          0,
>>>>>                            true, true, true);
>>>>>         if (err) {
>>>>>                 pr_err("%s: switch to bus width %d ddr failed\n", @@
>>>>> -1118,6 +1118,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>>>>>         if (err)
>>>>>                 err = __mmc_set_signal_voltage(host,
>>>>> MMC_SIGNAL_VOLTAGE_330);
>>>>>
>>>>> +       if (!err)
>>>>> +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>>>>> +
>>>>>
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> thank you. This patch solves the problem! :)
>>>>
>>>> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
>>>>
>>>> Regards,
>>>> Clemens
>>>
>>> Everybody involved, thanks for looking into this!
>>>
>>> I think the above approach seems like a reasonable fix for the 4.10
>>> rcs. Shawn Lin, would you mind re-posting a proper patch with a
>>> change-log?
>>
>> Sure.
>>
>>>
>>> In the meantime, I will follow the process of Haibo Chen's debugging
>>> around the voltage switch issue and look into what Dong's suggesting
>>> around this may be.
>>>
>>> Just to be clear, I would definitely prefer a fix in the sdhci driver,
>>
>> yup, I prefer to fix the sdhci* either, and given that it's juct -rc3 now, we should
>> still have some days for Haibo & Dong to help debug it.
>> Once the fix is settled, we could drop the core fix from -next branch.
>>
>
> Hi Ulf and Shawn,
>
> Aisheng and I debug this issue these days, and we find the root cause. There are two things
> to describe.
>

Good to know.

> 1) voltage switch issue.  The properity "no-1-8-v" do not work for  MMC_TIMING_MMC_DDR52.
> This is another bug, we need to fix, but has no relation with the current bug.
>

yup, please.

> 2) root cause, in __mmc_switch, the process is   send CMD6 --> set DDR52 timing --> polling for busy.
> For the DDR52 timing setting, we call set_ios(), in the set_ios, we first set DDR_EN to config sdhc in ddr mode,
> and then config the sd clock again.   Here it is, after CMD6 complete, we find data0 still low, which means card
> busy. At this time, if we set DDR_EN, there is a risk. For i.MX usdhc, DDR_EN setting becomes active only when
> the DATA and CMD line are idle. So, at this time for HW, DDR_EN do not active, but software think DDR_EN already
> active, and set the clock again to 49.5MHz, but actually the HW out put the clock as 198MHz. So there is clock glitch.
> This is the root cause--set DDR_EN when card is still busy.
>

Make sense. But it makes me more worried about the problem.
Does it impact other controllers if changing timing settings when
it's in busy state? It seems very likely possible. So I'm afraid
that we now just break hs_ddr mode for your platform but on the
contrary your case exposes this potention risk here. Thought?

> The following method can fix this issue
> a) change the HW behavior, DDR_EN setting becomes active at once no matter what the state of the DATA and
> CMD line are.   This can fix this issue, but our IC guys do not prefer this, this method still not safe enough.
>
> b) add 1ms delay before DDR_EN to wait bus idle.  But we still not know whether the time 1ms is appropriate. Better
> to poll for busy before set DDR_EN.
>
> c) set DDR52 timing after CMD6 and pull for busy. This is what Shawn's patch do.
>
> Hi Aisheng,
> Correct me if anything wrong.
>
> My suggestion is that,  in __mmc_switch(), move the mmc_set_timing() after the function mmc_poll_for_busy().
>
>
> Best Regards
> Haibo Chen
>
>
>
>>> if that can be done. So I will give Haibo/Dong etc a couple of more
>>> days to investigate, before applying Shawn Lin's fix for the core.
>>> Hope that approach is okay with all of you?
>>>
>>> Kind regards
>>> Uffe
>>>
>>>
>>>
>>
>>
>> --
>> Best Regards
>> Shawn Lin
>


-- 
Best Regards
Shawn Lin

