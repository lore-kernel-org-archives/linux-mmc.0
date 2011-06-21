From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support for mx5
Date: Tue, 21 Jun 2011 22:41:47 +0800
Message-ID: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40062 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab1FUOc2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 10:32:28 -0400
Received: by iwn6 with SMTP id 6so2107825iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 07:32:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Philip Rakity <prakity@marvell.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The card-present polling for sdhci based driver is very expensive
in terms of the impact to system performance.  We observe a few
system performance issues from Freescale and Linaro on mx5 platforms,
which have been proved card polling related.

The patch set extends the current sdhci-esdhc-imx card_detect and
write_protect support to cover mx5 platforms, and solves above
performance issues.

Changes since v3:
 * Address comment from Philip Rakity on sdhci_set_card_detection
 * Change a couple of dev_warn to dev_err in sdhci-esdhc-imx.c per
   Arnaud Patard's comment
 * Add Arnaud Patard's Test-by
 * Add missing Acked-by, Cc stable on patch #2

Changes since v2:
 * Fix the issue reported by Arnaud Patard:
   http://article.gmane.org/gmane.linux.ports.arm.kernel/120790

Changes since v1:
 * Rebase on today's linux-next
 * Take the suggestion from Arnaud Patard to add default pdata in
   imx_add_sdhci_esdhc_imx(), to avoid touching every single board
   file for the platform_data changes
 * Add comment for sdhci.c change
 * Change ESDHC_CD(WP)_SIGNAL to ESDHC_CD(WP)_CONTROLLER for a more
   descriptive name
 * Add missing NONE case handling in esdhc_pltfm_get_ro
 * Improve a couple comment wording per suggestion from Wolfram Sang

Shawn Guo (4):
      mmc: sdhci: fix interrupt storm from card detection
      mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
      mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
      mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
 arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
 arch/arm/plat-mxc/include/mach/esdhc.h             |   25 +++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  140 ++++++++++++--------
 drivers/mmc/host/sdhci.c                           |   29 ++++-
 10 files changed, 165 insertions(+), 69 deletions(-)
