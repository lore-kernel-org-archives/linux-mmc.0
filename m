From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] mmc: tmio: two bug-fixes
Date: Thu, 14 Jul 2011 18:39:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab1GNQjc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 12:39:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Simon Horman <horms@verge.net.au>

So, Chris, I lied:-)

There go two more bug-fixes for tmio on top of my earlier patches from 
today, so, should still be easy enough to trace. So, to pull them 
together, the previous ones were

[PATCH v3] mmc: tmio: fix recursive spinlock, don't schedule with interrupts disabled
[PATCH v3] mmc: tmio: maximize power saving

And now follow

[PATCH 1/2] mmc: tmio: fix a recently introduced bug in DMA code
[PATCH 2/2] mmc: tmio: fix a deadlock

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
