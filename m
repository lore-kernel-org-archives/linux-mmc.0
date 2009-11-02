From: Dan Williams <dcbw@redhat.com>
Subject: Re: MXC MMC driver and SDIO peripherals
Date: Mon, 02 Nov 2009 12:00:32 -0800
Message-ID: <1257192032.1027.19.camel@localhost.localdomain>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
	<1256156119.8469.40.camel@localhost.localdomain>
	<20091028164752.GN29442@buzzloop.caiaq.de>
	<1256749562.3850.41.camel@localhost.localdomain>
	<20091029102751.GO14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091029102751.GO14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, libertas-dev@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 2009-10-29 at 11:27 +0100, Daniel Mack wrote:
> On Wed, Oct 28, 2009 at 10:06:02AM -0700, Dan Williams wrote:
> > On Wed, 2009-10-28 at 17:47 +0100, Daniel Mack wrote:
> > > I did some more research on this and it turns out that the problem is
> > > related to multi block transfers. At least, this is when it first
> > > occurs.
> > > 
> > > The libertas SDIO driver downloads two firmwares to the device, one
> > > 'helper' and one 'real' firmware The first one only uses chunks of 64
> > > bytes each and that seems to work fine. The real firmware, however,
> > > loads in 512 bytes chunks which the SDIO core breaks up into 16 blocks
> > > of 32 bytes. And this is where the MXC host controller bails out with a
> > > CRC error. Unfortunately, it does not give any more detailed information
> > > about what exactly went wrong.
> > > 
> > > The effect might be related to an errata entry[1], which is what I'm
> > > currently investigating. To do so, I would like to limit the the
> > > communication to singe-block transfers, just to exclude all other
> > > possible (electrical, clock speed, ...) issues. I did that by setting
> > > mmc->max_blk_count to 1 in the the host controller, but then again,
> > > the libertas driver and/or the firmware doesn't like that and dies in
> > > if_sdio_pro_real() with
> > > 
> > >   firmware wants 17 bytes
> > >   firmware helper signalled error
> 
> A number of bytes requested has bit 1 set indicates an error, according
> to the code if_sdio_prog_real(). Is there any more information in such
> cases? An error code that tells us about the real reason maybe?

Not that I know of; the helper is pretty simple.  The v9 SD8686 vendor
driver assumes that any helper error is a CRC error, and retries that
block a few times before failing.  But the helper asking for 17 bytes
seems a bit suspicious.  Are you sure there aren't any TX/RX issues with
your SDHC and the connections to the card?

> > All the Marvell documentation (v5 at least) refers to 512-byte transfers
> > of the second-stage firmware in 32-byte blocks:
> > 
> > Section 2.2.1.1 of the v5 spec states:
> 
> What documentation is that? Is it publically available?

http://wiki.laptop.org/images/f/f3/Firmware-Spec-v5.1-MV-S103752-00.pdf

Dan
