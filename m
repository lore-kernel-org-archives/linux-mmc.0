From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCHv2] mmc: dw_mmc: change to use recommended reset procedure
Date: Fri, 16 May 2014 17:36:21 -0700
Message-ID: <CAPz6YkVF4VsgMAi4t=KxRcDU=TDzzRCoSPO-cQa6qMESVSgo9g@mail.gmail.com>
References: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
 <002301cf6e68$8809ee00$981dca00$%jun@samsung.com> <CAPz6YkWObQe86MZYmyLrbYOkQ4hHkb2Hcpe8QZWDZCMO5U0f_Q@mail.gmail.com>
 <002a01cf6e9b$c0538900$40fa9b00$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:48216 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbaEQAgm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 May 2014 20:36:42 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so5362353qgd.24
        for <linux-mmc@vger.kernel.org>; Fri, 16 May 2014 17:36:41 -0700 (PDT)
In-Reply-To: <002a01cf6e9b$c0538900$40fa9b00$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Douglas Anderson <dianders@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On Tue, May 13, 2014 at 4:09 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Tuesday, May 13, Sonny Rao wrote:
>> On Mon, May 12, 2014 at 10:02 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > As I mentioned in previous version, you put all reset stuff in existing fifo_reset function.
>> > Although databook mentions ciu_reset case for SBE error, it's not obvious when ciu_reset is needed
>> in other error cases.
>> > If you intend to add some robust error handing, it would be better to make another function.
>>
>> The document I have actually doesn't mention error cases, it describes
>> this procedure as "Controller/DMA/FIFO Reset Usage" so I believe it is
>> saying this is the correct procedure in all cases, and based on our
>> testing it seems to work.  I understand the skepticism, as I shared it
>> initially when I saw this, but based on our experience, this is
>> correct and it doesn't need to live in a separate function.
> I agree this active error handling.
> But, existing fifo_reset function is focused on fifo reset purely.
> I think your change is close to error recovery and it seems overloaded to basic function.
> So, you suggest renaming function for new sequence.

I think the documentation says it should always be done, not just in
error recovery.  I can rename the function to dw_mci_reset rather than
dw_mci_fifo_reset.  Is that what you mean? Or do you mean make a new
function that is only called in error cases?

> And look into dw_mci_work_routine_card(). dw_mci_idmac_reset() is redundancy.
> I expect it can be cleaned.
>
> <Quot>
>                                 /* Clear down the FIFO */
>                                 dw_mci_fifo_reset(host);
> #ifdef CONFIG_MMC_DW_IDMAC
>                                 dw_mci_idmac_reset(host);
> #endif
> </Quot>
>

Ok, I'll remove that extra reset, thanks for catching.

>>
>> > Please check my comments below.
>> >
>> > On Tue, May 13, 2014, Sonny Rao wrote:
>> >> This patch changes the fifo reset code to follow the reset procedure
>> >> outlined in the documentation of Synopsys  Mobile storage host databook
>> >> 7.2.13.
> Please remove this section number.
> No needed. It's old version.
>

Ok

