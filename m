From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5 v4] mmc: sh_mmcif: clock and power updates
Date: Wed, 13 Jun 2012 15:37:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50121 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab2FMNhN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 09:37:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This patch series supersedes this thread

http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=14626

and these patches:

http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=14630
http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=14638

It has been decided to reorganise the above series to split it into 
several smaller and simpler ones, to separate platform patches from driver 
patches to reduce cross-dependencies as much as possible.

It requires the recently posted v5 of "mmc: add a function to get 
regulators, supplying card's power," and patch "mmc: sh_mmcif: Support 
MMC_SLEEP_AWAKE command" from Laurent:

http://thread.gmane.org/gmane.linux.kernel.mmc/14939

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
