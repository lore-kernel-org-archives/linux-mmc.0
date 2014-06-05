From: Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH v2 0/3] mmc: sdhci: Use mmc core regulator infrastucture
Date: Thu, 5 Jun 2014 15:00:02 -0700
Message-ID: <1402005605-24197-1-git-send-email-markus.mayer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:57020 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbaFEWAx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 18:00:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This series switches the common SDHCI code over to use mmc_host's
regulator pointers rather than keeping its own set.

In addition, we can now re-use the newly introduced local "mmc" pointer
in several other function calls in lieu of using host->mmc.

The first patch in the series has been posted before
(https://lkml.org/lkml/2014/4/24/947). The two follow-on patches have
not. Patches 2 & 3 could be squashed together if the maintainers are so
inclined.

This series is based on mmc-next.

Changes from v1:
  - Resolved merge conflicts resulting from RMK's MMC series. The most
    significant conflict was the move of regulator code from
    sdhci_do_set_ios() to sdhci_set_power().
  - Added follow-on patches 2 & 3 of the series.
  - Updated Tim Kryger's e-mail address.

Markus Mayer (2):
  mmc: sdhci: Use existing mmc pointer calling mmc_regulator_set_ocr()
  mmc: sdhci: Replace host->mmc with mmc where possible

Tim Kryger (1):
  mmc: sdhci: Use mmc core regulator infrastucture

 drivers/mmc/host/sdhci.c  | 113 ++++++++++++++++++----------------------------
 include/linux/mmc/sdhci.h |   3 --
 2 files changed, 44 insertions(+), 72 deletions(-)

-- 
1.9.1
