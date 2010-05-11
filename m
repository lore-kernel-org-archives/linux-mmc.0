From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/9 v3] add DMA support to tmio_mmc, using dmaengine API,
 use it on SH
Date: Tue, 11 May 2010 12:07:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005111156170.6810@axis700.grange>
References: <Pine.LNX.4.64.1005071625260.4777@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754704Ab0EKKHF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 May 2010 06:07:05 -0400
In-Reply-To: <Pine.LNX.4.64.1005071625260.4777@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Andrew

2.6.35 release is approaching and Ian hasn't found time yet to review this 
series, so I was wondering, maybe you could take it into mm at least for 
now?

Thanks
Guennadi

On Fri, 7 May 2010, Guennadi Liakhovetski wrote:

> Following this email I'll send two patches, that split
> 
> [PATCH 4/9 v2] MMC: add DMA support to tmio_mmc driver, when used on SuperH
> 
> into two parts: mfd and mmc. Also adding MFD maintainer to CC, which I've 
> forgotten to do on previous iterations (sorry, Samuel). Otherwise no 
> changes, that's why I'm also not resending other patches. Hopefully 
> reviewing will become easier this way.
> 
> Here's the original description again:
> 
> This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
> using the dmaengine API. DMA is enabled on SuperH platforms and ARM 
> shmobile boards, both use the sh_mobile_sdhi MFD driver. Other TMIO MFD 
> implementations are unaffected. The patch transparently falls back to PIO 
> if no DMA is configured by the MFD driver, or if DMA initialisation or 
> execution fails.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
