From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Wed, 27 Nov 2013 13:59:19 -0800
Message-ID: <20131127215918.GD26766@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
 <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
 <86fvqhjz4q.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63993 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab3K0V7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Nov 2013 16:59:30 -0500
Content-Disposition: inline
In-Reply-To: <86fvqhjz4q.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Lavinen <j.lavinen@samsung.com>

* Chris Ball <cjb@laptop.org> [131127 13:48]:
> Hi,
> 
> On Wed, Nov 27 2013, Jarkko Nikula wrote:
> > Can you enlighten me what's the proper way to get patches to mmc since
> > I cannot figure out working methodology from MAINTAINERS file?
> 
> Sorry about this, Jarkko.
> 
> Since I don't have omap.c hardware, I'm generally going to wait for
> a Tested-by/Acked-by from someone else on patches like these.  We
> actually have a maintainer already listed for the driver, Jarkko
> Lavinen <jarkko.lavinen@nokia.com>.
> 
> So, maybe the MAINTAINERS section for drivers/mmc/host/omap.c needs
> an update?  Feel free to send me patches to it.  Either way, I'll
> start treating Aaro and Jarkko (Nikula) as maintainers for this
> driver.

Hmm looks like here's a reasonably recent update that we've missed
from Jarkko Lavinen to update his email address:

http://lkml.org/lkml/2013/10/4/142

I've updated Jarkko Lavinen's address in this mail, we should
probably also patch the MAINTAINERS file for that, and then see if
Aaro and Jarkko Nikula are interested to be listed there as well.

Regards,

Tony
