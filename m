From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 13:27:50 +0000
Message-ID: <20100319132750.GE21280@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com> <20100318141930.GF19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003181205020.31128@xanadu.home> <20100319015523.GD14108@shareable.org> <alpine.LFD.2.00.1003190908330.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32954 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0CSN2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 09:28:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003190908330.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jamie Lokier <jamie@shareable.org>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> And in this case, the same SATA driver is used on two different system, 
> one being ARMv5 with absolutely no issues with highmem, and the other 
> being ARMv6 with highmem problems.  So that pretty much rules out IDE 
> driver bugs.

No it doesn't - there's more changes between ARMv5 and ARMv6 than just
the cache model.  There's weak memory ordering effects too.

A missing barrier or a badly implemented barrier can result in ARMv5
and earlier working perfectly, but ARMv6+ randomly failing.

Eg, we know that ARMv6+ CPUs with L2 cache, the wmb() implementation is
not sufficient, and DMA can be started before the write to
dma_alloc_coherent memory has become visible to the DMA controller, and
that's a topic of discussion at the present time.
