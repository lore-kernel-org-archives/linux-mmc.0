From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 00/12] add support for host controller v3.00
Date: Fri, 15 Apr 2011 16:08:50 +0530
Message-ID: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63911 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1DOKjk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 06:39:40 -0400
Received: by pvg12 with SMTP id 12so1007817pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:39:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

V3
----
[01/12]: Changed function name from *_auto_cmd23_supported() to
         *_auto_cmd23_required().
[02/12]: Set bit 24 and bit 28 of OCR within mmc_sd_get_cid(),
         and only retry sending ACMD41 with bit 24 reset in case
         signal voltage switch procedure fails.
[02/12]: Change (*rocr & 0x41000000) to ((*rocr & 0x41000000) ==
         0x41000000) to check for both CCS and S18A to be set in
         the response of ACMD41.
[02/12]: Change the condition if (err == -EAGAIN) to if (err), in
         order to retry sending ACMD41 because of any error during
         signal voltage switch procedure.
[02/12]: Add a new variable signal_voltage to struct mmc_ios,
         which holds whether the request is to change to 1.8V or
         3.3V signalling voltage.
[03/12]: Remove redundant code to find bus speed modes for SD2.0
         and SD3.0 cards separately.
[03/12]: Change the variable names from uhs_* to sd3_* to make
         them appropriate to the context of their usage.
[04/12]: Change variable names from *_set_drv_type to *_drv_type.
[04/12]: Set driver type even when the default driver type B is
         used.
[04/12]: Clear bits 05-04 of Host Control 2 register before
         setting the new driver strength.
[05/12]: Use sdhci_set_clock() to make sure the clock is stable
         before re-enabling SD clock.
[06/12]: Initialize bus_speed and timing to 0 at the beginning of
         sd_set_bus_speed_mode() to avoid compiler warning.
[07/12]: Initialize current_limit to 0 to avoid compiler warning.
[07/12]: Remove usage of get_max_current_180() and replace this
         with MMC_CAP_MAX_CURRENT_*.
[07/12]: Set the current limit even for the default current limit
         of 200mA.
[07/12]: Set the current limit only for SDR50, SDR104, and DDR50
         UHS-I modes, otherwise set the default current limit.
[08/12]: Change mmc_*_ultrahighspeed() to mmc_sd_*_uhs().
[09/12]: Re-read Host Control 2 register before clearing
         *_TUNED_CLK and *_EXEC_TUNING.
[09/12]: Make sdhci_execute_tuning() return 'int' rather than
         'void' so that we can check for error conditions during
         tuning failure.
[09/12]: Make sure to return 0 for controllers which provide
         support for retuning even if tuning fails. For other
         controllers, return error code.
[10/12]: Disable using Preset Value when a new card is inserted,
         and enable its use only after a successfull UHS-I
         initializaton.
[12/12]: Remove sdhci_start_retuning_timer() completely, and start
         the re-tuning timer from within sdhci_execute_tuning()
         the very first time it is executed.

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
 drivers/mmc/core/sd.c     |  408 ++++++++++++++++++++++--
 drivers/mmc/core/sd.h     |    3 +-
 drivers/mmc/core/sd_ops.c |   34 ++
 drivers/mmc/core/sd_ops.h |    1 +
 drivers/mmc/core/sdio.c   |    3 +-
 drivers/mmc/host/sdhci.c  |  755 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h  |   47 +++-
 include/linux/mmc/card.h  |   46 +++
 include/linux/mmc/host.h  |   36 +++
 include/linux/mmc/mmc.h   |    1 +
 include/linux/mmc/sd.h    |    3 +-
 include/linux/mmc/sdhci.h |   13 +
 15 files changed, 1283 insertions(+), 88 deletions(-)