>> >>
>> >> v2: Add Generic DMA support
>> >>     per the documentation, move interrupt clear before wait
>> >>     make the test for DMA host->use_dma rather than host->using_dma
>> >>     add proper return values (although it appears no caller checks)
>> >>
>> >> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> >> ---
>> >>  drivers/mmc/host/dw_mmc.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
>> >>  drivers/mmc/host/dw_mmc.h |  1 +
>> >>  2 files changed, 55 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> >> index 55cd110..aff57e1 100644
>> >> --- a/drivers/mmc/host/dw_mmc.c
>> >> +++ b/drivers/mmc/host/dw_mmc.c
>> >> @@ -2325,6 +2325,7 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
>> >>
>> >>  static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>> >>  {
>> >> +     u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
>> >>       /*
>> >>        * Reseting generates a block interrupt, hence setting
>> >>        * the scatter-gather pointer to NULL.
>> >> @@ -2334,7 +2335,59 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>> >>               host->sg = NULL;
>> >>       }
>> >>
>> >> -     return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
>> >> +     /*
>> >> +      * The recommended method for resetting is to always reset the
>> >> +      * controller and the fifo, but differs slightly depending on the mode.
>> >> +      * The Generic DMA mode (non IDMAC) also needs to reset DMA where IDMAC
>> >> +      * mode resets IDMAC at the end.
>> >> +      *
>> >> +      */
>> >> +#ifndef CONFIG_MMC_DW_IDMAC
>> > Is it added for generic DMA?
>> > IDMAC should be considered for dma_reseet as well.
>> > Please check databook.
>> >
>>
>> Yeah it's a little unclear.  In the "7.2.13 Controller/DMA/FIFO Reset
>> Usage" part of the document they mention It is set for what they call
>> "generic" DMA, which I think is when there is an external DMA
>> controller, and the part below that it says for "DW-DMA/Non-DW-DMA"
>> that controller_reset and fifo_reset should be set.   I believe this
>> "DW-DMA" case refers to what is called IDMAC.  So, I think it's not
>> required for this case, but I admit I'm not sure why they also say
>> "Non-DW-DMA". If you know of a good way to differentiate the "Generic
>> DMA" case  I can implement it.  It wasn't clear to me if the driver
>> even supported this "generic" dma case, but it sounds like it might,
>> so I added this code.  In practice, on the Exynos Systems we have,
>> which are using IDMAC, the reset procedure seems to work okay without
>> the dma_reset bit set, but I cannot test this "generic dma" case.
>>
>> The other places in the doc where I see them mention the dma_reset bit
>> are "7.2.21 Transmission and Reception with Internal DMAC (IDMAC)"
>> and the description of the CTRL register, and in "7.1
>> Software/Hardware Restrictions" where they say it will terminate any
>> pending transfer.
> "DW-DMA" means Synopsys's DMA controller not IDMAC.
> SDMMC_CTRL_DMA_RESET can apply in all type DMA interface.

So, do you think I should always set that bit if we're using DMA?

>
>>
>> >> +     if (host->use_dma)
>> >> +             flags |= SDMMC_CTRL_DMA_RESET;
>> >> +#endif
>> >> +     if (dw_mci_ctrl_reset(host, flags)) {
>> >> +             /*
>> >> +              * In all cases we clear the RAWINTS register to clear any
>> >> +              * interrupts.
>> >> +              */
>> > I think interrupt masking is needed before reset because we will not handle it anymore.
>> > And Is there any reason to move interrupt clear here compared with previous version?
>>
>> Yeah I moved it to match the description in the document more closely.
>>  The documents mentioned doing the interrupt clear after setting the
>> reset bits, and before waiting for the dma_req bit in the status
>> register to clear.  We've been running it with the interrupt clear
>> below the loop, for a while, and I just tested it with the clear above
>> the wait to make sure it still works properly and I was able to pass
>> the tuning process with some errors, so I believe this works fine too,
>> and more closely matches the description in the doc that I have.
> When I tried ciu_reset, I found some unexpected interrupts occurred.
> It means that interrupt handler will run to handle extra interrupts.
> Then, we may need mask the interrupt.
> Can you check it for test?

You're right.  When I have the controller reset bit set, I see one
interrupt coming in shortly after we write the reset bits, which has
status bits of 0x180.  This has Response timeout (RTO) and Data CRC
error set.  It sounds like some interrupt ocurring may be expected
since they say to clear RINTSTS as part of the procedure though.


>
>>
>> >> +             mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> >> +
>> >> +             /* if using dma we wait for dma_req to clear */
>> >> +             if (host->use_dma) {
>> >> +                     unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> >> +                     u32 status;
>> >> +                     do {
>> >> +                             status = mci_readl(host, STATUS);
>> >> +                             if (!(status & SDMMC_STATUS_DMA_REQ))
>> >> +                                     break;
>> >> +                             cpu_relax();
>> > What did you intend here?
>> > If you intent busy-wait, how about using sleep instead?
>>
>> Yes it is a busy-wait.  There is similar code in dw_mci_ctrl_reset,
>> where that function is polling without sleeps, so I was trying to
>> match that.  The cpu_relax() is something I saw in other busy-waits in
>> the kernel, but I'm happy to take it out if you'd like.
> In case of ctrl_reset, waiting is during 2 clock.
> If this polling status is not long, I'm OK.
>
>>
>> >> +                     } while (time_before(jiffies, timeout));
>> >> +
>> >> +                     if (status & SDMMC_STATUS_DMA_REQ) {
>> >> +                             dev_err(host->dev,
>> >> +                                     "%s: Timeout waiting for dma_req to "
>> >> +                                     "clear during reset", __func__);
>> >> +                             return false;
>> >> +                     }
>> >> +
>> >> +                     /* when using DMA next we reset the fifo again */
>> >> +                     dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
>> >> +             }
>> >> +     } else {
>> >> +             dev_err(host->dev, "%s: Reset bits didn't clear", __func__);
>> > If ciu_reset is cleared, clk update below is needed?
>>
>> I'm honestly not sure what happens if the reset bits don't clear.  The
>> docs say controller_reset and dma_reset will auto clear after a number
>> of clocks, but fifo_reset will clear "after completion of the reset
>> operation"  So in this particular error case I'm not sure if it's
>> possible to recover properly or not and might hang, so I thought it
>> best to just return the error immediately.
> Yes.
> But at least if ciu_reset is done successfully, it may need clock update sequence again.
> In addition, printing reset bit[2:0] will be helpful for debug information.

The dw_mci_ctrl_reset() function would run this code if some of the
bits didn't clear:

        dev_err(host->dev,
                "Timeout resetting block (ctrl reset %#x)\n",
                ctrl & reset);

Does that give you what you're looking for?

>
> Thanks,
> Seungwon Jeon
>
>>
>> > Thanks,
>> > Seungwon Jeon
>> >
>> >> +             return false;
>> >> +     }
>> >> +
>> >> +#ifdef CONFIG_MMC_DW_IDMAC
>> >> +     /* It is also recommended that we reset and reprogram idmac */
>> >> +     dw_mci_idmac_reset(host);
>> >> +#endif
>> >> +
>> >> +     /* After a CTRL reset we need to have CIU set clock registers  */
>> >> +     mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
>> >> +
>> >> +     return true;
>> >>  }
>> >>
>> >>  static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
>> >> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> >> index 6bf24ab..2505804 100644
>> >> --- a/drivers/mmc/host/dw_mmc.h
>> >> +++ b/drivers/mmc/host/dw_mmc.h
>> >> @@ -129,6 +129,7 @@
>> >>  #define SDMMC_CMD_INDX(n)            ((n) & 0x1F)
>> >>  /* Status register defines */
>> >>  #define SDMMC_GET_FCNT(x)            (((x)>>17) & 0x1FFF)
>> >> +#define SDMMC_STATUS_DMA_REQ         BIT(31)
>> >>  /* FIFOTH register defines */
>> >>  #define SDMMC_SET_FIFOTH(m, r, t)    (((m) & 0x7) << 28 | \
>> >>                                        ((r) & 0xFFF) << 16 | \
>> >> --
>> >> 1.9.1.423.g4596e3a
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
