From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: + mmc-add-dma-support-to-tmio_mmc-driver-when-used-on-superh.patch
  added to -mm tree
Date: Thu, 13 May 2010 15:20:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005131511540.4671@axis700.grange>
References: <201005122255.o4CMtmvN025653@imap1.linux-foundation.org>
 <AANLkTim5U-JbrVCBKHnERgHol2GcwTfweQyI4onR1Skh@mail.gmail.com>
 <Pine.LNX.4.64.1005131357500.4671@axis700.grange>
 <AANLkTinPW2W6aV1smLsQObLOAS3bECDZ7mhSGCm2aqgO@mail.gmail.com>
 <Pine.LNX.4.64.1005131415460.4671@axis700.grange>
 <AANLkTik4gzuZvrAwbK-dyCXVYf5gLD0RGrpvM55YLzOK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754149Ab0EMNU0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 May 2010 09:20:26 -0400
In-Reply-To: <AANLkTik4gzuZvrAwbK-dyCXVYf5gLD0RGrpvM55YLzOK@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

(re-adding CC)

On Thu, 13 May 2010, Ian Molton wrote:

> Might be worth exposing for now, whilst the feature is new. but yes,
> automatic select yes on all the platforms you are comfortable with.
> 
> Im not sure if it should be per MFD or per platform. I tend to think
> the latter, given that its slave DMA and thus I could have the same
> MFD in platforms with different CPUs (eg. e740 and e800) where a CPU
> bug might upset one but not the other.

So far I went for the least effort - not exposed, selected by MFDs. If we 
ever have a need to change this, e.g., make it user-selectable or per 
platform, we can always do so later. For now all SuperH / SH-Mobile 
platforms I tested can use this driver with DMA. Expect updated patches 
shortly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
