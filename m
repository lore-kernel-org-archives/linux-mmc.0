From: Al Cooper <alcooperx@gmail.com>
Subject: [RESEND PATCH V5 0/2] Add SDHCI driver for Broadcom BRCMSTB/BMIPS Soc's
Date: Mon, 13 Jun 2016 08:18:58 -0400
Message-ID: <1465820340-16722-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36486 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049AbcFMMT3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 08:19:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so10594466pfd.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2016 05:19:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

V5 - Don't create new device tree properties to disable broken UHS
     modes. Use devm_clk_get() to get clk and change
     clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
V4 - Change the DT compatible property to "brcm,bcm7425-sdhci".
     Add "clocks" property to DT bindings document.
V3 - Don't add new QUIRKS to workaround Host Controller issues.
     It turns out that all the issues could be solved by using
     SDHCI_QUIRK_MISSING_CAPS to supply modified "caps" and "caps1"
     Host Controller registers.

Al Cooper (2):
  mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs
  mmc: DT: sdhci-brcmstb: Add device tree bindings

 .../devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt |  32 +++++
 MAINTAINERS                                        |   7 ++
 drivers/mmc/host/Kconfig                           |  11 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   | 137 +++++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c

-- 
1.9.0.138.g2de3478

