From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 09:23:52 +0000
Message-ID: <20100318092352.GD8267@n2100.arm.linux.org.uk>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37965 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0CRJYM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 05:24:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Hemanth V <hemanthv@ti.com>, pierre@ossman.eu, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 17, 2010 at 10:58:48AM -0400, Nicolas Pitre wrote:
> On Wed, 17 Mar 2010, Hemanth V wrote:
> > Nicolas, Russel are there any more details available which might help
> > in investigating this further.
> 
> The only conclusion I came to so far is that ARMv5 where highmem works 
> just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache.  
> And the problem with VIPT caches occurs when direct DMA is involved, 
> otherwise there is no problem if PIO or NFS is used.  Sprinkling some 
> flush_cache_all() in a few places makes things work, but this is not a 
> satisfactory solution.

This sounds like the problem we had with the DMA API.  Since that's now
fixed, there shouldn't be a problem with the latest (-rc) kernels, or
a kernel with my old streaming DMA patches applied.
