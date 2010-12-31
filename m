From: Chris Ball <cjb@laptop.org>
Subject: Re: 2.36.1 sdhci R5C822 regression
Date: Fri, 31 Dec 2010 03:47:43 +0000
Message-ID: <20101231034743.GA19122@void.printf.net>
References: <4D0B380C.4000407@tls-tautenburg.de> <20101217153024.GA26910@void.printf.net> <4D0BA461.6050803@tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59493 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab0LaDrp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Dec 2010 22:47:45 -0500
Content-Disposition: inline
In-Reply-To: <4D0BA461.6050803@tls-tautenburg.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Cc: linux-mmc@vger.kernel.org

Hi Bringfried,

On Fri, Dec 17, 2010 at 06:56:49PM +0100, Bringfried Stecklum wrote:
> Thanks for the patch which, however, does not solve the problem. Now I don't
> get the oops immediately upon resume from hibernation but later, on inserting
> the card (2.6.37 is no solution at the moment since my system is on a Reiser4
> partition, so I have to wait for those patches).

If you're able to at some point, it'd be very helpful to do some Git
bisection here.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
