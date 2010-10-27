From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 15:50:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010271537130.29484@xanadu.home>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
 <20101027153218.04462a45@lxorguk.ukuu.org.uk>
 <9E9D055931034061A2DB5FFF97887F42@am.dhcp.ti.com>
 <20101027165327.3dfb7696@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188Ab0J0Tuq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 15:50:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAY001RZSGFLP60@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 27 Oct 2010 15:50:39 -0400 (EDT)
In-reply-to: <20101027165327.3dfb7696@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Madhusudhan <madhu.cr@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, 'Chris Ball' <cjb@laptop.org>, 'Linus Walleij' <linus.ml.walleij@gmail.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, "'Kadiyala, Kishore'" <kishore.kadiyala@ti.com>, "'S, Venkatraman'" <svenkatr@ti.com>

On Wed, 27 Oct 2010, Alan Cox wrote:

> > > > 2. Ideally host-driver driver should not tell the core to shut down
> > > >    the upper layers, instead the core should decide when to
> > > >    "disabled clock or cut the power".
> > > 
> > > How will the core know ?
> > > 
> > 
> > Are you saying that MMC core needs to be adapted first to RUNTIME PM?
> 
> I think the runtime pm layer actually does help solve the problem -
> because it allows both the driver and the core to defer power off.
> 
> To me the fundamental problem is that the MMC/SDHCI core thinks it is
> all knowing, when in reality silicon designers are far too good at
> producing weird, whacky, broken and otherwise bizarre implementations.

There are 2 levels of knowledge here:

1) The host controller doesn't know and must not try to know what the 
upper layer is doing with the card.  This means that the host controller 
layer must not decide on its own to turn off the clock and/or cut power 
_to_ the card.  Emphasis again: the host controller must not policy what 
happens to the card.  Card issues and quirks are common to all 
controllers and best dealt with in the core.  Duplicating that knowledge 
in all controller drivers is silly.

2) Host controller driver may optimize power usage further according to 
its own characteristics with actions that are transparent to both the 
core code and the card.  For example, it is a damn good idea to shut 
down power to the _controller_ if power is also cut to the _card_.  Or, 
the clock to the controller block may be gated while still keeping the 
clock to the card active when no activity has happened after a certain 
delay and that is compatible with the fact that card clock is still 
active, etc.  I think tat the OMAP controller hardware is highly 
flexible and configurable in that regard.

> Eventually it will all break because a design comes along which is
> common, and sufficiently different.

There are still things that are clearly belonging to different 
abstraction layers.  And at the moment the OMAP controller driver is 
abusing those layers.

> (PS: this should be discussed on the list not via some random collection
> of email addresses)

Indeed.


Nicolas
