From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 00/12] add support for host controller v3.00
Date: Fri,  4 Mar 2011 17:02:37 +0530
Message-ID: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37226 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab1CDLdH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 06:33:07 -0500
Received: by iwn34 with SMTP id 34so1815959iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 03:33:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

V2
----
[01/12]: Make saved_abort_cmd part of struct sdhci_host rather
         than global variable.
[01/12]: Clear SDHCI_USE_SDMA _iff_ SDHCI_USE_ADMA is set.
[01/12]: Set either Auto CMD23 or Auto CMD12, but not both, in
         the Transfer Mode register.
[02/12]: Check host controller version before reading
         SDHCI_CAPABILITIES_1.
[02/12]: Remove spinlock from sdhci_start_signal_voltage_switch
         and use usleep_range() rather than mdelay().
[02/12]: Set S18R in OCR to 1 for all UHS-I modes.
[02/12]: NULL pointer check for start_signal_voltage_switch().
[02/12]: Set MMC_CAP_UHS_SDR50 if MMC_CAP_UHS_SDR104 is set.
[06/12]: Add checking for SDR25 in sd_set_bus_speed_mode().
[09/12]: Remove checking for MMC_SEND_TUNING_BLOCK within
         sdhci_set_transfer_mode(), since cmd.data is set to
         NULL inside sdhci_execute_tuning().
[11/12]: Correctly set clk to SDHCI_PROG_CLOCK_MODE when host
         controller supports Programmable Clock Mode.

V1
----
The patches below add support for Host Controller v3.00 as per the
spec v3.00. It also adds support for UHS-I cards as per Physical
Layer Specification v3.01.

Thanks for review.

Regards,
Arindam

Arindam Nath (12):
  [PATCH 01/12] mmc: sdhci: add support for auto CMD23
  [PATCH 02/12] mmc: sd: add support for signal voltage switch procedure
  [PATCH 03/12] mmc: sd: query function modes for uhs cards
  [PATCH 04/12] mmc: sd: add support for driver type selection
  [PATCH 05/12] mmc: sdhci: reset sdclk before setting high speed enable
  [PATCH 06/12] mmc: sd: add support for uhs bus speed mode selection
  [PATCH 07/12] mmc: sd: set current limit for uhs cards
  [PATCH 08/12] mmc: sd: report correct speed and capacity of uhs cards
  [PATCH 09/12] mmc: sd: add support for tuning during uhs initialization
  [PATCH 10/12] mmc: sdhci: enable preset value after uhs initialization
  [PATCH 11/12] mmc: sdhci: add support for programmable clock mode
  [PATCH 12/12] mmc: sdhci: add support for retuning mode 1

 drivers/mmc/core/bus.c    |   11 +-
 drivers/mmc/core/core.c   |    9 +
 drivers/mmc/core/core.h   |    1 +
 drivers/mmc/core/sd.c     |  436 +++++++++++++++++++++++++---
 drivers/mmc/core/sd.h     |    3 +-
 drivers/mmc/core/sd_ops.c |   32 ++
 drivers/mmc/core/sd_ops.h |    1 +
 drivers/mmc/core/sdio.c   |    3 +-
 drivers/mmc/host/sdhci.c  |  697 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h  |   45 +++-
 include/linux/mmc/card.h  |   43 +++
 include/linux/mmc/host.h  |   26 ++
 include/linux/mmc/mmc.h   |    1 +
 include/linux/mmc/sd.h    |    3 +-
 include/linux/mmc/sdhci.h |   13 +
 15 files changed, 1228 insertions(+), 96 deletions(-)

