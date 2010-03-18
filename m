From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 20:11:01 +0530
Message-ID: <0b0f01cac6a9$0a8b8990$LocalHost@wipblrx0099946>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com> <20100318141930.GF19544@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50264 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab0CROl2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Mar 2010 10:41:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

----- Original Message ----- 
From: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Nicolas Pitre" <nico@fluxnic.net>; <linux-mmc@vger.kernel.org>; "V, 
Hemanth" <hemanthv@ti.com>; "saeed bishara" <saeed.bishara@gmail.com>; 
<pierre@ossman.eu>; <linux-arm-kernel@lists.infradead.org>
Sent: Thursday, March 18, 2010 7:49 PM
Subject: Re: Highmem issues with MMC filesystem


> On Thu, Mar 18, 2010 at 07:00:06PM +0530, Shilimkar, Santosh wrote:
>> Or could it be that there is appropriate cacheflush happening but data 
>> gets
>> stuck in CPU writebuffers instead of reaching to main memory. In this 
>> case
>> too DMA won't see the contents and a barrier (dsb) is necessary to ensure
>> that write buffer is drained before DMA takes over the buffer.
>
> That would imply that the data on the device is becoming corrupted.
>
> What exactly is the problem that we're discussing?  Is it that the data
> on the block device is becoming corrupted, or is the data being read off
> the block device corrupted?
>

It seems like data being read off the block device is being corrupted,
since if we replace highmem kernel with a non-highmem kernel
the filesystem is able to bootup fine. 

