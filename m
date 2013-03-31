From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 0/5] mmc: mxcmmc: add mpc512x support
Date: Mon,  1 Apr 2013 00:23:00 +0200
Message-ID: <1364768585-5177-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53973 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab3CaWXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Mar 2013 18:23:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

The SDHC controller on mpc512x is compatible with i.MX31 SDHC
controller, the existing MMC host driver can be used on
mpc512x with some modifications, the patch series extends
the existing driver. It is based on the following v3 mxcmmc DT
support patch:

   https://patchwork.kernel.org/patch/2368631

Changes in v2 series are mentioned in each patch

Anatolij Gustschin (5):
  mmc: mxcmmc: add mpc512x SDHC support
  mmc: mxcmmc: use slot-gpio API for write-protect detection
  mmc: mxcmmc: constify mxcmci_devtype
  mmc: mxcmmc: enable DMA support on mpc512x
  mmc: mxcmmc: fix race conditions for host->req and host->data access

 arch/powerpc/boot/dts/mpc5121.dtsi |    2 +
 drivers/mmc/host/Kconfig           |   10 +-
 drivers/mmc/host/mxcmmc.c          |  209 ++++++++++++++++++++++++++----------
 3 files changed, 159 insertions(+), 62 deletions(-)

-- 
1.7.5.4

