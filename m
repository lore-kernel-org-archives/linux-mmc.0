From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 0/2] Add SDHCI driver for Broadcom BRCMSTB/BMIPS Soc's
Date: Wed, 10 Feb 2016 15:25:38 -0500
Message-ID: <1455135940-29758-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:21661
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557AbcBJUa0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 15:30:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

V3 - Don't add new QUIRKS to workaround Host Controller issues.
     It turns out that all the issues could be solved by using
     SDHCI_QUIRK_MISSING_CAPS to supply modified "caps" and "caps1"
     Host Controller registers.

Al Cooper (2):
  mmc: sdhci: Allow CAPS check for SDHCI_CAN_64BIT to use overridden
    caps
  mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs

 .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  40 ++++++
 MAINTAINERS                                        |   7 +
 drivers/mmc/host/Kconfig                           |  11 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   | 154 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   2 +-
 6 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c

-- 
1.9.0.138.g2de3478

