From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 0/3] SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST removal
Date: Thu, 7 Apr 2016 11:13:07 +0200
Message-ID: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:45963 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcDGJMr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2016 05:12:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

I have recently observed that the quirk
SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST I have introduced doesn't fix all
the bugs relative to the internal clock disabling while configuring the SD
clock. This delay was introduced because of a re-synchronisation done when
disabling the internal clock.

Unfortunately, we can still have clock stabilization bug even if it occurs
rarely. Moreover, trying to use presets, disabling the internal clock causes an
unexpected switch to the base clock. It should be solved on next revision of
the chip.

For those reasons plus the non acceptance of new quirks, I have decided to
remove it and to implement my own set_clock() function. In ordrer to reduce
code duplication with the sdhci set_clock function, I moved some of the
code in a new sdhci_compute_clock_config() function.

Regards

Changes:
- v3:
  - s/sdhci_compute_clock_config/sdhci_calc_clk.
  - don't update actual_clock in sdhci_calc_clk but return its value as an
  output parameter.
- v2:
  - sdhci_compute_clock_config uses a returned value instead of an
  out-parameter to provide the clock configuration.

Ludovic Desroches (3):
  mmc: sdhci: introduce sdhci_compute_clock_config
  mmc: sdhci-of-at91: implement specific set_clock function
  mmc: sdhci: removal of SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST

 drivers/mmc/host/sdhci-of-at91.c | 48 ++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c         | 34 ++++++++++++++++++----------
 drivers/mmc/host/sdhci.h         |  7 ++----
 3 files changed, 70 insertions(+), 19 deletions(-)

-- 
2.5.0

