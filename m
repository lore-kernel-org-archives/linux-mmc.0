From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/4] align modalias with driver name for module auto-loading
Date: Thu, 14 May 2015 16:59:43 +0800
Message-ID: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34649 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbbENJAA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 05:00:00 -0400
Received: by pdbqa5 with SMTP id qa5so79754659pdb.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 02:00:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Zhangfei Gao (4):
  mmc: dw_mmc: k3: Fix modalias to make module auto-loading work
  mmc: dw_mmc: exynos: Fix modalias to make module auto-loading work
  mmc: dw_mmc: rockchip: Fix modalias to make module auto-loading work
  mmc: sdhci-st: Fix modalias to make module auto-loading work

 drivers/mmc/host/dw_mmc-exynos.c   | 2 +-
 drivers/mmc/host/dw_mmc-k3.c       | 2 +-
 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 drivers/mmc/host/sdhci-st.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1

