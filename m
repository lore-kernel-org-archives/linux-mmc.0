From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] mmc: Convert host drivers to mmc_send_tuning()
Date: Mon,  1 Dec 2014 17:02:06 +0100
Message-ID: <1417449730-5880-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:50432 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbaLAQCQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 11:02:16 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so8947776lbi.15
        for <linux-mmc@vger.kernel.org>; Mon, 01 Dec 2014 08:02:14 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

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

