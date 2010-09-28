From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Tue, 28 Sep 2010 20:33:20 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03560991F7@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
 <4C8A2C5D.2050408@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
 <4C971320.7050906@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
 <4C974A5D.5050608@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
 <4C975CFB.6070907@nokia.com> <20100920133703.GC30793@n2100.arm.linux.org.uk>
 <2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
 <20100922124309.GA15699@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52887 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657Ab0I1PDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 11:03:42 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Chris and Adrian,

[..snip..]
> 
> Chris and Adrian,
> 
> [..snip..]
> >
> > > -----Original Message-----
[..snip..]
> > > Subject: Re: [PATCH] mmc: failure of block read wait for long time
> > >
> > > On Wed, Sep 22, 2010 at 11:02:08AM +0530, Ghorai, Sukumar wrote:
> > > > Would you please review and merge this patch [1] (attached too)?
> > > > [1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714
> > >
> > > I've been following the thread.  I believe Adrian has NACKed this
> patch,
> > > by saying "It is absolutely unacceptable to return I/O errors to the
> > > upper layers for segments that do not have errors."
> >
> > [Ghorai]
> > I think Russell also mentioned his opinion. Would you please add your
> idea
> > too?
> >
> > 1. I would prefer Adrian to explain again what this statement means, in
> > the context - data read fail and how we make it success?
> >
> > 2. if data read fail for sector(x) why we have to try for
> > sector(x+1, ..x+n)?
> >
> > 3. how to inform reader function which sector having the valid data out
> of
> > (1...n) sectors.
> >
> > 4. do we have any driver/code in Linux or any other os, which give
> inter-
> > leave data and return as success?
> >
> [Ghorai] please reply with your input on my/ Russell's suggestion?
[Ghorai] any input?
> 
> > >
> > > I think it's possible to merge patches to improve the situation (such
> > > as the idea of noticing a card disappearing earlier), but your initial
> > > patch is not the patch to do that.  You should continue to work with
> > > Adrian -- when he's happy that a patch does not break the semantics
> > > above, we can consider merging it.
> > >
> > > Thanks,
> > >
> > > --
> > > Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> > > One Laptop Per Child
