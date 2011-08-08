From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH 0/2] eMMC v4.5 feature supports
Date: Mon, 08 Aug 2011 11:11:13 +0900
Message-ID: <20110808021113.GA20317@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22645 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1HHCLT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Aug 2011 22:11:19 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LPL00LWJ7EFLLF0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 11:11:18 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LPL009RF7EURQ@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 11:11:18 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com, arnd@arndb.de

New feature, discard and sanitize supports

See the detail information at each patch

Kyungmin Park (2):
  mmc: core: new discard feature support at mmc v4.5
  mmc: core: mmc sanitize feature support for v4.5

 drivers/mmc/card/block.c |   13 +++++++++++--
 drivers/mmc/card/queue.c |    2 +-
 drivers/mmc/core/core.c  |   22 ++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |    4 ++++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/core.h |    3 +++
 include/linux/mmc/mmc.h  |    2 ++
 7 files changed, 46 insertions(+), 3 deletions(-)

-- 
1.7.5.1.300.gc565c

