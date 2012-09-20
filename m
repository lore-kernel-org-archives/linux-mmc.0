From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: shmobile: fix MMCIF IRQ assignment on kzm9g
Date: Thu, 20 Sep 2012 10:54:10 +0900
Message-ID: <20120920015410.GD6873@verge.net.au>
References: <Pine.LNX.4.64.1209190042440.31203@axis700.grange>
 <20120919001403.GF12583@verge.net.au>
 <Pine.LNX.4.64.1209192306370.28849@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1209192306370.28849@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Tetsuyuki Kobayashi <koba@kmckk.co.jp>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 19, 2012 at 11:08:52PM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 19 Sep 2012, Simon Horman wrote:
> 
> > On Wed, Sep 19, 2012 at 12:52:26AM +0200, Guennadi Liakhovetski wrote:
> > > Error and operation IRQs are swapped in kzm9g platform data, this patch
> > > fixes their order. The only problem this bug causes is the confusing IRQ 
> > > count in /proc/interrupts output, otherwise functionality is unaffected, 
> > > since the driver doesn't really differentiate between the two IRQs.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Thanks Guennadi,
> > 
> > as it happens I merged a very similar (same?) patch into the
> > fixes branch of my renesas tree yesterday. It has been accepted
> > by the arm-soc people and should appear in 3.6.
> 
> Good, just wondering what about ag5evm, it does seem to have the same 
> problem. As mentioned before, this is just a "cosmetic" fix, so, up to you 
> to decide when and how and if you'd like to fix it.

Good point.

Could you prepare a patch just for ag5evm for me to queue up?
