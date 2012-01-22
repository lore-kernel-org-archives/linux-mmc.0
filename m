From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: MMC card access with IOMMU broken
Date: Sun, 22 Jan 2012 11:38:57 +0100
Message-ID: <4F1BE741.9080305@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:52571 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2AVKjR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jan 2012 05:39:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>

Hi all,

a problem first that occurred in 3.2 is still in a problem 3.3rc1

See

http://lists.linuxfoundation.org/pipermail/iommu/2012-January/003438.html

As Chris Wright pointed out there's probably something in the MMC DMA handling
missing when IOMMU is enabled.

I can send new logs like this from the latest 3.3rc1 ...

[   44.508118] mmc0: error -110 whilst initialising MMC card
[   44.604237] mmc0: error -110 whilst initialising MMC card
[   44.711132] DRHD: handling fault status reg 3
[   44.711199] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.711202] DMAR:[fault reason 02] Present bit in context entry is clear
[   44.711226] mmc0: card is mmc v4 but doesn't support any high-speed modes.
[   44.711495] mmc0: power class selection to bus width 4 failed
[   44.711996] DRHD: handling fault status reg 3
[   44.712058] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.712060] DMAR:[fault reason 02] Present bit in context entry is clear
[   44.712093] mmc0: new MMC card at address 0001
[   44.722460] mmcblk0: mmc0:0001 000000 30.6 MiB
[   44.724100] DRHD: handling fault status reg 2
[   44.724165] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.724168] DMAR:[fault reason 02] Present bit in context entry is clear
[   44.724363] DRHD: handling fault status reg 3
[   44.724430] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.724433] DMAR:[fault reason 02] Present bit in context entry is clear
[   44.724667]  mmcblk0: unknown partition table
[   44.729817] DRHD: handling fault status reg 3
[   44.729882] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.729884] DMAR:[fault reason 02] Present bit in context entry is clear
[   44.730088] DRHD: handling fault status reg 3

(..)

[   44.825656] DRHD: handling fault status reg 3
[   44.829802] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
[   44.829805] DMAR:[fault reason 02] Present bit in context entry is clear
[   47.952259] mmc0: card 0001 removed

And also with IOMMU disabled if it helps.

Regards,
Oliver
