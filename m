From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] MMC: use mmc_of_parse in sdhci-esdhc-imx
Date: Fri, 23 May 2014 14:32:59 +0200
Message-ID: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43503 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaEWMdI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 08:33:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

The following series changes the sdhci-esdhc-imx to use mmc_of_parse
to profit from the generic devicetree parser. Unfortunately this
is not straight forward because the driver parses all devicetree
data into platform_data instead of directly into the mmc host, so
we have to refactor the parsing and move platform_data parsing out
of the way for the devicetree path first.

The last patch fixes the card/write protection for the babbage board
and can be taken independently of the rest by Shawn.

Sascha

----------------------------------------------------------------
Sascha Hauer (5):
      mmc: sdhci-esdhc-imx: add f_max field to private data
      mmc: sdhci-esdhc-imx: introduce function for parsing platform_data
      mmc: sdhci-esdhc-imx: straighten SDHCI_QUIRK_BROKEN_CARD_DETECTION flag
      mmc: sdhci-esdhc-imx: use mmc_of_parse
      ARM: dts: imx51-babbage: Fix esdhc setup

 arch/arm/boot/dts/imx51-babbage.dts |  14 +--
 drivers/mmc/host/sdhci-esdhc-imx.c  | 205 +++++++++++++++++++-----------------
 2 files changed, 118 insertions(+), 101 deletions(-)
