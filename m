From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 0/2] mmc:dw_mmc: Enable dw_mmc support for Exynos5420
Date: Fri, 24 May 2013 15:34:31 +0530
Message-ID: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62991 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760324Ab3EXKFE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 06:05:04 -0400
Received: by mail-pa0-f44.google.com with SMTP id wp1so1507198pac.31
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2013 03:05:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, thomas.ab@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Exynos5420 has a new DW MMC controller which supports MMC5.1 specification.
Below patches will add the necessary infrastructure to use dw_mmc driver
on SMDK5420 board.

Yuvaraj Kumar C D (2):
 mmc: dw_mmc: exynos: Add a new compatible string for exynos5420
 mmc: dw_mmc: add a quirk for Security Management Unit

 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    2 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   44 +++++++++++++++++++-
 drivers/mmc/host/dw_mmc.c                          |   10 +++++
 drivers/mmc/host/dw_mmc.h                          |    2 +
 include/linux/mmc/dw_mmc.h                         |    2 +
 5 files changed, 59 insertions(+), 1 deletion(-)

-- 
1.7.9.5

