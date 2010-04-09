From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How to make kernel block layer generate bigger request in the
 request queue?
Date: Fri, 09 Apr 2010 17:54:38 -0600
Message-ID: <4BBFBE3E.5070605@gmail.com>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52158 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab0DIXyl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2010 19:54:41 -0400
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 04/09/2010 08:07 AM, Gao, Yunpeng wrote:
> Hi,
>
> I'm working on a block device driver (NAND flash driver with FTL layer) on 2.6.31 Kernel. And try to improve sequential read/write performance of the block driver.
>
> When I debug the driver, I found that the sector numbers of every r/w request in the request queue is always not bigger than 8. That means, for every r/w request, it only handle 512 * 8 = 4KB bytes at most. And I think the sequential r/w speed can be improved if the Linux block layer generates bigger size data (for example, 64KB) for every request in the request queue.
>
> To implement this, I have added some code as below (My hardware doesn't support scatter/gather, but can do 512KB DMA data transfer):
> 	...
> 	blk_queue_max_sectors(dev->queue, 1024);
> 	blk_queue_max_phys_segments(dev->queue, 128);
> 	blk_queue_max_hw_segments(dev->queue, 1);
> 	blk_queue_max_segment_size(dev->queue, 524288);
> 	...
> And also set NOOP as the default IO Scheduler (because the underlying 'block' device is NAND flash, not a real hard disk).
>
> But seems it doesn't work. The block layer still generate at most 8 sector r/w request in request queue even if I read/write 1GB data from/to the device with dd command.
>
> Did I miss something to make the block layer generate bigger size data for every request in the request queue?
> Below is part of my source code. Any comments are highly appreciated. Thank you in advance.

8 sectors is 4KB, that's the size of a page. If the pages that are being 
written are not physically contiguous that may be the best the block 
layer can do with the constraints you've given it (not supporting any 
more than 1 DMA segment). I don't think it will try to copy pages around 
in order to try and generate a bigger request.
