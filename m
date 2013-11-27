From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on device id
Date: Wed, 27 Nov 2013 21:47:17 +0000
Message-ID: <86fvqhjz4q.fsf@void.printf.net>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-3-git-send-email-tony@atomide.com>
	<20131118184723.GR10317@atomide.com>
	<87ioveeo0x.fsf@octavius.laptop.org>
	<20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51149 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab3K0Vr0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Nov 2013 16:47:26 -0500
In-Reply-To: <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com> (Jarkko
	Nikula's message of "Wed, 27 Nov 2013 22:57:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>

Hi,

On Wed, Nov 27 2013, Jarkko Nikula wrote:
> Can you enlighten me what's the proper way to get patches to mmc since
> I cannot figure out working methodology from MAINTAINERS file?

Sorry about this, Jarkko.

Since I don't have omap.c hardware, I'm generally going to wait for
a Tested-by/Acked-by from someone else on patches like these.  We
actually have a maintainer already listed for the driver, Jarkko
Lavinen <jarkko.lavinen@nokia.com>.

So, maybe the MAINTAINERS section for drivers/mmc/host/omap.c needs
an update?  Feel free to send me patches to it.  Either way, I'll
start treating Aaro and Jarkko (Nikula) as maintainers for this
driver.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
