From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH 4/4] mmc: pxamci: Fix race condition between
 pxamci_dma_irq() and pxamci_irq()
Date: Fri, 21 Apr 2017 03:30:10 +0200
Message-ID: <43c3a3b4-75b5-613e-4e28-9c38271ccb63@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
 <31e332fa-f152-1eff-39fb-91f332b84757@tul.cz> <87fuh46w3r.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:35508 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034258AbdDUB3i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 21:29:38 -0400
In-Reply-To: <87fuh46w3r.fsf@belgarion.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 19.4.2017 v 21:22 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> The data write requests may require an FIFO flush when the DMA transaction
>> ends. This is handled by a DMA callback pxamci_dma_irq(). After flushing
>> the FIFO the MCI controller generates the DATA_TRAN_DONE interrupt.
>>
>> Problem is the DATA_TRAN_DONE interrupt will be generated when the write
>> data length is divisible by the FIFO size (no flush is required). And in
>> this case the DMA callback can be called long time after the
>> DATA_TRAN_DONE interrupt (as the DMA callback is realised by a tasklet,
>> it can even stack). When the DMA callback is finally called there can
>> already be a different type of the transaction (another data read or write
>> request).
>>
>> The dmaengine_tx_status() will be called for a wrong DMA transaction and
>> in some case it returns DMA_IN_PROGRESS, which the code recognize as
>> an error and ends a running DMA and halts the MCI controller.
>>
>> The problem presents itself under heavy (interrupt) load with a high MCI
>> traffic with this message:
>>
>> 	mmc0: DMA error on tx channel
>>
>> The fix must obey these situations:
>>  - Any command will erase the FIFO
>>  - Data writes divisible by the FIFO size will (probably) automatically
>>    generate a DATA_TRAN_DONE interrupt
>>  - Data writes with a nonzero FIFO remainder must be flushed and then MCI
>>    generates a DATA_TRAN_DONE interrupt
>>  - Data reads do not require a flush but they will generate
>>    a DATA_TRAN_DONE interrupt
>>
>> The fix changes the DATA_TRAN_DONE interrupt enable from read/write
>> requests to read requests. The DATA_TRAN_DONE interrupt for a write
>> request is enabled in the DMA callback, this assures  a DATA_TRAN_DONE
>> interrupt will be always called after a callback (with or without an FIFO
>> flush).
> 
> I'm a bit concerned with the way this patch works.
> What bothers me is the re-enabling of the interrupt source in the DMA completion
> path, ie. in pxamci_dma_irq().
> For example, imagine :
>  - the tran_done bit is left set (for whatever reason)

You mean DATA_TRAN_DONE flag? The datasheet (page for reg MMC_STAT) says it is cleared at the start of the every command sequence. So inside pxamci_data_done() it can stay only activated in the case of an error (after dropping the third patch of this patchset "Disable DATA_TRAN_DONE interrupt sooner") or in the case of no STOP command.

>  - a new transation is queued

In the case of pxa27x the TX DMA (the one with a callback and patched behavior) will start only after the end of the command sequence. But I see, there could be a problem outside the PXA27x SoC (PXA3xx?) as in that case the DMA is started (dma_async_issue_pending()) before the command sequence.

>  - the DMA finishes, but not the last request

That would be a problem on itself because the MCI flushes the FIFO at the every command. Anyway if the DATA_TRAN_DONE flag was left as "1" from the previous transaction. It should cause an interrupt in the original driver version before applying my patch too. If I'm right (and it is possible I'm not) your situation is independent to my patch.

>  - the pxamci_enable_irq() enables the interrupt, which fires right away even if
>    the tran_done for this interrupt wasn't yet set
> 

Maybe we can add some sanity checks in the pxamci_finish_request() or at the start of pxamci_request().

> I will need a bit more time to think this one through, as I'm not yet set about
> all the consequences. That shouldn't prevent you from pushing for reviews of
> these patches of course, as I think this serie (or an equivalent) is required to
> fix the current race condition.

Well during the bug hunting and reading the documentation I was wondering if a hardware could be designed to be incompatible with the kernel subsystems ;-).

> 
> As this is the last patch, I wonder if this serie is bisectable, especially is
> patch 1/4 self contained ?

Applying only the patch 1/4 itself should not change the behavior at all if the mmc core sends only "01" and "10" in these bit fields. The exact way I've found it was that I traced the callback and found it assigns:

	chan = host->dma_chan_rx;

even though it is called only for the TX. I have checked the flags definitions and found they are not a single bit and changed it to more descriptive if(){} (why negate the read if there is write AND they are not mutually exclusive AND callback is for write).

The patches 1, 1+2, 1+2+3 should boot, but the MMC will of course fail as only the 4 repairs it. Do you want me to send them independently? (or I can sort them that the race condition repair is the first one)

> 
> Cheers.
> 
> --
> Robert
> 

