From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] DWMMC controller for next
Date: Wed, 30 Nov 2016 10:39:34 +0900
Message-ID: <657025e2-decd-338e-60e9-f7ebfc7fcbb4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49336 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbcK3Bjg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 20:39:36 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHF00RNCLXYJHB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2016 10:39:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

Dear Ulf,

Could you pull these patches for next on your repository?

The following changes since commit b977a3400ee697f80e128e8bb927652026e400da:

  mmc: mmc_test: remove BUG_ONs and deploy error handling (2016-11-29 13:40:22 +0100)

are available in the git repository at:

  http://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to dc595736c5549b82d02fb4217cf68be595e479be:

  mmc: dw_mmc: display the clock message only one time when card is polling (2016-11-30 10:36:33 +0900)

----------------------------------------------------------------
Jaehoon Chung (3):
      mmc: dw_mmc: check the "present" variable before checking flags
      mmc: dw_mmc: add the debug message for polling and non-removable
      mmc: dw_mmc: display the clock message only one time when card is polling

Joonyoung Shim (2):
      mmc: dw_mmc: exynos: fix to call suspend callback
      mmc: dw_mmc: add missing codes for runtime resume

 drivers/mmc/host/dw_mmc-exynos.c | 28 ++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.c        | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/dw_mmc.h        |  1 +
 3 files changed, 72 insertions(+), 7 deletions(-)

Best Regards,
Jaehoon Chung
