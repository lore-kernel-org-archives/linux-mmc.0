From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [RFC] ARM: shmobile: g4evm: Use multiple irq vectors for
 SDHI
Date: Fri, 26 Aug 2011 22:06:45 +0900
Message-ID: <20110826130642.GA13205@verge.net.au>
References: <1314353627-23079-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261416330.25272@axis700.grange>
 <20110826123411.GB29479@verge.net.au>
 <Pine.LNX.4.64.1108261448400.25272@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108261448400.25272@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 26, 2011 at 02:56:50PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 26 Aug 2011, Simon Horman wrote:
> 
> > On Fri, Aug 26, 2011 at 02:17:20PM +0200, Guennadi Liakhovetski wrote:
> > > On Fri, 26 Aug 2011, Simon Horman wrote:
> > > 
> > > > This patch is based on "ARM: arch-shmobile: Use multiple irq vectors for SDHI"
> > > > 
> > > > It removes multiplexing of the SDHI vectors and names each IRQ source
> > > > to allow the SDHI driver to used source-specific handlers.
> > > > 
> > > > This is untested as I do not have access to a working g4evm.
> > > > 
> > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > > 
> > > > ---
> > > > 
> > > > Requires "mmc: sdhi: Allow specific IRQ sources to use corresponding handlers."
> > > > 
> > > > *** compile tested only ***
> > > > ---
> > > >  arch/arm/mach-shmobile/board-g4evm.c |   26 ++++++++++++++++++++++-
> > > >  arch/arm/mach-shmobile/intc-sh7377.c |   36 ++++++++++++++++-----------------
> > > 
> > > This second file should not be here, right?
> > 
> > I believe that the g4evm uses the sh7377 and that the multiplexing of
> > SDHIinterrupts for the 7377 need to be removed in order to provide multiple
> > SDHI irq sources.
> > 
> > Am I missing something?
> 
> Maybe not, I just misread your patch description as that it only should 
> touch the board itself. Since intc-sh7377.c has to be touched too, this 
> should be tested, I think. And I don't have any 7377 hardware available. 

I agree that this needs to be tested (or dropped).
And its annoying that neither of us have the hardware at this time.

> Also, would anything break, if we split this into three patches? The first 
> one would only modify g4evm.c with demuxed IRQs but without names. Then 
> the sdhi/tmio driver will install the generic ISR for each of them, and in 
> fact all interrupts would still only come on one IRQ. Then the second 
> patch would modify intc-sh7377.c, after which IRQs will be routed to 
> different vectors. And the third patch would then add names to IRQs. But 
> maybe Paul prefers a single patch for all that.

Personally I think a single patch is the way to go.
Though I have no strong feelings on the issue.

With regards to your question about splitting the patch. Adding the names
as a separate patch should be fine for the reason you describe. However, I
suspect the other split you suggest would not work.

In any case, two patches would reflect the way the changes
have been made on the 7372 (mackerel and ap4evb).

