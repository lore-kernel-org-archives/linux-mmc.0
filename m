From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 06/29] regulator: export a function to check if regulator
 can change status
Date: Fri, 18 May 2012 10:33:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181030550.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
 <20120503152558.GL3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57273 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab2ERIdo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 04:33:44 -0400
In-Reply-To: <20120503152558.GL3955@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Mark

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:35PM +0200, Guennadi Liakhovetski wrote:
> > Some consumers, e.g., the mmc subsystem, can benefit from an ability to
> > check, whether a regulator can switch power on and off.
> 
> You're going to have to expand a lot more on why this is a good idea...

I want to use this call in mmc to decide whether or not to set the 
MMC_CAP_POWER_OFF_CARD mmc capability flag. This flag is used with SDIO 
cards to decide whether or not to enable runtime PM for them.

> Bear in mind that the regulator may be shared by other users so even if
> the regulator is flagged as potentially being able to change status that
> doesn't mean that it actually can change status.

Yes, I think, that's ok. We just need to know, that the card can in 
principle be powered off. We don't need a guarantee, that we can power it 
down at any time, when we think we need it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
