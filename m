From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/8] mmc: sdhci/imx: a few clean up and fixes
Date: Mon, 22 Sep 2014 17:12:03 +0800
Message-ID: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0133.outbound.protection.outlook.com ([65.55.169.133]:36264
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751350AbaIVJkH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 05:40:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

Change since v1:
  Add patch 6 which resolves a checkpatch warning like below in v1:
0005-mmc-sdhci-do-not-enable-card-cd-wakeup-for-gpio-case.patch has no obvious style problems and is ready for submission.
WARNING: DT compatible string "fsl,imx6sx-usdhc" appears un-documented -- check ./Documentation/devicetree/bindings/
+       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },

total: 0 errors, 1 warnings, 18 lines checked

Dong Aisheng (8):
  mmc: sdhci-esdhc-imx: remove duplicated lines
  mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt
    issue
  mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci: do not enable card cd wakeup for gpio case
  mmc: sdhci-esdhc-imx: using specific compatible string in binding doc
  mmc: sdhci-esdhc-imx: add imx6sx support
  mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    9 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   44 ++++++++++++++++----
 drivers/mmc/host/sdhci.c                           |    8 +++-
 3 files changed, 49 insertions(+), 12 deletions(-)

-- 
1.7.8

