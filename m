From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Thu, 22 Sep 2016 19:57:32 +0900
Message-ID: <772c300d-7d81-d933-f9c5-401cb3a3afcb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58503 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbcIVK5e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 06:57:34 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0ODW02R59JRWX8D0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2016 19:57:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf,

Could you pull these patches into your mmc-next?

The following changes since commit 6739115d4d319ba83d52f89e66b6a86cc021a2b5:

  mmc: core: don't try to switch block size for dual rate mode (2016-09-22 10:17:54 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 2d25506534aec8a2e0980bf04b3e72b5b3c9f830:

  mmc: dw_mmc: remove the deprecated "supports-highspeed" property (2016-09-22 19:53:38 +0900)

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: remove the deprecated "supports-highspeed" property

Shawn Lin (5):
      mmc: dw_mmc: split out preparation of desc for IDMAC32 and IDMAC64
      mmc: dw_mmc: avoid race condition of cpu and IDMAC
      mmc: dw_mmc: fix misleading error print if failing to do DMA transfer
      mmc: dw_mmc: use macro to define ring buffer size
      mmc: dw_mmc: minor cleanup for dw_mci_adjust_fifoth

 drivers/mmc/host/dw_mmc.c | 346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------
 1 file changed, 202 insertions(+), 144 deletions(-)


Best Regards,
Jaehoon Chung
