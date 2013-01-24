From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 24 Jan 2013 11:03:07 -0500
Message-ID: <87k3r2h8lg.fsf@laptop.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
	<Pine.LNX.4.64.1301241630160.7826@axis700.grange>
	<87pq0uh9ob.fsf@laptop.org>
	<Pine.LNX.4.64.1301241649560.7826@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36205 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab3AXQD3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Jan 2013 11:03:29 -0500
In-Reply-To: <Pine.LNX.4.64.1301241649560.7826@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 24 Jan 2013 16:58:34 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Thu, Jan 24 2013, Guennadi Liakhovetski wrote:
> I tried to keep this binding similar to others, that I proposed in "mmc: 
> add DT bindings for more MMC capability flags." Actually, the above is 
> indeed wrong, I would call it "cap-sdio-irq." And in that patch I tried to 
> keep binding names resembling as closely as possible respective MMC_CAP_* 
> flags. I think, it would have been better if "enable-sdio-wakeup" and 
> "keep-power-in-suspend" were also named, following the same rule, but it's 
> too late now. Anyway, I'm not too concerned about the names. We can use 
> "enable-sdio-irq" too if you like.

I see.  Okay, let's go with your proposed cap-* for each MMC_CAP_*, and
the pm_caps can stay as they are.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
