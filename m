From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/4] mmc: Convert host drivers to mmc_send_tuning()
Date: Fri,  5 Dec 2014 12:59:39 +0100
Message-ID: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38483 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbaLEL7v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 06:59:51 -0500
Received: by mail-lb0-f171.google.com with SMTP id n15so416809lbi.30
        for <linux-mmc@vger.kernel.org>; Fri, 05 Dec 2014 03:59:49 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

Changes in v2:
	Rebased on latest next branch, which means the mmc_send_tuning() has
	changed to take the struct mmc_host as parameter instead of the struct
	mmc_card.


Due to commit "mmc: core: add core-level function for sending tuning commands",
the mmc core provides an API to send the tuning command and as well compare the
response pattern.

Convert those host drivers which implemented their own version for how to deal
with this, into using the new API.

Note, this patchset has currently only been compile tested. Any help in testing
on HW is higly appreciated.


Ulf Hansson (4):
  mmc: sdhci-esdhc-imx: Convert to mmc_send_tuning()
  mmc: sdhci-msm: Convert to mmc_send_tuning()
  mmc: dw_mmc: Convert to mmc_send_tuning()
  mmc: core: Make tuning block patterns static

 drivers/mmc/core/mmc.c             | 32 ------------------
 drivers/mmc/core/mmc_ops.c         | 30 +++++++++++++++++
 drivers/mmc/host/dw_mmc-exynos.c   | 49 +++------------------------
 drivers/mmc/host/dw_mmc.c          | 22 +-----------
 drivers/mmc/host/dw_mmc.h          |  8 +----
 drivers/mmc/host/sdhci-esdhc-imx.c | 68 ++------------------------------------
 drivers/mmc/host/sdhci-msm.c       | 50 ++++------------------------
 include/linux/mmc/mmc.h            |  5 ---
 8 files changed, 46 insertions(+), 218 deletions(-)

-- 
1.9.1

