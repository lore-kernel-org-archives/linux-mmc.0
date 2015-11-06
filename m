From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V2 0/3] Add SDHCI driver for Broadcom BRCMSTB/BMIPS Soc's
Date: Fri, 6 Nov 2015 13:56:01 -0500
Message-ID: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:31448 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbKFS4p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 13:56:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

This patchset adds the SDHCI driver for the Broadcom BRCMSTB/BMIPS
Soc's. A few new Device Tree properties, needed by this driver,
were added to sdhci-pltfm.c to set various QUIRKS. The mmc.txt
bindings document was update with the both new and existing
properties handled by sdhci-pltfm.c

V2 - Don't create a new QUIRK to handle broken SDR50 mode in
     the controller. The functionality was moved into the
     sdhci-brcmstb driver.

Al Cooper (3):
  mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
  mmc: Add Device Tree binding supported by sdhci-pltfm.c
  mmc: sdhci-brcmstb: Add sdhci driver for Broadcom BRCMSTB/BMIPS SOCs

 Documentation/devicetree/bindings/mmc/mmc.txt      |   8 ++
 .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  36 +++++
 drivers/mmc/host/Kconfig                           |  12 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   | 158 +++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c                     |   8 +-
 6 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c

-- 
1.9.0.138.g2de3478

