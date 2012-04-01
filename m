From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: sh_mmcif: Clock Tweaks
Date: Sun, 01 Apr 2012 00:13:17 -0400
Message-ID: <871uo8m6n6.fsf@laptop.org>
References: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54114 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab2DAENK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Apr 2012 00:13:10 -0400
In-Reply-To: <1332925271-23860-1-git-send-email-horms@verge.net.au> (Simon
	Horman's message of "Wed, 28 Mar 2012 18:01:08 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Cao Minh Hiep <hiepcm@gmail.com>

Hi,

On Wed, Mar 28 2012, Simon Horman wrote:
> Hi,
>
> this series of three small patches cleans up the handling
> of clocks in the MMCIF driver a little.
>
> Simon Horman (3):
>       mmc: sh_mmcif: double clock speed
>       mmc: sh_mmcif: mmc->f_max should be half of the bus clock
>       mmc: sh_mmcif: Simplify calculation of mmc->f_min

Thanks, pushed all three with Guennadi's ACKs to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
