From: Daniel Mack <daniel@caiaq.de>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Wed, 28 Oct 2009 17:47:52 +0100
Message-ID: <20091028164752.GN29442@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
 <1256156119.8469.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:51353 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbZJ1Qrw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2009 12:47:52 -0400
Content-Disposition: inline
In-Reply-To: <1256156119.8469.40.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, libertas-dev@lists.infradead.org

On Wed, Oct 21, 2009 at 01:15:19PM -0700, Dan Williams wrote:
> On Wed, 2009-10-21 at 21:20 +0200, Daniel Mack wrote:
> > Hi,
> > 
> > we're having trouble getting SDIO connected harware to fly on MX31 based
> > designs. In particular, a SD8686 chip supported by the libertas_sdio
> > driver will hang forever when built without CONFIG_MMC_DEBUG=y. With
> > that option selected, however, the behaviour is a little different, and
> > I can at least see the following messages on a recent 2.6.32-rc5 based
> > MX31 tree.
> > 
> > Is there any common pitfall for such setups? I did more or less the same
> > thing on PXAs (same WLAN chip, same kind of interface, same firmware),
> > and haven't seen any such effects, so I suspect the MXC specific parts
> > to be the reason for that. Any ideas?
> 
> Any idea what quirks your SDHC is using if any?  Does it require PIO or
> can it do DMA?  Does it have any transfer restrictions on block size or
> bit-width?  What is the debug output of the MMC stack when loading the
> module for your SDHC?

I did some more research on this and it turns out that the problem is
related to multi block transfers. At least, this is when it first
occurs.

The libertas SDIO driver downloads two firmwares to the device, one
'helper' and one 'real' firmware The first one only uses chunks of 64
bytes each and that seems to work fine. The real firmware, however,
loads in 512 bytes chunks which the SDIO core breaks up into 16 blocks
of 32 bytes. And this is where the MXC host controller bails out with a
CRC error. Unfortunately, it does not give any more detailed information
about what exactly went wrong.

The effect might be related to an errata entry[1], which is what I'm
currently investigating. To do so, I would like to limit the the
communication to singe-block transfers, just to exclude all other
possible (electrical, clock speed, ...) issues. I did that by setting
mmc->max_blk_count to 1 in the the host controller, but then again,
the libertas driver and/or the firmware doesn't like that and dies in
if_sdio_pro_real() with

  firmware wants 17 bytes
  firmware helper signalled error

Any idea how to get that working with only single block small transfers?

Btw - there's a number of things missing for SDIO in the MXC MMC driver
which I implemented/fixed. I'll send patches as soon as I have more
confidence about the whole setup.


Thanks,
Daniel


[1] Errata IDs TLSbo91748 and TLSbo78667 from
    http://www.freescale.com/files/32bit/doc/errata/MCIMX31CE.pdf?fpsp=1

