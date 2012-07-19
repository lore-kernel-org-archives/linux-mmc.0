From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Thu, 19 Jul 2012 04:32:47 -0700
Message-ID: <20120719113246.GN6522@atomide.com>
References: <20120718065951.GH6522@atomide.com>
 <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
 <20120718071039.GI6522@atomide.com>
 <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com>
 <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
 <CAMQu2gxLwGACAT-r6=L9DKB=3fTNaEJ4woZOb4zttJ8qTTJmFA@mail.gmail.com>
 <CAAwP0s2apfBHLKHtzvwqb2KPCMNhEXMe5R9792bO7FhfY5Y+uQ@mail.gmail.com>
 <CANfBPZ_N4ZK5PgFQLHWMwsG60tb-FPTjeieTJ92rBUNgONAxAw@mail.gmail.com>
 <CAMQu2gy+uXJFfmOwLX=YH41pr-N+T28-1wLo5rXEaj9MGffHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36856 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2GSLcv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 07:32:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gy+uXJFfmOwLX=YH41pr-N+T28-1wLo5rXEaj9MGffHPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 02:49]:
> 
> "The patch simply make them depend on DMA_OMAP since DMA_OMAP
> will select DMA_ENGINE automatically"
> 
> This won't be true if the DMA selection are not done
> at ARCH_OMAP level as discussed in this thread.
> 
> Having said that, I think Russell and Tony need to
> take call on how this needs to be handled.

As the DMA channels can run out, drivers should also work
without DMA. And building everything as modules should be
possible for the distro kernels.

So I'd rather not have either select or depends and have
the drivers fixed.

Tony
