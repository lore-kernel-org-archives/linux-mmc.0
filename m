From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update DWMMC controller
Date: Fri, 18 Aug 2017 14:48:21 +0900
Message-ID: <36f44627-123c-d6f3-41e4-f09892895cfa@samsung.com>
References: <CGME20170818054821epcas2p4dd5a5a393c47c644d09d6b29747aeb0d@epcas2p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33112 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRFsX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Aug 2017 01:48:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Dear Ulf,

Could you pull these patches to next branch?
If there is any issue, let me know, plz.

The following changes since commit 7bb2a5d1342fcba2e32406fdb1e4c3d501ec6782:

  Merge branch 'fixes' into next (2017-08-09 13:22:47 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 024d4a5a8a89f247d36fd36a2f61f53bf8eae586:

  mmc: dw_mmc: introduce timer for broken command transfer over scheme (2017-08-18 14:44:40 +0900)

----------------------------------------------------------------
Addy Ke (1):
      mmc: dw_mmc: introduce timer for broken command transfer over scheme

liwei (2):
      mmc: dw_mmc: move controller reset before driver init
      mmc: dw_mmc-k3: add sd support for hi3660

 drivers/mmc/host/dw_mmc-k3.c | 298 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c    |  60 ++++++++-
 drivers/mmc/host/dw_mmc.h    |   4 +
 3 files changed, 356 insertions(+), 6 deletions(-)

Best Regards,
Jaehoon Chung
