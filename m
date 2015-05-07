From: Jaehoon Chung <jh80.chung@gmail.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Thu, 07 May 2015 17:37:37 +0900
Message-ID: <554B2451.7020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35398 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEGIhn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2015 04:37:43 -0400
Received: by pabtp1 with SMTP id tp1so34227827pab.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 01:37:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, zhangfei <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

Dear, Ulf.

Could you pull dw-mmc controller patches for v4.2-rc3?

Best Regards,
Jaehoon Chung

The following changes since commit 75f65952d431aee8b97a20a9df2de1341ca8da01:

  Merge branch 'fixes' into next (2015-05-06 14:56:06 +0200)

are available in the git repository at:


  https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-v4.1-rc3-for-ulf

for you to fetch changes up to 6df66485e62467487ea885c9697df3a3ee22c86f:

  mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE (2015-05-07 16:32:58 +0900)

----------------------------------------------------------------
dw-mmc-v.4.1-rc3-for-ulf

----------------------------------------------------------------
Zhangfei Gao (2):
      mmc: dw_mmc: init desc in dw_mci_idmac_init
      mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE

 drivers/mmc/host/dw_mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
