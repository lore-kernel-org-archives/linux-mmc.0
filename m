From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v2 0/4] mmc: imx: a few fixes and add a new feature
Date: Tue, 23 Jun 2015 19:47:59 +0800
Message-ID: <1435060083-2606-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0110.outbound.protection.outlook.com ([207.46.100.110]:46056
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754134AbbFWLpV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Jun 2015 07:45:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, aisheng.dong@freescale.com, fabio.estevam@freescale.com, shawn.guo@linaro.org, eric.nelson@boundarydevices.com, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, haibo.chen@freescale.com

Patch 1 add imx7d support, and also add HS400 mode support.
Patch 2 add tuning-step, which can be get from dts.
Patch 3 and Patch 4 do some small fixes.

Haibo Chen (4):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  mmc: sdhci-esdhc-imx: config watermark level and burst length
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1

 drivers/mmc/host/sdhci-esdhc-imx.c          | 97 ++++++++++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |  1 +
 2 files changed, 97 insertions(+), 1 deletion(-)

-- 
1.9.1

