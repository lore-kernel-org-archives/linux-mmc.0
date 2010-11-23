From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] handle unaligned buffers, when using TMIO-MMC with DMA
Date: Tue, 23 Nov 2010 17:24:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753962Ab0KWQYE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 11:24:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

While testing SDIO on SuperH with TMIO and DMA, it turned out, that 
buffers, submitted to the driver can be arbitrarily aligned, and this is 
not handled by the tmio driver. This patch series fixes this issue.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
