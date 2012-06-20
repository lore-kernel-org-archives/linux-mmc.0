From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/5 v4] mmc: sh_mmcif: remove redundant .down_pwr()
 callback
Date: Wed, 20 Jun 2012 15:57:02 +0900
Message-ID: <20120620065702.GK20030@verge.net.au>
References: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
 <Pine.LNX.4.64.1206131534250.17854@axis700.grange>
 <20120620045808.GC20030@verge.net.au>
 <Pine.LNX.4.64.1206200818110.20254@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206200818110.20254@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 20, 2012 at 08:19:26AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 20 Jun 2012, Simon Horman wrote:
> 
> > On Wed, Jun 13, 2012 at 03:37:27PM +0200, Guennadi Liakhovetski wrote:
> > > >From the original version of sh_mmcif the .set_pwr() callback has only been
> > > used to turn the card's power on, and the .down_pwr() callback has been
> > > used to turn it off. .set_pwr() can be used for both these tasks, which is
> > > also how it is implemented by the only user of this API: the SH7724 ecovec
> > > board.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Reviewed-by: Simon Horman <horms@verge.net.au>
> > 
> > Do you also intend to post patches for the following?
> > 
> > * Remove mmcif_down_pwr from ecovec
> > * Remove down_pwr from struct sh_mmcif_plat_data
> 
> Sure, since these patches depend on each other we have to make sure this 
> one gets applied first. The other two then can be applied in their time, 
> they do not affect the functionality any more.

Thanks, I agree entirely.
