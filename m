From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 00/22] mmc: dw_mmc: add driver's updates
Date: Sat, 31 Aug 2013 00:10:55 +0900
Message-ID: <000301cea593$202711d0$60753570$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46099 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023Ab3H3PK5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:10:57 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC0009CNI3FUP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:10:56 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

This patch set includes updates of dw_mmc driver.

- Tuning scheme for high speed mode such as HS200.
- Support of HS200 mode in exynos host
- Involved some fixes and code clean-up


Doug Anderson (4):
      mmc: dw_mmc: don't queue up a card detect at slot startup
      mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
      mmc: dw_mmc: Honor requests to set the clock to 0
      mmc: dw_mmc: Set timeout to max upon resume

Seungwon Jeon (14):
      mmc: dw_mmc: add support tuning scheme
      mmc: dw_mmc: exynos: add variable delay tuning sequence
      mmc: dw_mmc: exynos: adjust the clock rate with speed mode
      mmc: dw_mmc: add the capability to support hs200 mode
      mmc: dw_mmc: move supports-highspeed of quirks to caps
      mmc: dw_mmc: set the supported max/min frequency
      mmc: dw_mmc: adjust the fifoth with block size
      mmc: dw_mmc: control card read threshold
      mmc: dw_mmc: fix error handling on response error
      mmc: dw_mmc: guarantee stop-abort cmd in data errors
      mmc: dw_mmc: rework the code related to cmd/data completion
      mmc: dw_mmc: gather each reset code into functions
      mmc: dw_mmc: amend use of idmac sw reset
      mmc: dw_mmc: fix the transfer termination in IDMAC mode

Yuvaraj Kumar C D (4):
      mmc: dw_mmc: exynos: move the exynos private init
      mmc: dw_mmc: socfpga: move socfpga private init
      mmc: dw_mmc: move the platform specific init call
      mmc: dw_mmc: exynos: configure SMU in exynos5420

.../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    9 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  294 +++++++++-
 drivers/mmc/host/dw_mmc-pltfm.c                    |    7 -
 drivers/mmc/host/dw_mmc-socfpga.c                  |   29 +-
 drivers/mmc/host/dw_mmc.c                          |  583 ++++++++++++++------
 drivers/mmc/host/dw_mmc.h                          |   55 ++
 include/linux/mmc/dw_mmc.h                         |    4 +
 7 files changed, 763 insertions(+), 218 deletions(-)

Thanks,
Seungwon Jeon

