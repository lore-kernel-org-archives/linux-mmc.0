From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 12:40:41 +0800
Message-ID: <CAA+hA=RgoMkZJxZpH=AaKpBuTnmdbr8J+ew2EwEP=XBf=a7-Mg@mail.gmail.com>
References: <20170106004114.GA22893@archie.localdomain> <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain> <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com> <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34303 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdAMElf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 23:41:35 -0500
In-Reply-To: <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>

On Fri, Jan 13, 2017 at 11:12 AM, Bough Chen <haibo.chen@nxp.com> wrote:
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
>> > + Haibo, Gary, Fabio, Shawn Gou
>> >
>> > On 6 January 2017 at 16:56, Clemens Gruber
>> <clemens.gruber@pqgruber.com> wrote:
>> >> On Fri, Jan 06, 2017 at 10:33:49AM +0800, Shawn Lin wrote:
>> >>> On 2017/1/6 8:41, Clemens Gruber wrote:
>> >>>> Hi,
>> >>>>
>> >>>> with the current mainline 4.10-rc2 kernel, I can no longer boot
>> >>>> from the eMMC on my i.MX6Q board.
>> >>>>
>> >>>> Details:
>> >>>> The eMMC is a Micron MTFC4GACAJCN-1M WT but as the i.MX6Q only
>> >>>> supports eMMC 4.41 features and we did not implement voltage
>> >>>> switching from 3.3V to 1.8V or lower, I did add no-1-8-v; (but none
>> >>>> of the mmc-ddr or mmc-hs
>> >>>> options) to the device tree. The bus-width is 8.
>> >>>>
>> >>>> With 4.9 the board booted fine, now with the current mainline 4.10
>> >>>> tree, I get the following (repeating) errors at boot:
>> >>>>
>> >>>> [    4.326834] Waiting for root device /dev/mmcblk0p2...
>> >>>> [   14.563861] mmc0: Timeout waiting for hardware cmd interrupt.
>> >>>> [   14.569619] sdhci: =========== REGISTER DUMP
>> (mmc0)===========
>> >>>> [   14.575461] sdhci: Sys addr: 0x4e726000 | Version:  0x00000002
>> >>>> [   14.581300] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>> >>>> [   14.587140] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>> >>>> [   14.592979] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>> >>>> [   14.598816] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>> >>>> [   14.604654] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>> >>>> [   14.610493] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>> >>>> [   14.616332] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>> >>>> [   14.622168] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>> >>>> [   14.628007] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>> >>>> [   14.633845] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>> >>>
>> >>> it shows you always fail to get resp of sending status within the
>> >>> expected period of time.
>> >>>
>> >>>
>> >>>> [   14.639682] sdhci: Host ctl2: 0x00000000
>> >>>> [   14.643611] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x4e6f7208
>> >>>> [   14.649447] sdhci:
>> ===========================================
>> >>>>
>> >>>> This repeats a few times, then more information is shown at the bottom:
>> >>>>
>> >>>> [   86.893859] mmc0: Timeout waiting for hardware cmd interrupt.
>> >>>> [   86.899615] sdhci: =========== REGISTER DUMP
>> (mmc0)===========
>> >>>> [   86.905453] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
>> >>>> [   86.911291] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
>> >>>> [   86.917129] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
>> >>>> [   86.922967] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
>> >>>> [   86.928804] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
>> >>>> [   86.934642] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
>> >>>> [   86.940479] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
>> >>>> [   86.946316] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
>> >>>> [   86.952154] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
>> >>>> [   86.957992] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
>> >>>> [   86.963830] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
>> >>>> [   86.969668] sdhci: Host ctl2: 0x00000000
>> >>>> [   86.973596] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
>> >>>> [   86.979433] sdhci:
>> ===========================================
>> >>>> [   86.986356] mmc0: switch to bus width 8 ddr failed
>> >>>> [   86.991163] mmc0: error -110 whilst initialising MMC card
>> >>>> [   97.773859] mmc0: Timeout waiting for hardware cmd interrupt.
>> >>>>
>> >>>> --
>> >>>>
>> >>>> After looking through the latest commits to mmc/core, I found the
>> >>>> culprit:
>> >>>> Commit e173f8911f091fa50ccf8cc1fa316dd5569bc470 ("mmc: core:
>> Update
>> >>>> CMD13 polling policy when switch to HS DDR mode")
>> >>>>
>> >>>> Reverting it fixes the problem. But I am unsure if that's the right
>> >>>> course of action?
>> >>>>
>> >>>> Feel free to send me patches for testing!
>> >>>
>> >>> By looking the changes itself, it should be good from the view of spec.
>> >>> Maybe you could try the patch below, but don't beat me if that
>> >>> doesn't help at all. :)
>> >>>
>> >>> --- a/drivers/mmc/core/mmc.c
>> >>> +++ b/drivers/mmc/core/mmc.c
>> >>> @@ -1074,7 +1074,7 @@ static int mmc_select_hs_ddr(struct mmc_card
>> *card)
>> >>>                            EXT_CSD_BUS_WIDTH,
>> >>>                            ext_csd_bits,
>> >>>                            card->ext_csd.generic_cmd6_time,
>> >>> -                          MMC_TIMING_MMC_DDR52,
>> >>> +                          0,
>> >>>                            true, true, true);
>> >>>         if (err) {
>> >>>                 pr_err("%s: switch to bus width %d ddr failed\n", @@
>> >>> -1118,6 +1118,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>> >>>         if (err)
>> >>>                 err = __mmc_set_signal_voltage(host,
>> >>> MMC_SIGNAL_VOLTAGE_330);
>> >>>
>> >>> +       if (!err)
>> >>> +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>> >>> +
>> >>>
>> >>>
>> >>
>> >> Hi,
>> >>
>> >> thank you. This patch solves the problem! :)
>> >>
>> >> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
>> >>
>> >> Regards,
>> >> Clemens
>> >
>> > Everybody involved, thanks for looking into this!
>> >
>> > I think the above approach seems like a reasonable fix for the 4.10
>> > rcs. Shawn Lin, would you mind re-posting a proper patch with a
>> > change-log?
>>
>> Sure.
>>
>> >
>> > In the meantime, I will follow the process of Haibo Chen's debugging
>> > around the voltage switch issue and look into what Dong's suggesting
>> > around this may be.
>> >
>> > Just to be clear, I would definitely prefer a fix in the sdhci driver,
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
> 1) voltage switch issue.  The properity "no-1-8-v" do not work for  MMC_TIMING_MMC_DDR52.
> This is another bug, we need to fix, but has no relation with the current bug.
>
> 2) root cause, in __mmc_switch, the process is   send CMD6 --> set DDR52 timing --> polling for busy.
> For the DDR52 timing setting, we call set_ios(), in the set_ios, we first set DDR_EN to config sdhc in ddr mode,
> and then config the sd clock again.   Here it is, after CMD6 complete, we find data0 still low, which means card
> busy. At this time, if we set DDR_EN, there is a risk. For i.MX usdhc, DDR_EN setting becomes active only when
> the DATA and CMD line are idle. So, at this time for HW, DDR_EN do not active, but software think DDR_EN already
> active, and set the clock again to 49.5MHz, but actually the HW out put the clock as 198MHz. So there is clock glitch.
> This is the root cause--set DDR_EN when card is still busy.
>
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

