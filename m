From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/9 v2] add DMA support to tmio_mmc, using dmaengine API,
 use it on SH
Date: Tue, 4 May 2010 16:06:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754057Ab0EDOGR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 May 2010 10:06:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>

This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
using the dmaengine API. DMA is enabled on SuperH platforms and ARM 
shmobile boards, both use the sh_mobile_sdhi MFD driver. Other TMIO MFD 
implementations are unaffected. The patch transparently falls back to PIO 
if no DMA is configured by the MFD driver, or if DMA initialisation or 
execution fails.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
