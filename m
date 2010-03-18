From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 14:19:30 +0000
Message-ID: <20100318141930.GF19544@n2100.arm.linux.org.uk>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37538 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0CROTt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 10:19:49 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "V, Hemanth" <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, "pierre@ossman.eu" <pierre@ossman.eu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 18, 2010 at 07:00:06PM +0530, Shilimkar, Santosh wrote:
> Or could it be that there is appropriate cacheflush happening but data gets
> stuck in CPU writebuffers instead of reaching to main memory. In this case
> too DMA won't see the contents and a barrier (dsb) is necessary to ensure
> that write buffer is drained before DMA takes over the buffer.

That would imply that the data on the device is becoming corrupted.

What exactly is the problem that we're discussing?  Is it that the data
on the block device is becoming corrupted, or is the data being read off
the block device corrupted?
