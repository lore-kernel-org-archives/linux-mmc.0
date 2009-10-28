From: Daniel Mack <daniel@caiaq.de>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Wed, 28 Oct 2009 18:19:25 +0100
Message-ID: <20091028171925.GL14091@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
 <1256156119.8469.40.camel@localhost.localdomain>
 <20091028164752.GN29442@buzzloop.caiaq.de>
 <1256749562.3850.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:36508 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbZJ1RTZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2009 13:19:25 -0400
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
> > 
> > Any idea how to get that working with only single block small transfers?
> 
> All the Marvell documentation (v5 at least) refers to 512-byte transfers
> of the second-stage firmware in 32-byte blocks:
> 
> Section 2.2.1.1 of the v5 spec states:
> 
> "
> 2) If the length requested by helper is larger than 512 bytes, it is cut
> into multiple pieces for CMD53 write. The current download length is set
> to 512 bytes (16 blocks x 32 bytes per block) in each iteration of CMD53
> write.
> 3) Host starts the download of 16 blocks of firmware (512 bytes)
> 4) Host copies the payload to the buffer.
> 5) Host writes 16 blocks of the firmware image data using CMD 53.
> 6) Repeat Steps 3 through 5 until the firmware image data specified by
> the helper (Step 2) for this iteration is downloaded completely.
> "
> 
> The helper firmware may well expect all 16 blocks.  But try adjusting
> "chunk_size" in if_sdio.c::if_sdio_prog_real() down to one block (ie, 32
> not 512) and see if the helper pukes.  The code looks like it can handle
> chunk_size changes just fine.

The code can, yes. But it seems the helper can't. I think I tried this
earlier. Here's the output:

[    5.620000] libertas_sdio mmc0:0001:1: firmware: requesting sd8686_helper.bin
[    5.700000] libertas sdio: waiting for helper to boot...
[    5.710000] libertas_sdio mmc0:0001:1: firmware: requesting sd8686.bin
[    5.770000] libertas sdio: firmware wants 16 bytes
[    5.780000] libertas sdio: sending 16 bytes (32 bytes) chunk
[    5.790000] libertas sdio: firmware wants 512 bytes
[    5.790000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.800000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.810000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.810000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.820000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.830000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.830000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.840000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.840000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.850000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.860000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.860000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.870000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.880000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.880000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.890000] libertas sdio: sending 32 bytes (32 bytes) chunk
[    5.900000] libertas sdio: firmware wants 17 bytes
[    5.900000] libertas sdio: firmware helper signalled error
[    5.910000] libertas: failed to load firmware
[    5.910000] libertas_sdio: probe of mmc0:0001:1 failed with error -5

Maybe I need to tweak the core to send 512 bytes in one block instead of
multiple ones?

Just to exclude other issues - seeing the driver coming that far tells
that electrical issues can't be the reason, right? Or is there anything
else that changes after the helper is downloaded successfully? Does the
hardware change anything on the hardware link layer at this point?

Daniel

