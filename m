From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/11 v2] mmc: tmio/sdhi: hotplug & PM
Date: Sat, 04 Feb 2012 20:06:20 -0500
Message-ID: <m2ehua84xf.fsf@bob.laptop.org>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
	<m2wr82885d.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1202050147520.3770@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33415 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2BEBGe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 20:06:34 -0500
In-Reply-To: <Pine.LNX.4.64.1202050147520.3770@axis700.grange> (Guennadi
	Liakhovetski's message of "Sun, 5 Feb 2012 01:56:25 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Sat, Feb 04 2012, Guennadi Liakhovetski wrote:
> Thanks. Actually, it recently occurred to me, that patches 3 and 10 should 
> actually be merged into one. So, if you like, I can produce a v3 with that 
> taken into account. The result would be exactly the same, I literally 
> would just apply #10 on top of #3 and commit the result with the same 
> commit description as the v2 of #3.

Sure.

> Shall I also rebase v3 on top of mmx-next and fix the failing patch? The 
> two ARM patches can be applied separately, but they have to go in after 
> this series then. Either way is ok with me, pulling all via mmc has the 
> advantage of not having to synchronise the pulls, but then the conflict 
> probability rises of course.

I'm happy to take the ARM patches, but I'll need ACKs from the relevant
arch maintainers to do that.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
