From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/11 v2] mmc: tmio/sdhi: hotplug & PM
Date: Sat, 04 Feb 2012 18:56:46 -0500
Message-ID: <m2wr82885d.fsf@bob.laptop.org>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48478 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab2BDX5D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 18:57:03 -0500
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Tue, 24 Jan 2012 13:01:29 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Tue, Jan 24 2012, Guennadi Liakhovetski wrote:
> This is v2 of a patch series, that uses the recently committed generic 
> GPIO card hotplug handler, fixes minor PM issues, adds some cosmetic 
> clean up. The series applies on top of v3.3-rc1 and the following earlier 
> submitted patches:
>
> mmc: sh_mmcif: fix late delayed work initialisation
>     http://article.gmane.org/gmane.linux.kernel.mmc/12381
> mmc: tmio_mmc: fix card eject during IO with DMA
>     http://article.gmane.org/gmane.linux.ports.sh.devel/13216
>
> Comments from Magnus for v1 of this series have been addressed - thanks!

Thanks, looks good to me.  One of the two ARM patches doesn't apply to
mmc-next, and neither has an ACK attached -- do you want to merge those
two separately, if I take the rest into mmc-next now for 3.4?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
