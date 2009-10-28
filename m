From: Dan Williams <dcbw@redhat.com>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Wed, 28 Oct 2009 10:06:02 -0700
Message-ID: <1256749562.3850.41.camel@localhost.localdomain>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
	 <1256156119.8469.40.camel@localhost.localdomain>
	 <20091028164752.GN29442@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbZJ1RGq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2009 13:06:46 -0400
In-Reply-To: <20091028164752.GN29442@buzzloop.caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, libertas-dev@lists.infradead.org

On Wed, 2009-10-28 at 17:47 +0100, Daniel Mack wrote:
> On Wed, Oct 21, 2009 at 01:15:19PM -0700, Dan Williams wrote:
> > On Wed, 2009-10-21 at 21:20 +0200, Daniel Mack wrote:
> > > Hi,
> > > 
> > > we're having trouble getting SDIO connected harware to fly on MX31 based
> > > designs. In particular, a SD8686 chip supported by the libertas_sdio
> > > driver will hang forever when built without CONFIG_MMC_DEBUG=y. With
> > > that option selected, however, the behaviour is a little different, and
> > > I can at least see the following messages on a recent 2.6.32-rc5 based
> > > MX31 tree.
> > > 
> > > Is there any common pitfall for such setups? I did more or less the same
> > > thing on PXAs (same WLAN chip, same kind of interface, same firmware),
> > > and haven't seen any such effects, so I suspect the MXC specific parts
> > > to be the reason for that. Any ideas?
> > 
> > Any idea what quirks your SDHC is using if any?  Does it require PIO or
> > can it do DMA?  Does it have any transfer restrictions on block size or
> > bit-width?  What is the debug output of the MMC stack when loading the
> > module for your SDHC?
> 
> I did some more research on this and it turns out that the problem is
> related to multi block transfers. At least, this is when it first
> occurs.
> 
> The libertas SDIO driver downloads two firmwares to the device, one
> 'helper' and one 'real' firmware The first one only uses chunks of 64
> bytes each and that seems to work fine. The real firmware, however,
> loads in 512 bytes chunks which the SDIO core breaks up into 16 blocks
> of 32 bytes. And this is where the MXC host controller bails out with a
> CRC error. Unfortunately, it does not give any more detailed information
> about what exactly went wrong.
> 
> The effect might be related to an errata entry[1], which is what I'm
> currently investigating. To do so, I would like to limit the the
> communication to singe-block transfers, just to exclude all other
> possible (electrical, clock speed, ...) issues. I did that by setting
> mmc->max_blk_count to 1 in the the host controller, but then again,
> the libertas driver and/or the firmware doesn't like that and dies in
> if_sdio_pro_real() with
> 
>   firmware wants 17 bytes
>   firmware helper signalled error
> 
> Any idea how to get that working with only single block small transfers?

All the Marvell documentation (v5 at least) refers to 512-byte transfers
of the second-stage firmware in 32-byte blocks:

Section 2.2.1.1 of the v5 spec states:

"
2) If the length requested by helper is larger than 512 bytes, it is cut
into multiple pieces for CMD53 write. The current download length is set
to 512 bytes (16 blocks x 32 bytes per block) in each iteration of CMD53
write.
3) Host starts the download of 16 blocks of firmware (512 bytes)
4) Host copies the payload to the buffer.
5) Host writes 16 blocks of the firmware image data using CMD 53.
6) Repeat Steps 3 through 5 until the firmware image data specified by
the helper (Step 2) for this iteration is downloaded completely.
"

The helper firmware may well expect all 16 blocks.  But try adjusting
"chunk_size" in if_sdio.c::if_sdio_prog_real() down to one block (ie, 32
not 512) and see if the helper pukes.  The code looks like it can handle
chunk_size changes just fine.

If it does, and we after we further test that with other v8 and v9
firmware, then maybe we can print out a big fat warning about SDHC
suckage before trying a single-block fallback.

Dan

> Btw - there's a number of things missing for SDIO in the MXC MMC driver
> which I implemented/fixed. I'll send patches as soon as I have more
> confidence about the whole setup.
> 
> 
> Thanks,
> Daniel
> 
> 
> [1] Errata IDs TLSbo91748 and TLSbo78667 from
>     http://www.freescale.com/files/32bit/doc/errata/MCIMX31CE.pdf?fpsp=1
> 
> 
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev

