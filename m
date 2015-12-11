From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Update dw-mmc controller
Date: Fri, 11 Dec 2015 13:57:00 +0900
Message-ID: <566A579C.4000104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60152 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbLKE5F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2015 23:57:05 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZ600EEGGF2VR60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 11 Dec 2015 13:57:02 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>

Dear, Ulf

Could you pull this patch on your repository? Sorry for late.
Also I will send the some patches at mailing on this weekend..

Best Regards,
Jaehoon Chung

The following changes since commit 5acbb99e3883a0353609bfefd02c056cc92d1a9d:

  mmc: core: fix __mmc_switch timeout caused by preempt (2015-12-04 15:43:18 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 007230a6b5841b1e5a3f1a46d97ee6e8343879f3:

  mmc: dw_mmc: use resource_size_t to store physical address (2015-12-09 22:35:52 +0900)

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: dw_mmc: use resource_size_t to store physical address

 drivers/mmc/host/dw_mmc-pltfm.c | 2 +-
 drivers/mmc/host/dw_mmc.c       | 2 +-
 include/linux/mmc/dw_mmc.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
