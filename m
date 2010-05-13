From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/9 v4] add DMA support to tmio_mmc, using dmaengine API,
 use it on SH
Date: Thu, 13 May 2010 16:15:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is yet another split of patch

[PATCH 4/9] MMC: add DMA support to tmio_mmc driver, when used on SuperH

whereby per Ian's request patch "4a" has been further split in tmio- and 
sdhi-parts, so that now we have patches 4a/9, 4b/9 and 4c/9.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
