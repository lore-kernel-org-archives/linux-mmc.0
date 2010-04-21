From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/8] add DMA support to tmio_mmc, using dmaengine API, use
 it on SH
Date: Wed, 21 Apr 2010 17:36:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755615Ab0DUPga (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 11:36:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
using the dmaengine API. So far this is only used on SuperH platforms, 
will also be supported on ARM shmobile boards, both use the sh_mobile_sdhi 
MFD driver. Other TMIO MFD implementations are unaffected. The patch 
transparently falls back to PIO if no DMA is configured by the MFD driver, 
or if DMA initialisation or execution fail.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
