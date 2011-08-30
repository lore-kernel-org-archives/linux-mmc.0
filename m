From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [RFC] ARM: shmobile: g4evm: Use multiple irq vectors for
 SDHI
Date: Tue, 30 Aug 2011 12:45:28 +0900
Message-ID: <20110830034528.GA31103@verge.net.au>
References: <1314353627-23079-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261416330.25272@axis700.grange>
 <20110826123411.GB29479@verge.net.au>
 <Pine.LNX.4.64.1108261448400.25272@axis700.grange>
 <20110826130642.GA13205@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110826130642.GA13205@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 26, 2011 at 10:06:45PM +0900, Simon Horman wrote:
> On Fri, Aug 26, 2011 at 02:56:50PM +0200, Guennadi Liakhovetski wrote:
> > On Fri, 26 Aug 2011, Simon Horman wrote:
> > 
> > > On Fri, Aug 26, 2011 at 02:17:20PM +0200, Guennadi Liakhovetski wrote:
> > > > On Fri, 26 Aug 2011, Simon Horman wrote:
> > > > 
> > > > > This patch is based on "ARM: arch-shmobile: Use multiple irq vectors for SDHI"
> > > > > 
> > > > > It removes multiplexing of the SDHI vectors and names each IRQ source
> > > > > to allow the SDHI driver to used source-specific handlers.
> > > > > 
> > > > > This is untested as I do not have access to a working g4evm.
> > > > > 
> > > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Requires "mmc: sdhi: Allow specific IRQ sources to use corresponding handlers."
> > > > > 
> > > > > *** compile tested only ***
> > > > > ---
> > > > >  arch/arm/mach-shmobile/board-g4evm.c |   26 ++++++++++++++++++++++-
> > > > >  arch/arm/mach-shmobile/intc-sh7377.c |   36 ++++++++++++++++-----------------
> > > > 
> > > > This second file should not be here, right?
> > > 
> > > I believe that the g4evm uses the sh7377 and that the multiplexing of
> > > SDHIinterrupts for the 7377 need to be removed in order to provide multiple
> > > SDHI irq sources.
> > > 
> > > Am I missing something?
> > 
> > Maybe not, I just misread your patch description as that it only should 
> > touch the board itself. Since intc-sh7377.c has to be touched too, this 
> > should be tested, I think. And I don't have any 7377 hardware available. 
> 
> I agree that this needs to be tested (or dropped).
> And its annoying that neither of us have the hardware at this time.

Hi Guennadi,

I spoke with Magnus yesterday and there doesn't seem to be any realistic
chance of accessing hardware to test this patch on in the near future.

So I would like to just leave it sitting in the mailing list archive as
an RFC for now.
