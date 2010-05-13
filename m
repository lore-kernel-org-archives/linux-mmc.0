From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/9 v3] add DMA support to tmio_mmc, using dmaengine API, use it on SH
Date: Thu, 13 May 2010 15:44:21 +0900
Message-ID: <20100513064421.GA10731@linux-sh.org>
References: <Pine.LNX.4.64.1005071625260.4777@axis700.grange> <Pine.LNX.4.64.1005111156170.6810@axis700.grange> <20100512155529.636a58f6.akpm@linux-foundation.org> <Pine.LNX.4.64.1005130821550.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:43285 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab0EMGpJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2010 02:45:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005130821550.4671@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>

On Thu, May 13, 2010 at 08:42:42AM +0200, Guennadi Liakhovetski wrote:
> On Wed, 12 May 2010, Andrew Morton wrote:
> 
> > On Tue, 11 May 2010 12:07:07 +0200 (CEST)
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > 
> > > 2.6.35 release is approaching and Ian hasn't found time yet to review this 
> > > series, so I was wondering, maybe you could take it into mm at least for 
> > > now?
> > 
> > Well I did, but I don't know how useful that was.
> > 
> > WHo is the most appropriate tree-maintainer to review and possibly
> > merge these?
> 
> Samuel has already acked the MFD patch:
> 
> http://article.gmane.org/gmane.linux.ports.sh.devel/7985
> 
> (please, add this his ack to the patch too). Most of the patches in the 
> series are SuperH- or SH-Mobile specific, which makes Paul (added to CC) 
> the perfect candidate to review them. There is only one tmio-specific 
> patch, and it is also the most complicated one. You or Paul can certainly 
> just follow it to verify, that it doesn't introduce any regressions. I can 
> also confirm it, because I also tested the patched driver without DMA 
> loaded, and it worked just like before in PIO mode. It would, however, be 
> great to test the patches on a non-sdhi hardware, of which none of us, 
> probably, has any. I added Philipp Zabel to CC, who has contributed a few 
> patches to tmio_mmc in the past, perhaps, he still has access to the 
> hardware and could test these patches.
> 
I don't have any problems taking all of the SH and SDHI related bits, but
since they all depend on the tmio_mmc change I haven't picked them up
yet. They'll likely continue to sit in my patch queue until something
happens with the tmio_mmc changes. Given the response times we've had
with any tmio related changes in the past I'm not exactly betting on a
speedy resolution..
