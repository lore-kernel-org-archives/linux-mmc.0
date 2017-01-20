From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/3] mmc: sdhci-s3c: remove s3c specific header file
Date: Fri, 20 Jan 2017 18:50:01 +0900
Message-ID: <20170120095004.14509-1-jh80.chung@samsung.com>
References: <CGME20170120095012epcas5p463695278b6bd5d934c5af9cc26d09f03@epcas5p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38293 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdATKBb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 05:01:31 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK202M7VONOXB40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 18:50:12 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>


Remove the s3c specific header file.
Ther is no reason to keep the s3c-sdhci-reg header file.
It can be located into sdhci-s3c.c.

It's more easier to maintain the sdhci-s3c file.

Jaehoon Chung (3):
  mmc: sdhci-s3c: remove the sdhci-s3c-regs header file
  mmc: sdhci-s3c: remove the unnecessary defined values
  mmc: sdhci-s3c: use the bitops API for bit operation

 drivers/mmc/host/sdhci-s3c-regs.h | 87 ---------------------------------------
 drivers/mmc/host/sdhci-s3c.c      | 24 ++++++++++-
 2 files changed, 23 insertions(+), 88 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-s3c-regs.h

-- 
2.10.2

