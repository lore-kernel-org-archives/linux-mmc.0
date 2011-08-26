From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [RFC] ARM: shmobile: g4evm: Use multiple irq vectors for
 SDHI
Date: Fri, 26 Aug 2011 21:34:12 +0900
Message-ID: <20110826123411.GB29479@verge.net.au>
References: <1314353627-23079-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261416330.25272@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108261416330.25272@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 26, 2011 at 02:17:20PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 26 Aug 2011, Simon Horman wrote:
> 
> > This patch is based on "ARM: arch-shmobile: Use multiple irq vectors for SDHI"
> > 
> > It removes multiplexing of the SDHI vectors and names each IRQ source
> > to allow the SDHI driver to used source-specific handlers.
> > 
> > This is untested as I do not have access to a working g4evm.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > ---
> > 
> > Requires "mmc: sdhi: Allow specific IRQ sources to use corresponding handlers."
> > 
> > *** compile tested only ***
> > ---
> >  arch/arm/mach-shmobile/board-g4evm.c |   26 ++++++++++++++++++++++-
> >  arch/arm/mach-shmobile/intc-sh7377.c |   36 ++++++++++++++++-----------------
> 
> This second file should not be here, right?

I believe that the g4evm uses the sh7377 and that the multiplexing of
SDHIinterrupts for the 7377 need to be removed in order to provide multiple
SDHI irq sources.

Am I missing something?

