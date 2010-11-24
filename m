From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5 v2] MMC: DMA for SH MMCIF
Date: Wed, 24 Nov 2010 11:05:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
DMA capability to it. One of the patches is not directly related, but is 
required for a proper DMA functionality. V2 limits the number of request 
segments, instead of raising the number of DMA descriptors in shdma.c. 
This drops one patch from this series and modifies one further patch, the 
rest remain unchanged.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
