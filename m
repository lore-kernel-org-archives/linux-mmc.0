From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Mon, 14 Oct 2013 16:23:39 +0800
Message-ID: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:20782
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab3JNIXO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 04:23:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

When I was reviewing Dong's imx6sl standard tuning patches, I found that
it's a little clumsy to use enum imx_esdhc_type for handling features
and quirks on different esdhc variants.  Instead, the approach used in
fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
scalable in the long run.  It defines flags for all those features and
quirks and creates a mapping between esdhc variant and the flags.

Actually, sdhci-esdhc-imx driver already has one such flag, i.e.
ESDHC_FLAG_MULTIBLK_NO_INT, but there is currently an unnecessary
translation between the flag and imx_esdhc_type.  The series creates
another 3 flags and identify features/quirks using these flags and then
eliminate enum imx_esdhc_type completely.

Shawn Guo (5):
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_NO_DMAS_BITS
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
  mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
  mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type

 drivers/mmc/host/sdhci-esdhc-imx.c |  108 +++++++++++++++---------------------
 1 file changed, 45 insertions(+), 63 deletions(-)

-- 
1.7.9.5


