From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 0/1] mmc: sdhci-s3c: Use mmc_gpio_request_cd function
Date: Wed, 11 Dec 2013 14:51:24 +0900
Message-ID: <52A7FD5C.80408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61061 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3LKFvb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:51:31 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXM004J5O9OYY10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 Dec 2013 14:51:24 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

Hello,

I have fixed patch.

Change from v2 to v1
	- Fix "err_req_cd:".
	- Remove mmc_gpio_free_cd() and then, use sdhci_remove_host()

Beomho Seo (1):
  mmc: sdhci-s3c: Use mmc_gpio_request_cd function

 drivers/mmc/host/sdhci-s3c.c |   56 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

-- 
1.7.9.5

-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., Software Center, Samsung Electronics
