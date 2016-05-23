From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] dw-mmc controller fixes for v4.7
Date: Mon, 23 May 2016 11:03:58 +0900
Message-ID: <5742650E.4090702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41412 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcEWCEN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 May 2016 22:04:13 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O7L001Z8XQMUKB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 May 2016 11:03:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Jae hoon Chung <jh80.chung@gmail.com>

Dear Ulf,

Could you pull these patches into your "fixes" branch?

Best Regards,
Jaehoon Chung


The following changes since commit e5bbf30733f930a1d17b4ccf19eac88e30a39cc7:

  mmc: sdhci-acpi: Ensure connected devices are powered when probing (2016-05-20 16:00:25 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git fixes

for you to fetch changes up to a5cd9a42e6a952f7828742ec4595ed8312ac3063:

  mmc: dw_mmc: rockchip: Set the drive phase properly (2016-05-23 09:10:03 +0900)

----------------------------------------------------------------
Douglas Anderson (1):
      mmc: dw_mmc: rockchip: Set the drive phase properly

Jaehoon Chung (1):
      mmc: dw_mmc: fix the wrong max_blk_size

Shawn Lin (1):
      mmc: dw_mmc-rockchip: add MMC_CAP_CMD23 capabilities

 drivers/mmc/host/dw_mmc-rockchip.c | 72 +++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.c          |  6 ++--
 2 files changed, 71 insertions(+), 7 deletions(-)
