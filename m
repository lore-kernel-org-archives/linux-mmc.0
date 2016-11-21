From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] dw-mmc controller fixes
Date: Mon, 21 Nov 2016 13:28:22 +0900
Message-ID: <d43a35c0-0961-ccc6-70ad-0b9b0f0ce2eb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60343 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbcKUE2a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2016 23:28:30 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGZ011I25R3VH40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Nov 2016 13:28:22 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Dear Ulf,

Could you pull this patch into your "fixes" branch?
Before applied this patch, there is the potential lock issue.

Best Regards,
Jaehoon Chung


The following changes since commit b0921d5c9ed6ffa8a4d6afc5ee5f136b87445f14:

  mmc: sdhci-of-esdhc: fixup PRESENT_STATE read (2016-11-18 14:41:47 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git fixes

for you to fetch changes up to 93fad54b87ace925631d8a09de6e0ac7d26af96d:

  mmc: dw_mmc: fix the error handling for dma operation (2016-11-21 13:21:38 +0900)

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: fix the error handling for dma operation

 drivers/mmc/host/dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)
