From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Tue, 31 Jan 2017 21:56:51 +0100
Message-ID: <20170131205651.GG6017@bigcity.dyn.berto.se>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
 <20170123111639.nymy775co2uckxu2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123111639.nymy775co2uckxu2@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram and Simon,

On 2017-01-23 12:16:39 +0100, Wolfram Sang wrote:
> Hi Niklas,
> 
> so I scratched my head around this a little more... I don't have an
> explanation, but want to highlight some interesting points:
> 
> > [    2.954859] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
> 
> So, this is an SDR50 card. The patch in questions adds tuning support
> which is only needed for SDR104. The whole tuning procedure is not (or
> at least should not be) exercised.
> 
> > Oddly enough the error are only printed when I insert the SD card in the 
> > mmc0 slot. I can insert/eject the card multiple times in mmc1 and no 
> > error but the first insertion in mmc0 and boom. Only difference I can 
> > see are the clock speed between mmc0 and mmc1.
> 
> That actually makes sense. mmc0 is SDR104 capable and has the SCC unit
> which is needed for tuning (note the larger register space in the dtsi).
> The other mmc cores do only SDR50 and do not have an SCC. Because your
> warning is about a broken pointer, I wonder if it is about accessing
> SCC? Maybe in hw_reset? Wild guess, though. On the other hand, the
> register ranges in the dtsi look ok, so I'd assume the IPMMU should have
> all the info it needs? But I don't really know...

Thanks for the explanation, now I understand why it only happens on 
mmc0.

> 
> First thing to try: please remove the property "sd-uhs-sdr104;" from
> your Koelsch DTS. I'd expect this makes the warnings go away. If so,
> readd the property and instrument if sh_mobile_sdhi_hw_reset() gets
> called. One outcome might be that the printouts might be tied to the
> warnings.

I played around a bit with what you suggested above and here are my 
observations:

1. Removing "sd-uhs-sdr104;" from my Koelsch DTS do indeed make the 
   warning go away.

2. sh_mobile_sdhi_hw_reset() is called each time I insert the card. The 
   warning is as previously stated triggered on the first insertion.

3. If I turn the sh_mobile_sdhi_hw_reset() into a noop function (just 
   return without doing anything) the warning gets printed each time the 
   card is inserted.

As it turns out sh_mobile_sdhi_hw_reset() have something to do with the 
warnings and was a good point for me to start digging at.

The warning originates from mmc_send_tuning() inside a loop in
tmio_mmc_execute_tuning():

    /* Issue CMD19 twice for each tap */
    for (i = 0; i < 2 * host->tap_num; i++) {
            if (host->prepare_tuning)
                    host->prepare_tuning(host, i % host->tap_num);

            ret = mmc_send_tuning(mmc, opcode, NULL);
            if (ret && ret != -EILSEQ)
                    goto out;
            if (ret == 0)
                    set_bit(i, host->taps);

            mdelay(1);
    }

The warning is printed for me on loop iteration 7 and 15, which if I 
understand things correctly is for the same tap (7)?

If I track mmc_send_tuning() it looks like t starts a command 
(__mmc_start_req()) and then waits for it to finish 
(mmc_wait_for_req_done()) and it is in between these calls our warning 
is printed.

If i dig a bit deeper starting at __mmc_start_req() I end up where I 
think the command which generates the warning is issued to the hardware 
in tmio_mmc_start_command(). Simplified call graph:

tmio_mmc_execute_tuning()
  mmc_send_tuning()
    mmc_wait_for_req()
      __mmc_start_req()
        ...
          ...
            tmio_mmc_start_command()
      mmc_wait_for_req_done()

At the very end of  tmio_mmc_start_command() the command is fired to the 
hardware and it's right after that the warning is printed. With a bit 
creative msleep() and pr_info() I think I can confirm this like this:

   /* Fire off the command */
   sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
   pr_info("%s 1\n", __func__);
   msleep(1000);
   pr_info("%s 2\n", __func__);
   sd_ctrl_write16(host, CTL_SD_CMD, c);
   pr_info("%s 3\n", __func__);
   msleep(1000);
   pr_info("%s 4\n", __func__);

Which gives the output for the loop itteration 7 and 15 in 
tmio_mmc_execute_tuning():

[  136.046594] tmio_mmc_start_command 1
[  137.116454] tmio_mmc_start_command 2
[  137.122399] tmio_mmc_start_command 3
[  137.122461] ipmmu-vmsa e6740000.mmu: Unhandled fault: status 0x00002101 iova 0x40002000
[  138.156454] tmio_mmc_start_command 4

Arriving at this I feel my knowledge reached its limit and would like to 
hear what you think about my findings and possible fix? First of is this 
a possible place for the warning to originate?

Why do it only happen for tap 7? Tap 0-6 are fine. I did double check 
the TAPNUM from sh_mobile_sdhi_init_tuning() return 8. And that the 
TAPNUMS used in sh_mobile_sdhi_prepare_tuning() is in the range 0-7.  
This should as far as I understand the docs be correct?

I do however have a patch that makes the warnings go away :-) But I 
would like to hear what you have to say about the above and about the 
patch itself before I send it of as a real patch, my knowledge about 
this driver is rudimentary at best and the patch is just a product of 
what I learnt while investigating this issue.

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2064fa1a5bf11f9a..1483902a1e323adb 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -824,6 +824,9 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
        bitmap_zero(host->taps, host->tap_num * 2);
 
+       /* Reset hardware before tuning */
+       tmio_mmc_hw_reset(mmc);
+
        /* Issue CMD19 twice for each tap */
        for (i = 0; i < 2 * host->tap_num; i++) {
                if (host->prepare_tuning)

Let me know if you think this is a suitable fix and I will resend it as 
a proper patch. Whit this applied the warnings are no more and I can 
properly interact with the card, I do however only have a SDR50 card to 
try with.

> 
> > I can interact fine with the card (I tried checksumming a large file and 
> > compared with a known good) so it's not broken. I can also interact with 
> > other devices using the DMAC+IPMMU without similar warnings being 
> > printed at all, I tested with i2c6.
> 
> That is relieving and also makes sense in the way that nothing in this
> patch should be needed to get an SDR50 card running.
> 
> Regards,
> 
>    Wolfram
> 


-- 
Regards,
Niklas Söderlund
