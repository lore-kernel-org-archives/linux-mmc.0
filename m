From: Hu Ziji <huziji@marvell.com>
Subject: [PATCH -next 0/2] Two issue fixes of Xenon SDHCI
Date: Fri, 28 Apr 2017 10:34:41 +0800
Message-ID: <cover.1493275841.git.huziji@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56213 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967136AbdD1Cgd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Apr 2017 22:36:33 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, dougj@marvell.com, jszhang@marvell.com, nadavh@marvell.com, ygao@marvell.com, xigu@marvell.com, liuw@marvell.com, dingwei@marvell.com, huziji@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, zjwu@marvell.com

Hi Ulf,

   Could you please help review the two fixes of Xenon SDHCI?
   Patch 1 fixes the remove flow of Xenon SDHCI.
   Patch 2 fixes a default value in PHY register.

   Thank you.

Best regards,
Hu Ziji

Hu Ziji (2):
  mmc: sdhci-xenon: Fix the work flow in xenon_remove().
  mmc: sdhci-xenon: Fix the default value of LOGIC_TIMING_ADJUST    
    register in eMMC 5.0 PHY

 drivers/mmc/host/sdhci-xenon-phy.c | 7 ++++++-
 drivers/mmc/host/sdhci-xenon.c     | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.7.4

