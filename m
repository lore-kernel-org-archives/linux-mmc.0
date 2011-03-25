From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2 v2] tmio_mmc: improve DMA reliability (fwd)
Date: Fri, 25 Mar 2011 14:36:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103251430260.22824@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

v2: rebased on top of DMA API update patches from Linus Walleij

Chris, sorry again, forgot to send these out...

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
