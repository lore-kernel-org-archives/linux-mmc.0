From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/0] mmc: use capability for the broken voltage
Date: Tue, 31 Jan 2012 15:55:52 +0900
Message-ID: <4F279078.9090708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21229 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab2AaG4B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 01:56:01 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYN00MY4HX7QUC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:56:00 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYN008ZWHXBFN40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:55:59 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, m.szyprowski@samsung.com

This patch-set is supported the broken-voltage capability.

Jaehoon Chung (2):
  mmc: core: support broken voltage
  mmc: sdhci-s3c: support the broken voltage

 drivers/mmc/core/core.c      |    4 ++++
 drivers/mmc/host/sdhci-s3c.c |    7 +++----
 include/linux/mmc/host.h     |    1 +
 3 files changed, 8 insertions(+), 4 deletions(-)
