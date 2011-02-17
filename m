From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/11] MMC DMA-API/dmaengine fixups
Date: Thu, 17 Feb 2011 02:54:54 +0000
Message-ID: <20110217025454.GA22589@void.printf.net>
References: <1297350372-725-1-git-send-email-linus.walleij@linaro.org> <AANLkTi=aU9B7Qo3RWifjJPLXR_E6hQm4A3iEdsLwhcgX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35013 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756090Ab1BQCzC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 21:55:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=aU9B7Qo3RWifjJPLXR_E6hQm4A3iEdsLwhcgX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Arnd Hannemann <arnd@arndnet.de>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On Wed, Feb 16, 2011 at 10:04:20PM +0100, Linus Walleij wrote:
> Chris are you picking these up? Maybe the only way of getting
> some broad test of these cleanups is to push it into -next
> so it'll be noticed...

Hm, okay -- I've pushed the whole patchset to mmc-next.  (-next
is supposed to be a set of trees that each maintainer would be 
comfortable pushing to Linus immediately, though..)

I'd still like to see some ACKs for tmio/sh_mmc before pushing
these to mainline.  I'm CCing some folks who should be able to
help out with testing; if you can, would be much appreciated!

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
