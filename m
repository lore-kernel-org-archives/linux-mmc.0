From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH 0/4] mmc: pxamci: better error handling + fix a race condition
Date: Wed, 19 Apr 2017 01:16:00 +0200
Message-ID: <12f3d97d-4e32-9144-3d71-cbc0a4bfb2c5@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:32904 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbdDRXPf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 19:15:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This patchset deals with a very rare race condition [1] in the PXA MCI
driver which was introduced by using the DMA callback tasklet after
converting the driver for the usage of the kernel DMA engine. The consequent
(and not strictly relevant) changes in the driver v4.7-v4.10 caused the bug
to manifest, but only under a heavy load.

The PXA27x SoC is a little bit weird because when a DMA fills the write FIFO
you must manually flush it. This is done in the callback of the DMA. After
the flush a MCI interrupt is generated and the code continues.

The problem is the read FIFO and the writes of the data sizes divisible by 32
the MCI interrupt is generated immediately after end of the DMA. The driver
trusted the DMA callback to spinlock the IRQ before MCI interrupt handler is
called but it is not a valid solution as the DMA callback is using a tasklet
which can be delayed for a very long time (during testing there was a few
cases of a multiple tasklet scheduling before finally the tasklet started).

The patchset makes the MCI interrupt dependent on the callback in a way that
the interrupt is enabled only in the callback. The read path interrupt enable
stays at the same place (before starting the DMA), it has been only restricted
for the data read path.

The patchset clarifies the code a little and adds a few error reports.

The fix should not make the operation slower as the only slowdown may be
in the case of write && weird length of data && heavy load (when the tasklet
is delayed anyway).

The patchset has been tested on the HTC Magician (PXA27x). I suggest a test
on a different SoC (driver seems to be compatible with PXA300+). Any
incompatibility can be probably fixed by something like cpu_is_pxa300().

References:

[1] "[BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA error
    on tx channel"
    https://www.spinics.net/lists/linux-mmc/msg42899.html

Thanks,

Petr Cvek (4):
  mmc: pxamci: Use the right flags for DMA callback init
  mmc: pxamci: Enhance error checking
  mmc: pxamci: Disable DATA_TRAN_DONE interrupt sooner
  mmc: pxamci: Fix race condition between pxamci_dma_irq() and
    pxamci_irq()

 drivers/mmc/host/pxamci.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.11.0

