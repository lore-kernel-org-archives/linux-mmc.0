From: Daniel Mack <daniel@caiaq.de>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Thu, 29 Oct 2009 11:27:51 +0100
Message-ID: <20091029102751.GO14091@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
 <1256156119.8469.40.camel@localhost.localdomain>
 <20091028164752.GN29442@buzzloop.caiaq.de>
 <1256749562.3850.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:44696 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZJ2K1x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2009 06:27:53 -0400
Content-Disposition: inline
In-Reply-To: <1256749562.3850.41.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, libertas-dev@lists.infradead.org

On Wed, Oct 28, 2009 at 10:06:02AM -0700, Dan Williams wrote:
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

A number of bytes requested has bit 1 set indicates an error, according
to the code if_sdio_prog_real(). Is there any more information in such
cases? An error code that tells us about the real reason maybe?

> All the Marvell documentation (v5 at least) refers to 512-byte transfers
> of the second-stage firmware in 32-byte blocks:
> 
> Section 2.2.1.1 of the v5 spec states:

What documentation is that? Is it publically available?

Thanks,
Daniel

