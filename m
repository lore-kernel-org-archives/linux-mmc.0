From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 16:53:27 +0100
Message-ID: <20101027165327.3dfb7696@lxorguk.ukuu.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<20101027153218.04462a45@lxorguk.ukuu.org.uk>
	<9E9D055931034061A2DB5FFF97887F42@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59225 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756039Ab0J0Pyb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 11:54:31 -0400
In-Reply-To: <9E9D055931034061A2DB5FFF97887F42@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: "'Ghorai, Sukumar'" <s-ghorai@ti.com>, 'Chris Ball' <cjb@laptop.org>, 'Linus Walleij' <linus.ml.walleij@gmail.com>, 'Nicolas Pitre' <nico@fluxnic.net>, 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, "'Kadiyala, Kishore'" <kishore.kadiyala@ti.com>, "'S, Venkatraman'" <svenkatr@ti.com>

> > > 2. Ideally host-driver driver should not tell the core to shut down
> > >    the upper layers, instead the core should decide when to
> > >    "disabled clock or cut the power".
> > 
> > How will the core know ?
> > 
> 
> Are you saying that MMC core needs to be adapted first to RUNTIME PM?

I think the runtime pm layer actually does help solve the problem -
because it allows both the driver and the core to defer power off.

To me the fundamental problem is that the MMC/SDHCI core thinks it is
all knowing, when in reality silicon designers are far too good at
producing weird, whacky, broken and otherwise bizarre implementations.

Eventually it will all break because a design comes along which is
common, and sufficiently different.

(PS: this should be discussed on the list not via some random collection
of email addresses)

Alan
