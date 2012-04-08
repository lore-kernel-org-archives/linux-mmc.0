From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 06/10 v3] ARM: mach-shmobile: convert ag5evm to use the
 generic MMC GPIO hotplug helper
Date: Sun, 8 Apr 2012 13:33:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204081328100.29005@axis700.grange>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
 <1328824636-10553-7-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2DHLdc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Apr 2012 07:33:32 -0400
In-Reply-To: <1328824636-10553-7-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

Now that MMC patches from this series are in the mainline, also 
architecture patches can and should be applied. These are patches 5 and 6 
from this series:

http://article.gmane.org/gmane.linux.kernel.mmc/12748
http://article.gmane.org/gmane.linux.ports.sh.devel/13535

Would be good to have them in 3.4 since they fix modular MMC builds on 
ag5evm and mackerel.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
