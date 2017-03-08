From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update DWMMC controller
Date: Wed, 08 Mar 2017 18:59:56 +0900
Message-ID: <e9fc24d7-69e5-6969-68b8-8168f7f1bf9a@samsung.com>
References: <CGME20170308095956epcas1p43c9c1eafc3739eef039ac3be59c7d5b1@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60181 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdCHKAA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Mar 2017 05:00:00 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OMH00GMLQFYF4E0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Mar 2017 18:59:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf,

Could you pull these patches into your next repository?

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 3f7f0fe4662f23d34cd741221842a45f253200ef:

  mmc: dw_mmc: improve dw_mci_reset a bit (2017-03-07 17:30:24 +0900)

----------------------------------------------------------------
Shawn Lin (7):
      mmc: dw_mmc: improve the timeout polling code
      mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
      mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
      mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
      mmc: dw_mmc: remove declaration of dw_mci_card_busy
      mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
      mmc: dw_mmc: improve dw_mci_reset a bit

 drivers/mmc/host/dw_mmc.c | 383 ++++++++++++++++++++++------------------------
 1 file changed, 182 insertions(+), 201 deletions(-)


Best Regards,
Jaehoon Chung
