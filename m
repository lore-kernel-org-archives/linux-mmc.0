From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: Two eMMC4.5 new featurs - 'Larger Sector size' and 'Packed
 commands'
Date: Mon, 9 May 2011 15:59:14 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47358F60E68@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37045 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab1EIH7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 03:59:42 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I'm investigating on eMMC 4.5 new features and have some concerns on below new features:

1. Large sector size (Native 4KB sector behavior)
	The eMMC4.5 Spec says 'All devices with capacities higher than 256GB shall have native sector size of 4KB'.
	And it also requires that in the Native 4KB sector size mode, data transfers still use 512B CC-protected blocks,
	but data shall be transferred in multiple of 8 such blocks (always multiples of 4KB).

	Since current kernel block layer uses 512B sector, then we have to pad the eMMC device read/write access to 4KB aligned if the block layer request sectors are not 4KB aligned.
	For example, if kernel block layer only wants to read 1 sector (512 byte) from the eMMC device, then the mmc driver has to read 8 sectors first and then return only the requested 1 	sector. I think this will slow down mmc driver performance.

	So, I'm not sure whether it makes any sense to implement this feature. Any idea?

2. Packed commands
	The eMMC 4.5 Spec allows 'Read and write commands can be packed in groups of commands (either all read or all write) that transfer the data for all commands in the group in one 	transfer on the bus, to reduce overheads.'

	For both packed read/write command, the driver needs to first issue a CMD23 with the PACKED flag set and then a CMD25 to send a 'packed command header'. Then driver can 	read/write multiple data blocks with the CMD18/CMD25.

	To my understanding, in current kernel mmc driver, how many sectors/blocks can be transferred in one request is decided by the kernel block layer. In most of the popular platforms, I 	believe it will not transfer more than 512K bytes in one request. And there's no problem for transferring 512KB data in one CMD18/CMD25.

	So, only single CMD18/CMD25 is enough for current MMC driver and I don't see any benefits by implementing the packed commands in current MMC driver. Any comments?


Thanks.

Regards,
Yunpeng


