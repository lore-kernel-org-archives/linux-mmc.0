From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 0/5] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller
Date: Fri,  4 Sep 2015 21:02:16 +0530
Message-ID: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33438 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024AbbIDPeo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2015 11:34:44 -0400
Received: by pacex6 with SMTP id ex6so27546740pac.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2015 08:34:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kliu5@marvell.com, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

PXA1928 SDHCI controller has few differences, for example,

                           PXAxxx                    PXA1928
                           ======                    =======
   SDCLK_DELAY field       0x10A                     0x114
   SDCLK_DELAY mask        0x1F                      0x3FF
   SDCLK_DELAY shift        9                          8
   SDCLK_SEL shift          8                          2 (SEL1)

So this patch series introduces new compatible device_id
(marvell,pxav3-1928-sdhci), and makes use of .data for handling
such differences.

The series also adds support like,

 - independent ->set_clock() api, as we need to enable internal clock gate
    and TX clock
 - pinctrl configuration based on bus speed.
 - introduce new quirk SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER
   SD_BUS_POWER & SD_BUS_VLT bit-fields are used internally to gate the
   clocks, so it is important to configure them as part of ->set_power()
   More detailed description is written into commit log.
 - Enable SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for PXA1928 device_id


Testing:
I have done basic testing on both eMMC and SD card on PXA1928 based
platform.

Note: I tried to made sure that I do not break any other platform, which
used sdhci, except HS200 configuration. 
Unfortunately I do not have access to any other datasheets, where I can
cross check the details on HS200 bit-fields. Probably someone who has
access can confirm [PATCH 4/5], whether it impacts other platforms.

Kevin Liu (1):
  mmc: sdhci-pxav3: Fix HS200 mode support

Vaibhav Hiremath (4):
  mmc: sdhci-pxav3: Enable pxa1928 device support
  mmc: sdhci-pxav3: Add platform specific set_clock ops
  mmc: sdhci-pxav3: Add pinctl setting according to bus clock
  mmc: sdhci: add new quirk for setting BUS_POWER & BUS_VLT fields

 drivers/mmc/host/sdhci-pltfm.c |   3 +
 drivers/mmc/host/sdhci-pxav3.c | 168 ++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.c       |   3 +-
 drivers/mmc/host/sdhci.h       |   2 +
 4 files changed, 163 insertions(+), 13 deletions(-)

-- 
1.9.1

