From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 0/2] mmc: host: sdhci-s3c: Add support for pinctrl interface
Date: Tue, 13 Nov 2012 11:30:17 +0100
Message-ID: <1352802619-29547-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11509 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2KMKab (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 05:30:31 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDF007VX96LAN50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:29 +0900 (KST)
Received: from mcdsrvbld02.digital.local ([106.116.37.23])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDF0004096MWE80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Nov 2012 19:30:29 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

This series intends to add support for pin configuration using pin control
interface.

First patch cleans up GPIO requesting and freeing in the driver to simplify
adding pin control support.

Second patch adds pin control support to the driver.

Tomasz Figa (2):
  mmc: host: sdhci-s3c: Use devm_gpio_request to request GPIOs
  mmc: host: sdhci-s3c: Add support for pinctrl

 .../devicetree/bindings/mmc/samsung-sdhci.txt      | 20 ++++++---
 drivers/mmc/host/sdhci-s3c.c                       | 50 ++++++++--------------
 2 files changed, 31 insertions(+), 39 deletions(-)

-- 
1.8.0

