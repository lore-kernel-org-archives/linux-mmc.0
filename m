From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
Date: Wed, 3 Sep 2014 20:04:56 +0800
Message-ID: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:5160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932185AbaICM0k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Sep 2014 08:26:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

A few clean up and fixes.

Dong Aisheng (7):
  mmc: sdhci-esdhc-imx: remove duplicated lines
  mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt
    issue
  mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci: do not enable card cd wakeup for gpio case
  mmc: sdhci-esdhc-imx: add imx6sx support
  mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

 drivers/mmc/host/sdhci-esdhc-imx.c |   44 ++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.c           |    8 +++++-
 2 files changed, 41 insertions(+), 11 deletions(-)

-- 
1.7.8

