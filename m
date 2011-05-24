From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] Make DMA slave ID 0 invalid to simplify platform data
Date: Tue, 24 May 2011 12:23:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62375 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab1EXKYH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 06:24:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Currently platforms, using the SDHI TMIO driver, have to specify negative 
DMA slave IDs to force PIO mode. If default 0 is left, the driver 
recognises it as a valid DMA slave ID and tries to acquire channels. This 
fails then, because the driver cannot allocate two channels with the same 
ID, but it would be better to just make 0 an invalid ID to prevent this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
