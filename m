From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/6] MMC: DMA for SH MMCIF
Date: Thu, 11 Nov 2010 08:40:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:40148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757736Ab0KKHkl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 02:40:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
DMA capability to it. One of the patches is not directly related, but is 
required for a proper DMA functionality.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
