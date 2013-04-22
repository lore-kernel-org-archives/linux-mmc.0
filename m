From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
Date: Mon, 22 Apr 2013 23:45:43 +0200
Message-ID: <20130422214543.GJ29947@lunn.ch>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
 <87wqrutjss.fsf@octavius.laptop.org>
 <20130422203723.GI29947@lunn.ch>
 <20130422210949.GJ25724@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:46500 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab3DVVpz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Apr 2013 17:45:55 -0400
Content-Disposition: inline
In-Reply-To: <20130422210949.GJ25724@titan.lakedaemon.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, gmbnomis@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, thomas.petazzoni@free-electrons.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> > > The core function mmc_of_parse() (new in 3.9) will do all of this DT
> > > parsing for you, and will also take care of the driver's later calls
> > > to mmc_gpio_request_{cd,wp}().  Could you try using that function
> > > instead, please?
> > 
> > Hi Chris, Simon
> > 
> > I have a vague recollection that Thomas Petazzoni already did this
> > conversion. Take a look in linux-next, or maybe Jason can point you at
> > a branch.
> 
> Andrew,
> 
> Thomas did a board conversion here (slated for v3.11 in /pcie branch):
> 
>   cd2bde5 arm: kirkwood: convert db-88f6281 to the Device Tree
> 
> And Sebastian did some mvsdio WP and CD pin work here:
> 
>   0d0644eARM: Kirkwood: fix unused mvsdio gpio pins
> 
> Nothing else really jumps out though.  Where either of these what you
> were thinking of?

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138514.html

and

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138513.html

	Andrew
