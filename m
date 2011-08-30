From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] mmc: sh_mmcif: simplify platform DMA configuration
Date: Tue, 30 Aug 2011 18:26:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63484 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab1H3Q0h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 12:26:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>

A simple cosmetic clean-up, no functional changes. Patch 2/2 depends on 
patch 1/2 and can wait until 3.3. Paul, would you be able to put it under 
the carpet somewhere until then or shall I resend it after 3.2-rc1 is out? 
After both these patches have been applied, we can remove struct 
sh_mmcif_plat_data::dma around 3.4 or 4.0 or whatever;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
