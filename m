From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 00/24] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 11:39:56 +0000
Message-ID: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39651 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbLULkG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:40:06 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

This all started with a report from an iMX6 Hummingboard user that
they were seeing regular "mmc0: Got data interrupt 0x00000002 even
though no data operation was in progress." messages with 4.4-rc and
additional patches to enable UHS support in DT for the platform.

When I tested 4.4-rc on an iMX6 Hummingboard with UHS support enabled,
I found several other issues.  This patch series addresses some of
the issues.

However, while testing on Armada 388, an issue was found there, and
a fix is also included in this patch set, however it does not depend
on the rest of the patch series.

We all know that the SDHCI driver is in poor state, and Ulf's desire
to see it turned into a library (which actually comes from myself.)
However, with the driver in such a poor state, it makes sense to fix
a few of the issues first, especially if they result in the code
shrinking - which they do.

However, given what I've found below, I have to wonder how many of the
quirks that we have in this driver are down to the poor code rather than
real hardware problems: how many of them are due to poorly investigated
bugs.

This series starts off by shutting up some kernel messages that should
not be verbose:
- the voltage-ranges DT property is optional, so we should not print
  a message saying that it's missing from DT.  That suggests it isn't
  optional.  As no ill effect comes from not specifying it, I've
  dropped this message to debug level.

- reworking the voltage-ranges code so that callers know whether the
  optional voltage-ranges property was specified.

- "retrying because a re-tune was needed" - a re-tune is something that
  is part of the higher speed SD specs, and it's required to happen
  periodically.  So it's expected and normal behaviour.  There's no need
  to print this to the kernel log.

- When tuning fails, rather than a bland "mmc0: tuning execution failed"
  message, print the error code so that we can see what the reason for
  the failure is.  MMC fails on this point in many places.

- Move the initialisation of the command ->error member.  It looks to
  me as if this is not required; mmc_start_request() does this already,
  as it seems the rest of the MMC core does too.  Maybe this should be
  removed altogether?

- Testing error bits, then setting the error, then testing the error
  value, and completing the command is a very lengthy way to deal with
  errors here.  Test the error bits, and then decide what error occurred
  before completing.  (This code is actually buggy, see the next change).

- If a command _response_ CRC error occurs, we can't be certain whether
  the card received the command successfully, and has started processing
  it.  If it has, and it results in data being read from the card, the
  card will enter data transfer state, and start sending data to the
  host.  Therefore, it is completely wrong to blindly terminate the
  command, especially when such termination fails to clean _anything_
  up - eg, it leaves DMA in place so the host can continue DMAing to the
  memory, and it leaves buffers DMA mapped - which eventually annoys the
  DMA API debugging.  Fix this by assuming that a CRC error is a receive
  side error.  If the card did not correctly receive the command, it
  will not initiate a data transfer, and we should time out after the
  card specified timeout.

  With the unmodified mainline code, even if we reset the state machines
  when finishing a request in error, the _card_ itself may well still be
  in data transfer mode when this happens.  How can we be sure what state
  the data side is actually in?  Could this be why (eg) sdhci-esdhc-imx.c
  has this:

        /* FIXME: delay a bit for card to be ready for next tuning due to errors */
        mdelay(1);

  And how many more such _hacks_ are working around similar problems?

- The unaligned buffer handling is a total waste of resources in its
  current form.  We DMA map, sync, and unmap it on every transfer,
  whether the buffer is used or not.  For MMC/SD transfers, these will
  be coming from the VFS/MM layers, which operate through the page
  cache - hence the vast majority of buffers will be page aligned.
  Performance measurements on iMX6 show that this additional DMA
  maintanence is responsible for a 10% reduction in read transfer
  performance.  Switch this to use a DMA coherent mapping instead, which
  needs no DMA maintanence.

- sdhci_adma_table_post() is badly coded: we walk the scatterlist
  looking for any buffers which might not be aligned (which can be a
  rare event, see above) and then we only do something if we find an
  unaligned buffer _and_ it's a read transfer.  So for a write transfer,
  this scatterlist walking is a total waste of CPU cycles.  Testing the
  transfer direction is much cheaper than walking the scatterlist.
  Re-organise the code to do the cheap test first.

- There are two paths to identical DMA unmapping code (the code around
  dma_unmap_sg()) in sdhci_finish_data() and its child function
  sdhci_adma_table_post().  Trivially simplify this duplication.

- Move sdhci_pre_dma_transfer() so we avoid needing to declare it.

- Do the same thing with sdhci_prepare_data() and sdhci_pre_dma_transfer()
  as with sdhci_finish_data() and sdhci_adma_table_post().

- Fix the mess that is the data segment host_cookie handling.  The
  existing code seems like a candidate for the obfuscated coding prize!
  Four patches address this, turning it into something much easier to
  understand, which then allows (finally)...

- The DMA API leak which occurs when we have mapped the DMA buffers in
  sdhci_prepare_data() and an error occurs early on in the processing
  of a request.

- A change (mentioned above) which fixes a prior commit for Armada 38x
  using sdhci-pxav3.c, found while trying to get the higher speed modes
  working on these SoCs.  Clearly the existing code is broken, this at
  least resolves some of the breakage by allowing the correct high-order
  SDHCI capabilities through.

- Fixing another DMA API leak with the pre/post request handling, where
  a current request can change the state of the SDHCI_REQ_USE_DMA, and
  thus stop a mapped request being unmapped.

- Fixing the SDHCI timeout calculation code to correctly round timeouts
  up rather than down, and correctly calculate the time (in microseconds)
  for a certain number of card clocks.

- Consolidating the SDHCI address/size alignment handling so we only walk
  the scatterlist once instead of twice.

Further patches are necessary as there are still a number of observable
problems when using this driver on iMX6 with UHS cards.  Patches up to
and including "mmc: sdhci: further fix for DMA unmapping in
sdhci_post_req()" should be considered for inclusion in the stable
kernel trees.

I've tested these changes on iMX6 at UHS speeds, and Armada 388 SoCs
at HS speeds so far.  Others should test them.

 drivers/mmc/card/block.c       |   4 +-
 drivers/mmc/core/core.c        |  17 +-
 drivers/mmc/host/sdhci-pxav3.c |   6 +-
 drivers/mmc/host/sdhci.c       | 417 +++++++++++++++++++----------------------
 drivers/mmc/host/sdhci.h       |   4 +-
 5 files changed, 208 insertions(+), 240 deletions(-)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
