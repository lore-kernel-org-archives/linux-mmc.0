From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 0/5] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Tue, 11 Apr 2017 13:10:26 +0800
Message-ID: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:18176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752179AbdDKFZN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 01:25:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

It's complicated to support SD UHS-I and eMMC HS200 for eSDHC because
there're many differences between eSDHC and SD/eMMC spec. Several
differences as below must be considered:
1. Peripheral clock must be used instead of platform clock.
    - eSDHC could select peripheral clock or platform clock as its clock
      source. According to RM, UHS-I/HS200 must use peripheral clock since
      it supports higher frequency than platform clock.
    - Patch 1 is to support this.
2. Signal voltage switching requires a control circuit out of eSDHC.
    - eSDHC supports signal voltage switch from 3.3v to 1.8v by
      eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
      signal SDHC_VS, and there must be a control circuit out of eSDHC
      to change the signal voltage according to SDHC_VS output signal.
    - Patch 2 is to support this.
3. eSDHC uses tuning block for tuning procedure.
    - Tuning clock control register must be configured before tuning.
    - Patch 3 is to support this.
4. Delay is needed between tuning cycles for HS200 tuning.
    - Once a patch removed mdelay between tuning cycles.
      But eSDHC needs it.
    - Patch 4 and patch 5 is to support this.


Adrian Hunter (1):
  mmc: sdhci: Control the delay between tuning commands

Yangbo Lu (4):
  mmc: sdhci-of-esdhc: add peripheral clock support
  mmc: sdhci-of-esdhc: add support for signal voltage switch
  mmc: sdhci-of-esdhc: add tuning support
  mmc: sdhci-of-esdhc: add delay between tuning cycles

 drivers/mmc/host/sdhci-esdhc.h    |   7 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 167 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c          |  11 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 4 files changed, 182 insertions(+), 5 deletions(-)

-- 
2.1.0.27.g96db324

