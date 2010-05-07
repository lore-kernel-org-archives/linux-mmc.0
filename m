From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/9 v3] add DMA support to tmio_mmc, using dmaengine API,
 use it on SH
Date: Fri, 7 May 2010 16:32:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005071625260.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Following this email I'll send two patches, that split

[PATCH 4/9 v2] MMC: add DMA support to tmio_mmc driver, when used on SuperH

into two parts: mfd and mmc. Also adding MFD maintainer to CC, which I've 
forgotten to do on previous iterations (sorry, Samuel). Otherwise no 
changes, that's why I'm also not resending other patches. Hopefully 
reviewing will become easier this way.

Here's the original description again:

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
