From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix address in kunmap_atomic() calls
Date: Mon, 14 Mar 2011 18:12:11 -0400
Message-ID: <m38vwhuzb8.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1103110822160.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53784 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab1CNWO4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2011 18:14:56 -0400
In-Reply-To: <Pine.LNX.4.64.1103110822160.23675@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 11 Mar 2011 08:30:14 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Fri, Mar 11 2011, Guennadi Liakhovetski wrote:
> Currently kunmap_atomic() doesn't take into account the offset, used
> with kmap_atomic(). On platforms, where kunmap_atomic() is not a NOP,
> this will lead to problems, when offset != 0.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> No, I've never seen this bug trigger, so, not sure whether we need it for 
> .38 / stable.

Thanks, I've pushed this to mmc-next for .39.

Could I get your ACK on the sh/tmio patches in Linus W's "[PATCH 00/11]
MMC DMA-API/dmaengine fixups" patchset, please?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
