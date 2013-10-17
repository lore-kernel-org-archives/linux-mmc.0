From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Thu, 17 Oct 2013 15:19:43 +0800
Message-ID: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:57601
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751712Ab3JQHSy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 03:18:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

Changes since v1:
* Create flags only for features and errata such things, and keep using
  is_imx*_esdhc() for small register differences between esdhc variants.

Shawn Guo (4):
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
  mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
  mmc: sdhci-esdhc-imx: create struct esdhc_soc_data

 drivers/mmc/host/sdhci-esdhc-imx.c |  126 +++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 58 deletions(-)

-- 
1.7.9.5


