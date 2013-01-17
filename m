From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] MAINTAINERS: mmc: add maintainer entry for dw_mmc driver
Date: Thu, 17 Jan 2013 21:33:23 +0900
Message-ID: <000c01cdf4ae$d77888a0$866999e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30770 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab3AQMdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 07:33:25 -0500
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'open list' <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, jh80.chung@samsung.com, 'Will Newton' <will.newton@gmail.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

Add maintainer entry for the Synopsys DW host driver which
is used in various SOC including EXYNOS series.
As Will Newton will no longer be able to take care of dw_mmc*,
I and Jaehoon Chung are willing to maintain it.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 943a607..2b7beac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6777,6 +6777,14 @@ F:	include/linux/dw_dmac.h
 F:	drivers/dma/dw_dmac_regs.h
 F:	drivers/dma/dw_dmac.c
 
+SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
+M:	Seungwon Jeon <tgih.jun@samsung.com>
+M:	Jaehoon Chung <jh80.chung@samsung.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	include/linux/mmc/dw_mmc.h
+F:	drivers/mmc/host/dw_mmc*
+
 TIMEKEEPING, NTP
 M:	John Stultz <johnstul@us.ibm.com>
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
1.7.0.4


