From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 13:59:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
References: <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
 <20100318092352.GD8267@n2100.arm.linux.org.uk>
 <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
 <20100318112453.GA19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
 <20100318141930.GF19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
 <20100319015523.GD14108@shareable.org>
 <alpine.LFD.2.00.1003190908330.31128@xanadu.home>
 <20100319132750.GE21280@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:57918 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0CSR7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 13:59:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZJ00EXFJB4TQ50@VL-MH-MR003.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 13:59:28 -0400 (EDT)
In-reply-to: <20100319132750.GE21280@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:

> On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> > And in this case, the same SATA driver is used on two different system, 
> > one being ARMv5 with absolutely no issues with highmem, and the other 
> > being ARMv6 with highmem problems.  So that pretty much rules out IDE 
> > driver bugs.
> 
> No it doesn't - there's more changes between ARMv5 and ARMv6 than just
> the cache model.  There's weak memory ordering effects too.

Sure.  But at the moment we have:

 - ARMv5 without highmem -> works

 - ARMv5 with highmem -> works

 - ARMv6 without highmem -> works

 - ARMv6 with highmem -> fails

In all four cases the SATA driver, the hard disk and the filesystem on 
it are identical.  In the two ARMv5 cases the system and the kernel are 
identical.  Ditto for the two ARMv6 cases.

And the kernel used is the very latest i.e. v2.6.34-rc1-1642-gfc7f99c.


Nicolas
