From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/3] handle unaligned buffers, when using TMIO-MMC with
 DMA
Date: Tue, 14 Dec 2010 17:07:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012141704330.8500@axis700.grange>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ian

It's been 3 weeks... Have you had a chance to look at these and previous 
my tmio patches? Any comments or are they ok to go?

Thanks
Guennadi

On Tue, 23 Nov 2010, Guennadi Liakhovetski wrote:

> While testing SDIO on SuperH with TMIO and DMA, it turned out, that 
> buffers, submitted to the driver can be arbitrarily aligned, and this is 
> not handled by the tmio driver. This patch series fixes this issue.
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
