From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Added set_power sdhci_ops handler.
Date: Thu, 23 May 2013 09:25:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305230920430.23354@axis700.grange>
References: <1369244832-23868-1-git-send-email-eu@felipetonello.com>
 <1369244832-23868-2-git-send-email-eu@felipetonello.com>
 <Pine.LNX.4.64.1305222230050.19558@axis700.grange> <2537252.KzShHU8h54@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60657 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab3EWHZj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 03:25:39 -0400
In-Reply-To: <2537252.KzShHU8h54@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, cjb@laptop.org, arnd@arndb.de, linux-kernel@vger.kernel.org

On Wed, 22 May 2013, Felipe Ferreri Tonello wrote:

> Hi Guennadi,
> 
> On Wednesday, May 22, 2013 10:30:40 PM Guennadi Liakhovetski wrote:
> > On Wed, 22 May 2013, Felipe F. Tonello wrote:
> > > From: "Felipe F. Tonello" <eu@felipetonello.com>
> > > 
> > > This is useful for power managment purposes if a sdhci child host wants to
> > > turn off some other peripheral also.
> > 
> > Sorry, could you elaborate a bit? In what situations is it exactly useful?
> > And why cannot the regulator API be used there?
> 
> Sorry about that.
> 
> One example that I can think of is when you have a wifi module connected as a 
> mmc card via sdio. So you can register a callback function in your machine 
> source code to turn on/off the wifi module based on the mmc host power.

Ok, understand. Your second patch in this series adds such a callback in 
your SDHCI host driver and there it just calls a platform callback. I 
don't think this is a good idea. First, we want to go away from platform 
callbacks, because they are incompatible with DT. Second, because the 
proper solution IMHO would be for your platform to export a regulator, and 
the SDHCI core driver already includes regulator support.

> I've seen this implementation in others mmc hosts, such as omap.

Which, however, doesn't yet mean, it's a good idea :)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
