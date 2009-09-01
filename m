From: "Madhusudhan" <madhu.cr@ti.com>
Subject: mmcqd seem to use lot of cpu cycles
Date: Tue, 1 Sep 2009 12:18:31 -0500
Message-ID: <001401ca2b28$3a99bac0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZIARSm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Sep 2009 13:18:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

While running one of the MMC use cases in the system I saw that mmcqd seems
to eat up a lot of cpu cycles. I saw a thread which discussed some details.

http://www.nabble.com/mmcqd-uses-a-large-amount-of-cpu-td23768078.html

Any clue on what this process is doing? If a low level driver is using DMA I
am not sure why there is so much load on the system due to mmcqd? Any
thoughts?

 
Regards,
Madhu

