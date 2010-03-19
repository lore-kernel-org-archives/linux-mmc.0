From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 18:38:20 +0000
Message-ID: <20100319183820.GB27710@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <1269009677.31227.10.camel@e102109-lin.cambridge.arm.com> <20100319144647.GG21280@n2100.arm.linux.org.uk> <1269010320.31227.13.camel@e102109-lin.cambridge.arm.com> <alpine.LFD.2.00.1003191347230.31128@xanadu.home> <alpine.LFD.2.00.1003191359440.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48425 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0CSSjs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 14:39:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003191359440.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, Mar 19, 2010 at 02:27:24PM -0400, Nicolas Pitre wrote:
> But on ARMv6 this is different.  The L1 cache is VIPT and it therefore 
> doesn't have to be flushed as often as a VIVT cache.  Still, as far as I 
> know, the highmem code currently always flush any page to be unmapped.  
> But somewhere somehow an unmapped highmem page becomes subject to DMA 
> and apparently can still be L1 cached.

This does not explain the corrupted ext2 metadata, which is in lowmem
pages.

Let's get a fresh set of clear bug reports giving all relevant information.
Let's not continue to scatter small little bits of information in multiple
emails.

>From now on, I'm ignoring this thread completely; it's a waste of time
to continue with it.
