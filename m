From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 0/5] mmc: mxcmmc: add mpc512x support
Date: Mon,  8 Apr 2013 23:28:04 +0200
Message-ID: <1365456489-13152-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37942 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009Ab3DHV20 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 17:28:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Anatolij Gustschin <agust@denx.de>

The SDHC controller on mpc512x is compatible with i.MX31 SDHC
controller, the existing MMC host driver can be used on
mpc512x with some modifications, the patch series extends
the existing driver. It is based on the following v3 mxcmmc DT
support patch:

   https://patchwork.kernel.org/patch/2368631

Changes in v3 series are mentioned in each patch

Anatolij Gustschin (5):
  mmc: mxcmmc: fix race conditions for host->req and host->data access
  mmc: mxcmmc: add mpc512x SDHC support
  mmc: mxcmmc: use slot-gpio API for write-protect detection
  mmc: mxcmmc: constify mxcmci_devtype
  mmc: mxcmmc: enable DMA support on mpc512x

 arch/powerpc/boot/dts/mpc5121.dtsi |    2 +
 drivers/mmc/host/Kconfig           |   10 +-
 drivers/mmc/host/mxcmmc.c          |  209 ++++++++++++++++++++++++++----------
 3 files changed, 159 insertions(+), 62 deletions(-)

-- 
1.7.5.4

