From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 4/4] mmc: pxamci: Fix race condition between pxamci_dma_irq() and pxamci_irq()
Date: Wed, 19 Apr 2017 21:22:32 +0200
Message-ID: <87fuh46w3r.fsf@belgarion.home>
References: <cover.1492492523.git.petr.cvek@tul.cz>
        <31e332fa-f152-1eff-39fb-91f332b84757@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:36067 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967353AbdDSTWf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 15:22:35 -0400
In-Reply-To: <31e332fa-f152-1eff-39fb-91f332b84757@tul.cz> (Petr Cvek's
        message of "Wed, 19 Apr 2017 01:18:00 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The data write requests may require an FIFO flush when the DMA transaction
> ends. This is handled by a DMA callback pxamci_dma_irq(). After flushing
> the FIFO the MCI controller generates the DATA_TRAN_DONE interrupt.
>
> Problem is the DATA_TRAN_DONE interrupt will be generated when the write
> data length is divisible by the FIFO size (no flush is required). And in
> this case the DMA callback can be called long time after the
> DATA_TRAN_DONE interrupt (as the DMA callback is realised by a tasklet,
> it can even stack). When the DMA callback is finally called there can
> already be a different type of the transaction (another data read or write
> request).
>
> The dmaengine_tx_status() will be called for a wrong DMA transaction and
> in some case it returns DMA_IN_PROGRESS, which the code recognize as
> an error and ends a running DMA and halts the MCI controller.
>
> The problem presents itself under heavy (interrupt) load with a high MCI
> traffic with this message:
>
> 	mmc0: DMA error on tx channel
>
> The fix must obey these situations:
>  - Any command will erase the FIFO
>  - Data writes divisible by the FIFO size will (probably) automatically
>    generate a DATA_TRAN_DONE interrupt
>  - Data writes with a nonzero FIFO remainder must be flushed and then MCI
>    generates a DATA_TRAN_DONE interrupt
>  - Data reads do not require a flush but they will generate
>    a DATA_TRAN_DONE interrupt
>
> The fix changes the DATA_TRAN_DONE interrupt enable from read/write
> requests to read requests. The DATA_TRAN_DONE interrupt for a write
> request is enabled in the DMA callback, this assures  a DATA_TRAN_DONE
> interrupt will be always called after a callback (with or without an FIFO
> flush).

I'm a bit concerned with the way this patch works.
What bothers me is the re-enabling of the interrupt source in the DMA completion
path, ie. in pxamci_dma_irq().
For example, imagine :
 - the tran_done bit is left set (for whatever reason)
 - a new transation is queued
 - the DMA finishes, but not the last request
 - the pxamci_enable_irq() enables the interrupt, which fires right away even if
   the tran_done for this interrupt wasn't yet set

I will need a bit more time to think this one through, as I'm not yet set about
all the consequences. That shouldn't prevent you from pushing for reviews of
these patches of course, as I think this serie (or an equivalent) is required to
fix the current race condition.

As this is the last patch, I wonder if this serie is bisectable, especially is
patch 1/4 self contained ?

Cheers.

--
Robert
