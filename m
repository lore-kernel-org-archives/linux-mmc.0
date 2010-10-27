From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 10:47:09 -0500
Message-ID: <9E9D055931034061A2DB5FFF97887F42@am.dhcp.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com> <20101027153218.04462a45@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34385 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759881Ab0J0Prf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 11:47:35 -0400
In-Reply-To: <20101027153218.04462a45@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Linus Walleij' <linus.ml.walleij@gmail.com>, 'Nicolas Pitre' <nico@fluxnic.net>, 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, "'Kadiyala, Kishore'" <kishore.kadiyala@ti.com>, "'S, Venkatraman'" <svenkatr@ti.com>



> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, October 27, 2010 9:32 AM
> To: Ghorai, Sukumar
> Cc: Chris Ball; Linus Walleij; Nicolas Pitre; Adrian Hunter; linux-
> mmc@vger.kernel.org; Kadiyala, Kishore; Chikkature Rajashekar,
> Madhusudhan; S, Venkatraman
> Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
> 
> > 2. Ideally host-driver driver should not tell the core to shut down
> >    the upper layers, instead the core should decide when to
> >    "disabled clock or cut the power".
> 
> How will the core know ?
> 

Are you saying that MMC core needs to be adapted first to RUNTIME PM?


> I actually think you are simply perpetuating the mess in the existing MMC
> driver where everything is driven by a core which as a result is a twisty
> maze of exceptions and flags to say "except for this" "except for that".
> 
> The core MMC code only knows when the *core* parts are no longer
> requiring power. It shouldn't know about anything deeper and if you are
> using the runtime PM layer the runtime PM refcounting can do all your
> work.
> 
> Alan

