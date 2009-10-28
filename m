From: Daniel Mack <daniel@caiaq.de>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Wed, 28 Oct 2009 18:21:47 +0100
Message-ID: <20091028172147.GM14091@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
 <1256156119.8469.40.camel@localhost.localdomain>
 <20091028164752.GN29442@buzzloop.caiaq.de>
 <1256749864.3850.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:36524 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZJ1RVq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2009 13:21:46 -0400
Content-Disposition: inline
In-Reply-To: <1256749864.3850.44.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, libertas-dev@lists.infradead.org

On Wed, Oct 28, 2009 at 10:11:04AM -0700, Dan Williams wrote:
> On Wed, 2009-10-28 at 17:47 +0100, Daniel Mack wrote:
> > I did some more research on this and it turns out that the problem is
> > related to multi block transfers. At least, this is when it first
> > occurs.
> > 
> > The libertas SDIO driver downloads two firmwares to the device, one
> > 'helper' and one 'real' firmware The first one only uses chunks of 64
> > bytes each and that seems to work fine. The real firmware, however,
> > loads in 512 bytes chunks which the SDIO core breaks up into 16 blocks
> > of 32 bytes. And this is where the MXC host controller bails out with a
> > CRC error. Unfortunately, it does not give any more detailed information
> > about what exactly went wrong.
> > 
> > The effect might be related to an errata entry[1], which is what I'm
> > currently investigating. To do so, I would like to limit the the
> > communication to singe-block transfers, just to exclude all other
> > possible (electrical, clock speed, ...) issues. I did that by setting
> > mmc->max_blk_count to 1 in the the host controller, but then again,
> > the libertas driver and/or the firmware doesn't like that and dies in
> > if_sdio_pro_real() with
> > 
> >   firmware wants 17 bytes
> >   firmware helper signalled error
> > 
> > Any idea how to get that working with only single block small transfers?
> 
> Just a note; single-block transfers will probably kill your wifi
> performance, especially if the errata are true.  When the libertas
> driver sends network data packets it sends them with
> 
> 		ret = sdio_writesb(card->func, card->ioport,
> 				packet->buffer, packet->nb);
> 
> so if your packet is normal ethernet 1500 bytes, breaking that up in to
> 47 single block transfers of 32-bytes each is going to be slow...

Yep, I know. Thats's a disaster, especially without DMA enabled (which
is currently the case).

But I'd like to see it working somehow first and then see whether that's
really the issue :)

Daniel

