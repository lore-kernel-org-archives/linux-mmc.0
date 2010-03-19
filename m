From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 18:26:52 +0000
Message-ID: <1269023212.22473.5.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:65313 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013Ab0CSS1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 14:27:46 -0400
In-Reply-To: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jamie Lokier <jamie@shareable.org>, "V, Hemanth" <hemanthv@ti.com>, linux-mmc@vger.kernel.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, pierre@ossman.eu, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, 2010-03-19 at 17:59 +0000, Nicolas Pitre wrote:
> On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:
> 
> > On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> > > And in this case, the same SATA driver is used on two different system,
> > > one being ARMv5 with absolutely no issues with highmem, and the other
> > > being ARMv6 with highmem problems.  So that pretty much rules out IDE
> > > driver bugs.
> >
> > No it doesn't - there's more changes between ARMv5 and ARMv6 than just
> > the cache model.  There's weak memory ordering effects too.
> 
> Sure.  But at the moment we have:
> 
>  - ARMv5 without highmem -> works
> 
>  - ARMv5 with highmem -> works
> 
>  - ARMv6 without highmem -> works
> 
>  - ARMv6 with highmem -> fails
> 
> In all four cases the SATA driver, the hard disk and the filesystem on
> it are identical.  In the two ARMv5 cases the system and the kernel are
> identical.  Ditto for the two ARMv6 cases.

Which ARMv6 processor is this?

Is the SATA driver using DMA (I think I read this in the thread but it
started as MMC issues and got confused)?

Thanks.

-- 
Catalin

