From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 00/14] mmc: dw_mmc: add driver's updates
Date: Wed, 21 Aug 2013 22:49:01 +0900
Message-ID: <002501ce9e75$318253b0$9486fb10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12444 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab3HUNtD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:49:03 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV009KJVPNTOC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:49:02 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

This patch set includes the tuning scheme for high speed mode such as HS200.
Specially, the support of HS200 mode is introduced with exynos's host
And also, it addresses the some error handling and code clean-up.

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

 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    9 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  168 ++++++-
 drivers/mmc/host/dw_mmc.c                          |  523 ++++++++++++++------
 drivers/mmc/host/dw_mmc.h                          |   50 ++
 include/linux/mmc/dw_mmc.h                         |    4 +
 5 files changed, 597 insertions(+), 157 deletions(-)


Thanks,
Seungwon Jeon

