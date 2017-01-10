From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Tue, 10 Jan 2017 09:04:32 +0800
Message-ID: <bafef0b9-aac5-54a7-b1ea-36fd2df5e221@rock-chips.com>
References: <20170106004114.GA22893@archie.localdomain>
 <75eba190-ab58-ccdc-aaf7-569f107c695a@rock-chips.com>
 <20170106160708.GB10105@archie.localdomain>
 <CAD6G_RSedKUKVSn85yK1ZhC8eLOqvCSnJxDHi7pATo7B5_kNgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45855 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755917AbdAJBFZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 20:05:25 -0500
In-Reply-To: <CAD6G_RSedKUKVSn85yK1ZhC8eLOqvCSnJxDHi7pATo7B5_kNgA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jagan Teki <jagan@openedev.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jagan,

On 2017/1/10 6:25, Jagan Teki wrote:
> On Fri, Jan 6, 2017 at 5:07 PM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
>> On Fri, Jan 06, 2017 at 10:54:35AM +0800, Shawn Lin wrote:
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
>>>>
>>>
>>> I just look into both of sdhci and sdhci-esdhc-imx again, and seems the
>>> code miss a bit, so could you also try this one?
>>>
>>> drivers/mmc/core/mmc_ops.c
>>> @@ -486,7 +486,8 @@ static int mmc_poll_for_busy(struct mmc_card *card,
>>> unsigned int timeout_ms,
>>>                         busy = host->ops->card_busy(host);
>>>                 } else {
>>>                         err = mmc_send_status(card, &status);
>>> -                       if (retry_crc_err && err == -EILSEQ) {
>>> +                       if (retry_crc_err && (err == -EILSEQ ||
>>> +                                               err == -ETIMEDOUT)) {
>>>                                 busy = true;
>>>                         } else if (err) {
>>>                                 return err;
>>>
>>
>> Hi,
>>
>> this patch (alone) does not solve the problem. The error message is the
>> same as before.
>>
>> But applying both your first patch and this one does work. Is this one
>> beneficial anyway, even if it does not fix my problem?
>
> Able to detect the eMMC, but getting kernel panic while formatting the
> disk, (even remove the mmc_ops change)

Both of my test patch and Ulf's patchset didn't touch that area.
Given that the log didn't show up too much useful infomation, it
is hard to say you should blame for these change.

Could you help do git-bitsect and try to find out the problematic
commit?

>
> Log:
> ----
> Disk /dev/mmcblk1: 3791 MB, 3791650816 bytes
> 4 heads, 16 sectors/track, 115712 cylinders
> Units = cylinders of 64 * 512 = 32768 bytes
>
>         Device Boot      Start         End      Blocks  Id System
> /dev/mmcblk1p1               1      115712     3702776  83 Linux
>
>
> Maximum filesystem blocks=4194304
> 29 block groups
> 32768 blocks per group, 32768 fragments per group
> 7984 inodes per group
> Superblock backups stored on blocks:
>         32768, 98304, 163840, 229376, 294912, 819200, 884736
> [  256.769236] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000004
> [  256.769236]
> [  256.778779] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x00000004
> [  256.778779]
>
> Jagan.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

