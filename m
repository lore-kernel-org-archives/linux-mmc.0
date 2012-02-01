From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: TMIO/SDHI and MMCIF fixes for 3.3
Date: Wed, 1 Feb 2012 15:34:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202011530260.26261@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64162 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2BAOeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 09:34:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris

Just to make sure, they don't get forgotten: there are 2 patches, that I 
sent to the ML earlier, that are bug-fixes and should go into 3.3:

http://article.gmane.org/gmane.linux.ports.sh.devel/13216
http://article.gmane.org/gmane.linux.kernel.mmc/12381

Please, push with your next MMC fixes pull request. Yes, I did verify 
since then, that they apply and work with the mainline kernel too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
