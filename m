From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Wed, 14 Mar 2012 14:19:58 +0000
Message-ID: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51832 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2CNOUI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 10:20:08 -0400
Received: by wejx9 with SMTP id x9so1729015wej.19
        for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 07:20:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

This patch-set splits out ux500 and ARM specific variants from mmci
core code, applies generic bindings for use by all variants, then 
enables the ux500 variant for use with Device Tree.

 Documentation/devicetree/bindings/mmc/mmci.txt |   27 +++
 arch/arm/boot/dts/db8500.dtsi                  |    6 +-
 arch/arm/boot/dts/snowball.dts                 |   30 +++-
 arch/arm/mach-ux500/board-mop500.c             |    3 +-
 drivers/mmc/host/Makefile                      |    2 +-
 drivers/mmc/host/mmci-arm.c                    |   65 ++++++
 drivers/mmc/host/mmci-ux500.c                  |  260 ++++++++++++++++++++++++
 drivers/mmc/host/mmci.c                        |  194 +++++-------------
 drivers/mmc/host/mmci.h                        |   37 ++++
 9 files changed, 473 insertions(+), 151 deletions(-)

