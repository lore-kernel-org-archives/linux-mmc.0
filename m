From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/2] mmc: remove sdhci-bcm2835
Date: Fri,  3 Jun 2016 19:47:11 +0000
Message-ID: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:49760 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbcFCTsM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 15:48:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

The sdhci-bcm2835 is no more needed since it has been replaced
by sdhci-iproc.

Stefan Wahren (2):
  DT: bindings: remove bcm2835-sdhci
  mmc: sdhci-bcm2835: remove driver

 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |   18 --
 drivers/mmc/host/Kconfig                           |   11 --
 drivers/mmc/host/Makefile                          |    1 -
 drivers/mmc/host/sdhci-bcm2835.c                   |  204 --------------------
 4 files changed, 234 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
 delete mode 100644 drivers/mmc/host/sdhci-bcm2835.c

-- 
1.7.9.5

