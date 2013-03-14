From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 0/5] mmc: mxcmmc: add mpc512x support
Date: Thu, 14 Mar 2013 17:40:48 +0100
Message-ID: <1363279254-22351-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41892 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab3CNQlB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 12:41:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

The SDHC controller on mpc512x is compatible with i.MX31 SDHC
controller, the existing MMC host driver can be used on
mpc512x with some modifications, the patch series extends
the existing driver. It is based on the following mxcmmc DT
support patch:

 http://thread.gmane.org/gmane.linux.kernel.mmc/19401

The series has been tested on mpc5121e based board and
hasn't been tested on i.MX (only build tested using an
ARM toolchain). If anyone could test it i.e. on i.MX31,
I would really appreciate it. Thanks!

Anatolij Gustschin (5):
  mmc: mxcmmc: add mpc512x SDHC support
  mmc: mxcmmc: use slot-gpio API for write-protect detection
  mmc: mxcmmc: constify mxcmci_devtype and fix build warning
  mmc: mxcmmc: enable DMA support on mpc512x
  mmc: mxcmmc: fix race conditions for host->req and host->data access

 arch/powerpc/boot/dts/mpc5121.dtsi |    2 +
 drivers/mmc/host/Kconfig           |   10 +-
 drivers/mmc/host/mxcmmc.c          |  300 +++++++++++++++++++++++++++---------
 3 files changed, 233 insertions(+), 79 deletions(-)

-- 
1.7.5.4

