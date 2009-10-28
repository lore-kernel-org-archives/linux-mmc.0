From: Dan Williams <dcbw@redhat.com>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Wed, 28 Oct 2009 10:11:04 -0700
Message-ID: <1256749864.3850.44.camel@localhost.localdomain>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
	 <1256156119.8469.40.camel@localhost.localdomain>
	 <20091028164752.GN29442@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbZJ1RL1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2009 13:11:27 -0400
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

Just a note; single-block transfers will probably kill your wifi
performance, especially if the errata are true.  When the libertas
driver sends network data packets it sends them with

		ret = sdio_writesb(card->func, card->ioport,
				packet->buffer, packet->nb);

so if your packet is normal ethernet 1500 bytes, breaking that up in to
47 single block transfers of 32-bytes each is going to be slow...

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

