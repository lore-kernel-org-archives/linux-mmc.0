From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] tmio_mmc: improve DMA reliability
Date: Mon, 7 Mar 2011 14:30:21 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071417340.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49189 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1CGNa0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 08:30:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

On my test hardware I am getting different results with different SD and 
SDIO cards on different boards in different slots. The first patch in this 
series fixes DMA for all my available hardware, the second one is a 
further improvement to make switching between DMA and PIO possible at 
run-time on a per-transfer basis and uses PIO for short transfers also 
when DMA is available.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
