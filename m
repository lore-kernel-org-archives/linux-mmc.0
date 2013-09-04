From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 0/8] mmc: sdhci-esdhc-imx: add SD3.0 support
Date: Wed, 4 Sep 2013 20:54:09 +0800
Message-ID: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:53889 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab3IDNBQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 09:01:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, anton@enomsg.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, b29396@freescale.com

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

Dong Aisheng (8):
  mmc: sdhci: add hooks for platform specific tuning
  mmc: sdhci: allow platform access of sdhci_send_command
  sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
  sdhci: sdhci-esdhci-imx: add sd3.0 clock tuning support
  sdhci: sdhci-esdhc-imx: change pinctrl state according to uhs mode
  mmc: sdhci-esdhc: correct pre_div for imx6q
  mmc: sdhci-esdhc: set actual_clock in clock setting
  ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3

 arch/arm/boot/dts/imx6dl.dtsi               |   33 +++
 arch/arm/boot/dts/imx6q.dtsi                |   33 +++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |    4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c          |  307 ++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h              |   35 +++-
 drivers/mmc/host/sdhci.c                    |   12 +-
 drivers/mmc/host/sdhci.h                    |    3 +
 include/linux/platform_data/mmc-esdhc-imx.h |    4 +
 8 files changed, 419 insertions(+), 12 deletions(-)


