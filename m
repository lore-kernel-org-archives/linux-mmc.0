From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] DWMMC controller fixes
Date: Thu, 03 Nov 2016 14:25:58 +0900
Message-ID: <587f4226-0c21-899b-b16d-3f33d092e382@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57630 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcKCF0D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 01:26:03 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OG1020KSWFASN60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 03 Nov 2016 14:25:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Dear Ulf,

Could you pull these patches on your fixes branch?

The following changes since commit d1f63f0c81c22ba705fcd149a1fcec37b734d818:

  mmc: sdhci-msm: Fix error return code in sdhci_msm_probe() (2016-10-27 09:43:01 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git fixes

for you to fetch changes up to 5c3d7c7ed1e676d7fa1c9222d9a46c5d09b9fe97:

  mmc: dw_mmc: add the "reset" as name of reset controller (2016-11-03 14:11:59 +0900)

----------------------------------------------------------------
DWMMC core:
- Add the "reset" as "#reset-names" property for preventing wrong operation.

----------------------------------------------------------------
Jaehoon Chung (2):
      Documentation: synopsys-dw-mshc: add binding for reset-names
      mmc: dw_mmc: add the "reset" as name of reset controller

 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 +++++
 drivers/mmc/host/dw_mmc.c                                  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)


Best Regards,
Jaehoon Chung
