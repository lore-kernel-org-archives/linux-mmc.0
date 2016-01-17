From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Sun, 17 Jan 2016 14:58:59 +0000
Message-ID: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52081 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbcAQPAO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jan 2016 10:00:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>

This patch series based on the suggestion of Scott Branden to implement
bcm2835 support into sdhci-iproc [1].

These changes provide the following advantages:
  * no need to maintain a separate driver for bcm2835
  * improve support and test coverage of bcm2835 mmc support
  * get the rid of SDHCI_CAPABILITIES hack in bcm2835_sdhci_readl
  * increase write performance by avoiding delays in write ops

Patch 1 and 2 adopt two sdhci-bcm2835 fixes to sdhci-iproc. The third patch
tries to specify as much quirks as possible in the bcm283x.dtsi as possible.
Patch 4 and 5 are the actually changes for bcm2835 support.

These series has been tested on Raspberry Pi B with dd (direct I/O):

sdhci-bcm2835

378 kB/s WRITE
10,6 MB/s READ

sdhci-iproc (after applying patch series)

881 kB/s WRITE
10,8 MB/s READ

[1] - https://lkml.org/lkml/2015/12/22/525

Stefan Wahren (5):
  mmc: sdhci-iproc: Clean up platform allocations if shdci init fails
  mmc: sdhci-iproc: Actually enable the clock
  ARM: bcm283x: specify sdhci quirks in dtsi file
  mmc: sdhci-iproc: add bcm2835 support
  DT: sdhci-iproc: add bcm2835 compatible

 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    5 ++-
 arch/arm/boot/dts/bcm283x.dtsi                     |    2 ++
 drivers/mmc/host/Kconfig                           |    6 ++--
 drivers/mmc/host/sdhci-iproc.c                     |   33 ++++++++++++++++++--
 4 files changed, 39 insertions(+), 7 deletions(-)

-- 
1.7.9.5

