From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/9] mmc: sdhci-esdhc-imx: add SD3.0 support
Date: Fri, 13 Sep 2013 19:11:29 +0800
Message-ID: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.253] ([213.199.154.253]:24894 "EHLO
	db9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418Ab3IMLVG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

This patch series add SD3.0 support for i.MX6Q/DL.
Since freescale i.MX6Q/DL uSDHC clock tuning progress is a little different from
the standard tuning process defined in host controller spec v3.0.
So we add a hook to allow execute platform specific tuning instead of
standard host controller tuning.

The main difference are:
1) not only generate Buffer Read Ready interrupt when tuning is performing.
It generates all other DATA interrupts like the normal data command.
2) SDHCI_CTRL_EXEC_TUNING is not automatically cleared by HW,
instead it's controlled by SW.
3) SDHCI_CTRL_TUNED_CLK is not automatically set by HW,
it's controlled by SW.
4) the clock delay for every tuning is set by SW.

Tested on i.MX6Q Sabreauto board.

The series is based on latest Linus tree.

ChangeLog since v1:
* some minor changes made by addressing Shawn's comments
* move esdhc_set_clock shared by imx and powerpc to each platform driver
since it's not much common anymore based on Shawn's suggestion.
* dts pinctrl group name changed according to Sascha's suggestion and
rebased on latest tree.

Dong Aisheng (9):
  mmc: sdhci: add hooks for platform specific tuning
  mmc: sdhci: allow platform access of sdhci_send_command
  mmc: sdhci-esdhci: move common esdhc_set_clock to platform driver
  sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
  sdhci: sdhci-esdhci-imx: add sd3.0 clock tuning support
  sdhci: sdhci-esdhc-imx: change pinctrl state according to uhs mode
  mmc: sdhci-esdhc-imx: correct pre_div for imx6q
  mmc: sdhci-esdhc-imx: set actual_clock in clock setting
  ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3

 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |    5 +-
 arch/arm/boot/dts/imx6qdl.dtsi              |   30 +++
 drivers/mmc/host/sdhci-esdhc-imx.c          |  344 ++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h              |   37 ---
 drivers/mmc/host/sdhci-of-esdhc.c           |   35 +++-
 drivers/mmc/host/sdhci.c                    |   12 +-
 drivers/mmc/host/sdhci.h                    |    3 +
 include/linux/platform_data/mmc-esdhc-imx.h |    4 +
 8 files changed, 425 insertions(+), 45 deletions(-)


