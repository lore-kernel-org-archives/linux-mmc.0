From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] mmc: sdhci-s3c: remove s3c specific header file
Date: Tue, 24 Jan 2017 18:27:26 +0900
Message-ID: <20170124092728.19874-1-jh80.chung@samsung.com>
References: <CGME20170124092731epcas5p2b0a67832a61f7debbd65ca1d3dab36aa@epcas5p2.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33552 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdAXJ1n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 04:27:43 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKA022L429WH830@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 24 Jan 2017 18:27:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

Remove the s3c specific header file.
Ther is no reason to keep the s3c-sdhci-reg header file.
It can be located into sdhci-s3c.c.

It's more easier to maintain the sdhci-s3c file.

Changelog on V2:
- Remove "PATCH[2/3] mmc: sdhci-s3c: remove unnecessary defined value"
- Keep the unused defined value

Jaehoon Chung (2):
  mmc: sdhci-s3c: remove the sdhci-s3c-regs header file
  mmc: sdhci-s3c: use the bitops API for bit operation

 drivers/mmc/host/sdhci-s3c-regs.h | 87 ---------------------------------------
 drivers/mmc/host/sdhci-s3c.c      | 71 +++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 88 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-s3c-regs.h

-- 
2.10.2

