From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix address in kunmap_atomic() calls
Date: Fri, 18 Mar 2011 16:35:02 -0400
Message-ID: <m339mkupzd.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1103110822160.23675@axis700.grange>
	<m38vwhuzb8.fsf@pullcord.laptop.org>
	<Pine.LNX.4.64.1103142349490.6125@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53677 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756818Ab1CRUiH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Mar 2011 16:38:07 -0400
In-Reply-To: <Pine.LNX.4.64.1103142349490.6125@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 14 Mar 2011 23:54:22 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Mon, Mar 14 2011, Guennadi Liakhovetski wrote:
> Hm, I've looked at them briefly and nothing in them struck me in them, but 
> if you want a formal reviewed-by or such I'll have to look at them in more 
> detail. I'm away from tomorrow until Saturday at a V4L2 meeting, so, will 
> have little time... I'll try to do that, but, will not be able to test 
> them. So, either just a review this week or a review + test not before 
> next weekend, sorry.

Okay.  I'll put them in with the .39 merge; they've been in -next for a
while, are hopefully low-risk, and we can always revert later before .39
releases.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
