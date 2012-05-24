From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 13:18:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52679 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2EXLTA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 07:19:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@marvell.com>

Hi all

I'm a bit confused by the above two macros. The latter of them seems 
rather clear: it indicates, whether the card power should be kept across 
all kinds of suspend. Whereas the former one is not so clear. Some sources 
indicate, that this flag means, that the host / board are _capable_ of 
powering down the slot. Others seem to suggest, that it also means, that 
the card can handle being powered off. The former meaning would make sense 
to me, but then - why would one want to check it when deciding whether or 
not to use runtime PM with the host? Isn't it exactly what the 
MMC_PM_KEEP_POWER flag is for? If MMC_CAP_POWER_OFF_CARD does indeed mean, 
that the host is able to switch the power off and on, then it can be 
safely set almost always. E.g., if the slot is supplied by a regulator, 
this flag can be enabled automatically?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
