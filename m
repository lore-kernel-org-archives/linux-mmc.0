From: Tony Prisk <linux@prisktech.co.nz>
Subject: [RFC PATCH 0/2] MMC: Add support for Wondermedia SoC SDHC
Date: Mon, 15 Oct 2012 21:24:51 +1300
Message-ID: <1350289493-30533-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:60099 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2JOIdd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 04:33:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tony Prisk <linux@prisktech.co.nz>

This patchset adds support for the Wondermedia 8xxx-series SD Host
Controller currently found under arm/arch-vt8500.

Tony Prisk (2):
  MMC: DTS: Add binding for Wondermedia WM8505 SDHC
  MMC: SD/MMC Host Controller for Wondermedia WM8505/WM8650

 .../devicetree/bindings/mmc/vt8500-sdmmc.txt       |   24 +
 drivers/mmc/host/Kconfig                           |   12 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/wmt-sdmmc.c                       |  983 ++++++++++++++++++++
 4 files changed, 1020 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
 create mode 100644 drivers/mmc/host/wmt-sdmmc.c

-- 
1.7.9.5

