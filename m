From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] MMC: fix the use of kunmap_atomic() in tmio_mmc.h
Date: Fri, 27 Aug 2010 09:01:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1008270854520.28043@axis700.grange>
References: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
 <20100826160458.17c45371.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:58793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751392Ab0H0HB2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 03:01:28 -0400
In-Reply-To: <20100826160458.17c45371.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Ian Molton <spyro@f2s.com>, Magnus Damm <damm@opensource.se>, Eric Miao <eric.y.miao@gmail.com>

Hi Andrew

On Thu, 26 Aug 2010, Andrew Morton wrote:

> On Sat, 14 Aug 2010 22:29:40 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> No changelog :(

Sorry, I thought this was one of the cases, where the subject says it all.

> - what was wrong with the old code?
> 
> - how did the patch fix it?

How about:

kunmap_atomic() takes the cookie, returned by the kmap_atomic() as its 
argument and not the page address, used as an argument to kmap_atomic(). 
This patch fixes the compile error:

In file included from /opt/src/linux-2.6/drivers/mmc/host/tmio_mmc.c:37:
/opt/src/linux-2.6/drivers/mmc/host/tmio_mmc.h: In function 'tmio_mmc_kunmap_atomic':
/opt/src/linux-2.6/drivers/mmc/host/tmio_mmc.h:192: error: negative width in bit-field '<anonymous>'

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
