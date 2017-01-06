From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 6 Jan 2017 10:54:35 +0800
Message-ID: <75eba190-ab58-ccdc-aaf7-569f107c695a@rock-chips.com>
References: <20170106004114.GA22893@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:57237 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032066AbdAFC51 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2017 21:57:27 -0500
In-Reply-To: <20170106004114.GA22893@archie.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org

On 2017/1/6 8:41, Clemens Gruber wrote:
> Hi,
>
> with the current mainline 4.10-rc2 kernel, I can no longer boot from
> the eMMC on my i.MX6Q board.
>
> Details:
> The eMMC is a Micron MTFC4GACAJCN-1M WT but as the i.MX6Q only supports
> eMMC 4.41 features and we did not implement voltage switching from 3.3V
> to 1.8V or lower, I did add no-1-8-v; (but none of the mmc-ddr or mmc-hs
> options) to the device tree. The bus-width is 8.
>
> With 4.9 the board booted fine, now with the current mainline 4.10 tree,
> I get the following (repeating) errors at boot:
>
> [    4.326834] Waiting for root device /dev/mmcblk0p2...
> [   14.563861] mmc0: Timeout waiting for hardware cmd interrupt.
> [   14.569619] sdhci: =========== REGISTER DUMP (mmc0)===========
> [   14.575461] sdhci: Sys addr: 0x4e726000 | Version:  0x00000002
> [   14.581300] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
> [   14.587140] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
> [   14.592979] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
> [   14.598816] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
> [   14.604654] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
> [   14.610493] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
> [   14.616332] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
> [   14.622168] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
> [   14.628007] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
> [   14.633845] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
> [   14.639682] sdhci: Host ctl2: 0x00000000
> [   14.643611] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x4e6f7208
> [   14.649447] sdhci: ===========================================
>
> This repeats a few times, then more information is shown at the bottom:
>
> [   86.893859] mmc0: Timeout waiting for hardware cmd interrupt.
> [   86.899615] sdhci: =========== REGISTER DUMP (mmc0)===========
> [   86.905453] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
> [   86.911291] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
> [   86.917129] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
> [   86.922967] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
> [   86.928804] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
> [   86.934642] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
> [   86.940479] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
> [   86.946316] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
> [   86.952154] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
> [   86.957992] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
> [   86.963830] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
> [   86.969668] sdhci: Host ctl2: 0x00000000
> [   86.973596] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> [   86.979433] sdhci: ===========================================
> [   86.986356] mmc0: switch to bus width 8 ddr failed
> [   86.991163] mmc0: error -110 whilst initialising MMC card
> [   97.773859] mmc0: Timeout waiting for hardware cmd interrupt.
>
> --
>
> After looking through the latest commits to mmc/core, I found the
> culprit:
> Commit e173f8911f091fa50ccf8cc1fa316dd5569bc470 ("mmc: core: Update
> CMD13 polling policy when switch to HS DDR mode")
>
> Reverting it fixes the problem. But I am unsure if that's the right
> course of action?
>
> Feel free to send me patches for testing!
>

I just look into both of sdhci and sdhci-esdhc-imx again, and seems the
code miss a bit, so could you also try this one?

drivers/mmc/core/mmc_ops.c
@@ -486,7 +486,8 @@ static int mmc_poll_for_busy(struct mmc_card *card, 
unsigned int timeout_ms,
                         busy = host->ops->card_busy(host);
                 } else {
                         err = mmc_send_status(card, &status);
-                       if (retry_crc_err && err == -EILSEQ) {
+                       if (retry_crc_err && (err == -EILSEQ ||
+                                               err == -ETIMEDOUT)) {
                                 busy = true;
                         } else if (err) {
                                 return err;




> Regards,
> Clemens
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

