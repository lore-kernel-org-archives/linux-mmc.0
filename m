From: "Madhusudhan" <madhu.cr@ti.com>
Subject: mmcqd cpu utilization
Date: Wed, 2 Sep 2009 12:23:59 -0500
Message-ID: <007301ca2bf2$2888e2a0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49644 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZIBRYR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2009 13:24:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>, hch@lst.de

Hi,

Has anyone monitored the cpu utilization percentage when a MMC/SD card is in
use? I have noticed that mmc_queue_thread "mmcqd" consumes a lot of cpu
cycles in a periodic fashion. What I mean here is that I see spikes of high
cpu utilization due to mmcqd. There will a cp or similar which will be
already consuming cpu to transfer data to the MMC/SD device. Further mmcqd
increases that load randomly to a high number.

Has anyone seen similar behavior? Any thoughts?

Regards,
Madhu  