Haibo, thx for the summary.

I would try to simply things a bit based on Haibo's description!

To be simple, i'd only talking IMX case of the issue that host without
MMC_CAP_WAIT_WHILE_BUSY.

The current process of mmc_select_hs_ddr handling is:
Set card DDR52 timing (CMD6)->
Set host DDR52 timing ->                  (IMX issue happens at this step)
Polling switch done by card_busy()->
CMD13 to re-check

What the issue here is that IMX can't allow to change host timing(DDREN bit)
when card is still busy on the switch process (CMD6).
It's unsafe and may cause host unwork.

Currently host timing change set_ios(TIMING_DDR52) will gate off host clock,
change timing, re-enable clock.

Two issue in this process:
1) In theory we seem should not gate off clock due to card reply on this lock
to release the bus busy line.
(Actually IMX HW can't support gate off clock when data line busy)

2) Can't guarantee host timing changes won't cause any issue when card is
still busy.

It looks to me according to spec, we probably should't change host timing
before the card timing change done.
Because normally with a good host supporting R1B CMD well,
CMD6 won't finish before the card timing switch done.

Then the correct process would simply be:
Set card DDR52 timing (CMD6) ->
CMD6 completed and busy done ->
Set host DDR52 timing ->
CMD13 to re-check

We added a lot tricks to support host without MMC_CAP_WAIT_WHILE_BUSY,
e.g. via ops->card_busy().

If we want to follow above standard process to do the timing change .
We could do as:
Set card DDR52 timing (CMD6) ->
card_busy() done ->
Set host DDR52 timing ->
CMD13 to re-check

Below is the draft patch for above approach and simply test works.


diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index b11c345..3368b1a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -451,7 +451,8 @@ int mmc_switch_status(struct mmc_card *card)
 }

 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-                       bool send_status, bool retry_crc_err)
+                       bool send_status, bool retry_crc_err,
+                       unsigned char timing)
 {
        struct mmc_host *host = card->host;
        int err;
@@ -506,8 +507,11 @@ static int mmc_poll_for_busy(struct mmc_card
*card, unsigned int timeout_ms,
                }
        } while (busy);

-       if (host->ops->card_busy && send_status)
+       if (host->ops->card_busy && send_status) {
+               if (timing)
+                       mmc_set_timing(host, timing);
                return mmc_switch_status(card);
+       }

        return 0;
 }
@@ -577,8 +581,13 @@ int __mmc_switch(struct mmc_card *card, u8 set,
u8 index, u8 value,
        if (!use_busy_signal)
                goto out;

-       /* Switch to new timing before poll and check switch status. */
-       if (timing)
+       /*
+       * Switch to new timing before poll and check switch status.
+       *
+       * If host supports ops->card_busy(), we'd set timing later
+       * after card busy is done, this can avoid potential glitch.
+       */
+       if (timing && !host->ops->card_busy)
                mmc_set_timing(host, timing);

        /*If SPI or used HW busy detection above, then we don't need to poll. */
@@ -590,7 +599,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
index, u8 value,
        }

        /* Let's try to poll to find out when the command is completed. */
-       err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
+       err = mmc_poll_for_busy(card, timeout_ms, send_status,
retry_crc_err, timing);

 out_tim:
        if (err && timing)


However, if we want to make things simply, i'm also ok with Shawn's patch
that make sure host timing is only changed after the card timing switch polling
is done (although host was in old timing).
Because usually host in low speed mode timing normally should work for card in
new high speed mode timing in theory.

Ulf, count on you!

Regards
Dong Aisheng

> Best Regards
> Haibo Chen
>
>
>
>> > if that can be done. So I will give Haibo/Dong etc a couple of more
>> > days to investigate, before applying Shawn Lin's fix for the core.
>> > Hope that approach is okay with all of you?
>> >
>> > Kind regards
>> > Uffe
>> >
>> >
>> >
>>
>>
>> --
>> Best Regards
>> Shawn Lin
>
