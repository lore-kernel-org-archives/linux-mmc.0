From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Date: Wed, 20 Jun 2012 16:02:27 +0900
Message-ID: <20120620070227.GN20030@verge.net.au>
References: <1340171905-12534-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 20, 2012 at 08:49:38AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> Thanks for addressing this issue.
> 
> On Wed, 20 Jun 2012, Simon Horman wrote:
> 
> > In 930f152cc9998388031af577843baae572ac8ab6 ("mmc: sh_mmcif: mmc->f_max
> > should be half of the bus clock") I changed the setting of mmc->f_max from
> > the bus clock to half the bus clock based on the manual for the sh7372 SoC.
> > 
> > Inspection of sh_mmcif_clock_control() reveals that it relies on
> > mmc->f_max being set to the bus speed in order to enable the supplementary
> > clock, a feature that does not exist on the sh7372.
> > 
> > Armed with this information implement the following heuristic for setting
> > mmc->f_max:
> > 
> > * Use bus clock if the supplementary clock feature is present
> >   - Assumed to work on the sh7757lcr board, the only board present
> >     in the tree which has the feature.
> 
> To be able to better understand this change: do we have access to the 
> sh7757 documentation and does it actually explain how the CLK_SUP_PCLK bit 
> in MMCIF_CE_CLK_CTRL functions? Does it actually set the MMC bus clock to 
> be equal to the host clock?

My understanding is that neither Magnus nor I have access to the
documentation for the sh7757. Thus we could only infer things from
examining the source code. I would be very happy if someone with access to
the documentation could shed some further light on this. In particular,
I would be happy if this heuristic was shown not to be necessary. But
in lieu of access to the documentation I think this patch is reasonable.

