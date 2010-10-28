From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 12:13:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010281206480.2647@xanadu.home>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
 <alpine.LFD.2.00.1010271551500.29484@xanadu.home>
 <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
 <AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
 <AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:36762 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0J1QNl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 12:13:41 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LB000DK4D2LRXC0@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 28 Oct 2010 12:13:34 -0400 (EDT)
In-reply-to: <AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Thu, 28 Oct 2010, Ohad Ben-Cohen wrote:

> On Thu, Oct 28, 2010 at 5:39 PM, Kishore Kadiyala
> <kishorek.kadiyala@gmail.com> wrote:
> > Wouldn't adapting the host driver just to PM-Runtime will answer the
> > above issues?
> 
> It's not enough.
> 
> When the card is runtime suspended, sure, the host controller will
> immediately get idle notification by runtime PM core.
> 
> But you may still want to gate the clock to the host controller on bus
> inactivity, even if the card is not runtime suspended. The decision to
> do this should come from the mmc core.

This is not clear that this is something that the core can effectively 
help with.  Opportunistic power saving at the host controller level is 
pretty much hardware dependent and may wildly vary in capabilities... 
and bugs.  So in this later case I think the driver for the host 
controller is the best place to just set up a timer and gate the clock 
after a certain period of inactivity for example.


Nicolas
