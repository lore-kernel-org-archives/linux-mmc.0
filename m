From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] mmc: add DMA SG synchronisation
Date: Fri, 31 Jan 2014 12:54:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55408 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaAaLyS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Jan 2014 06:54:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Hi

This is something, that seems to be missing from all mmc host drivers. At 
least all except sdhci and, possibly, mmc-spi, but sdhci uses its own DMA 
engine, and mmc-spi does DMA synchronisation in a somewhat strange way - 
before and after SPI synchronisation for both data transfer directions. 
Otherwise all other drivers map and unmap SG lists, perform DMA transfers, 
but never call dma_sync_*_for_*(). Apparantly, this works, but IIUC, this 
violates the DMA API. I'm attaching a couple of patches for a couple of 
those drivers for consideration. If this is confirmed to be the right 
thing to do, I could do more of those.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
