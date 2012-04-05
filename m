From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 5 Apr 2012 15:08:48 -0700
Message-ID: <20120405220848.GF3785@atomide.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
 <m2399iqtgf.fsf@bob.laptop.org>
 <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
 <87bonxcjrh.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57552 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009Ab2DEWIz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Apr 2012 18:08:55 -0400
Content-Disposition: inline
In-Reply-To: <87bonxcjrh.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Walmsley <paul@pwsan.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

* Chris Ball <cjb@laptop.org> [120315 20:26]:
> Hi Paul,
> 
> On Mon, Mar 12 2012, Paul Walmsley wrote:
> > I don't think this is the right fix.  Steve Sakoman and I discussed this a 
> > few months ago -- we did some debugging and Steve observed the timeouts on 
> > multiple block writes (0x19):
> > [...]
> > So perhaps something like the following patch instead?  Unfortunately, I 
> > don't have one of these crappy SD cards as far as I know, so I can't 
> > really test it.
> >
> >
> > - Paul
> >
> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Mon, 12 Mar 2012 04:46:29 -0600
> > Subject: [PATCH] mmc: use really long write timeout to deal with crappy cards
> >
> > Several people have noticed that crappy SD cards take much longer to
> > complete multiple block writes than the 300ms that Linux specifies.
> > Try to work around this by using a three second write timeout instead.
> >
> > <insert Chase's patch description here>
> >
> > Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Sounds like a good idea -- want to send a signed-off patch for this?

This seems like the right fix to me too. Works on my pandaboard es and
some random card that produces I/O errors without this.

Tested-by: Tony Lindgren <tony@atomide.com>
