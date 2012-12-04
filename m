From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] mmc: add a card-event host call-back
Date: Tue, 4 Dec 2012 16:51:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49368 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab2LDPvg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 10:51:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

In a recent thread [1] an extension to the slot-gpio MMC API, adding a 
host call-back for card detection events, has been proposed. This 
extension shall be used by the SDHCI driver to reset the host if the card 
is ejected during a running request. These patches add such a call-back.


Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/17924/focus=17927

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
