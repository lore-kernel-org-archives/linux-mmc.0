From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 10:10:35 +0800
Message-ID: <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com>
References: <20170106004114.GA22893@archie.localdomain>
 <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain>
 <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2017/1/13 0:51, Ulf Hansson wrote:
> + Haibo, Gary, Fabio, Shawn Gou
>
> On 6 January 2017 at 16:56, Clemens Gruber <clemens.gruber@pqgruber.com> wrote:
>> On Fri, Jan 06, 2017 at 10:33:49AM +0800, Shawn Lin wrote:
>>> On 2017/1/6 8:41, Clemens Gruber wrote:
>>>> Hi,
>>>>
>>>> with the current mainline 4.10-rc2 kernel, I can no longer boot from
>>>> the eMMC on my i.MX6Q board.
>>>>
>>>> Details:
>>>> The eMMC is a Micron MTFC4GACAJCN-1M WT but as the i.MX6Q only supports
>>>> eMMC 4.41 features and we did not implement voltage switching from 3.3V
>>>> to 1.8V or lower, I did add no-1-8-v; (but none of the mmc-ddr or mmc-hs
>>>> options) to the device tree. The bus-width is 8.
>>>>
>>>> With 4.9 the board booted fine, now with the current mainline 4.10 tree,
>>>> I get the following (repeating) errors at boot:
>>>>
>>>> [    4.326834] Waiting for root device /dev/mmcblk0p2...
>>>> [   14.563861] mmc0: Timeout waiting for hardware cmd interrupt.
>>>> [   14.569619] sdhci: =========== REGISTER DUMP (mmc0)===========
>>>> [   14.575461] sdhci: Sys addr: 0x4e726000 | Version:  0x00000002
>>>> [   14.581300] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>>>> [   14.587140] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>>>> [   14.592979] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>>>> [   14.598816] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>>> [   14.604654] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>>>> [   14.610493] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>>>> [   14.616332] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>>>> [   14.622168] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>>> [   14.628007] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>>>> [   14.633845] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>>>
>>> it shows you always fail to get resp of sending status within the
>>> expected period of time.
>>>
>>>
>>>> [   14.639682] sdhci: Host ctl2: 0x00000000
>>>> [   14.643611] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x4e6f7208
>>>> [   14.649447] sdhci: ===========================================
>>>>
>>>> This repeats a few times, then more information is shown at the bottom:
>>>>
>>>> [   86.893859] mmc0: Timeout waiting for hardware cmd interrupt.
>>>> [   86.899615] sdhci: =========== REGISTER DUMP (mmc0)===========
>>>> [   86.905453] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
>>>> [   86.911291] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>>>> [   86.917129] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>>>> [   86.922967] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>>>> [   86.928804] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>>>> [   86.934642] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>>>> [   86.940479] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>>>> [   86.946316] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>>>> [   86.952154] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>>>> [   86.957992] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>>>> [   86.963830] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>>>> [   86.969668] sdhci: Host ctl2: 0x00000000
>>>> [   86.973596] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
>>>> [   86.979433] sdhci: ===========================================
>>>> [   86.986356] mmc0: switch to bus width 8 ddr failed
>>>> [   86.991163] mmc0: error -110 whilst initialising MMC card
>>>> [   97.773859] mmc0: Timeout waiting for hardware cmd interrupt.
>>>>
>>>> --
>>>>
>>>> After looking through the latest commits to mmc/core, I found the
>>>> culprit:
>>>> Commit e173f8911f091fa50ccf8cc1fa316dd5569bc470 ("mmc: core: Update
>>>> CMD13 polling policy when switch to HS DDR mode")
>>>>
>>>> Reverting it fixes the problem. But I am unsure if that's the right
>>>> course of action?
>>>>
>>>> Feel free to send me patches for testing!
>>>
>>> By looking the changes itself, it should be good from the view of spec.
>>> Maybe you could try the patch below, but don't beat me if that doesn't
>>> help at all. :)
>>>
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1074,7 +1074,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>>>                            EXT_CSD_BUS_WIDTH,
>>>                            ext_csd_bits,
>>>                            card->ext_csd.generic_cmd6_time,
>>> -                          MMC_TIMING_MMC_DDR52,
>>> +                          0,
>>>                            true, true, true);
>>>         if (err) {
>>>                 pr_err("%s: switch to bus width %d ddr failed\n",
>>> @@ -1118,6 +1118,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>>>         if (err)
>>>                 err = __mmc_set_signal_voltage(host,
>>> MMC_SIGNAL_VOLTAGE_330);
>>>
>>> +       if (!err)
>>> +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>>> +
>>>
>>>
>>
>> Hi,
>>
>> thank you. This patch solves the problem! :)
>>
>> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
>>
>> Regards,
>> Clemens
>
> Everybody involved, thanks for looking into this!
>
> I think the above approach seems like a reasonable fix for the 4.10
> rcs. Shawn Lin, would you mind re-posting a proper patch with a
> change-log?

Sure.

>
> In the meantime, I will follow the process of Haibo Chen's debugging
> around the voltage switch issue and look into what Dong's suggesting
> around this may be.
>
> Just to be clear, I would definitely prefer a fix in the sdhci driver,

yup, I prefer to fix the sdhci* either, and given that it's juct -rc3
now, we should still have some days for Haibo & Dong to help debug it.
Once the fix is settled, we could drop the core fix from -next branch.

> if that can be done. So I will give Haibo/Dong etc a couple of more
> days to investigate, before applying Shawn Lin's fix for the core.
> Hope that approach is okay with all of you?
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin
