From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v3 00/11] add support for host controller v3.00
Date: Fri, 29 Apr 2011 11:40:36 -0700
Message-ID: <000d01cc069c$ee531970$caf94c50$@org>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:55387 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab1D2Skh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2011 14:40:37 -0400
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arindam Nath' <arindam.nath@amd.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi Arindam/Chris/All,

Sorry for possible dumb question but I am not much aware about SD licensing
terms. I think SDv3.00 spec (or any other older SD specs) is licensed under
some NDA agreement and then there is also a freely available simplified SD
spec as well. So is there no restriction on open source the drivers
supporting SD3.0 spec? How does this works out without violating the NDA
agreement? Your comments would be helpful to understand this.

Regards,
Subhash




> -----Original Message-----
> From: Arindam Nath [mailto:anath.amd@gmail.com] On Behalf Of Arindam
> Nath
> Sent: Wednesday, April 20, 2011 2:31 AM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; prakity@marvell.com;
> subhashj@codeaurora.org; zhangfei.gao@gmail.com; henry.su@amd.com;
> aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> Subject: [PATCH v3 00/11] add support for host controller v3.00
> 
> V3
> ----
> [01/11]: Set bit 24 and bit 28 of OCR within mmc_sd_get_cid(),
>          and only retry sending ACMD41 with bit 24 reset in case
>          signal voltage switch procedure fails.
> [01/11]: Change (*rocr & 0x41000000) to ((*rocr & 0x41000000) ==
>          0x41000000) to check for both CCS and S18A to be set in
>          the response of ACMD41.
> [01/11]: Change the condition if (err == -EAGAIN) to if (err), in
>          order to retry sending ACMD41 because of any error during
>          signal voltage switch procedure.
> [01/11]: Add a new variable signal_voltage to struct mmc_ios,
>          which holds whether the request is to change to 1.8V or
>          3.3V signalling voltage.
> [02/11]: Remove redundant code to find bus speed modes for SD2.0
>          and SD3.0 cards separately.
> [02/11]: Change the variable names from uhs_* to sd3_* to make
>          them appropriate to the context of their usage.
> [03/11]: Change variable names from *_set_drv_type to *_drv_type.
> [03/11]: Set driver type even when the default driver type B is
>          used.
> [03/11]: Clear bits 05-04 of Host Control 2 register before
>          setting the new driver strength.
> [04/11]: Use sdhci_set_clock() to make sure the clock is stable
>          before re-enabling SD clock.
> [05/11]: Initialize bus_speed and timing to 0 at the beginning of
>          sd_set_bus_speed_mode() to avoid compiler warning.
> [06/11]: Initialize current_limit to 0 to avoid compiler warning.
> [06/11]: Remove usage of get_max_current_180() and replace this
>          with MMC_CAP_MAX_CURRENT_*.
> [06/11]: Set the current limit even for the default current limit
>          of 200mA.
> [06/11]: Set the current limit only for SDR50, SDR104, and DDR50
>          UHS-I modes, otherwise set the default current limit.
> [07/11]: Change mmc_*_ultrahighspeed() to mmc_sd_*_uhs().
> [08/11]: Re-read Host Control 2 register before clearing
>          *_TUNED_CLK and *_EXEC_TUNING.
> [08/11]: Make sdhci_execute_tuning() return 'int' rather than
>          'void' so that we can check for error conditions during
>          tuning failure.
> [08/11]: Make sure to return 0 for controllers which provide
>          support for retuning even if tuning fails. For other
>          controllers, return error code.
> [09/11]: Disable using Preset Value when a new card is inserted,
>          and enable its use only after a successfull UHS-I
>          initializaton.
> [11/11]: Remove sdhci_start_retuning_timer() completely, and start
>          the re-tuning timer from within sdhci_execute_tuning()
>          the very first time it is executed.
> 
> V2
> ----
> [01/12]: Make saved_abort_cmd part of struct sdhci_host rather
>          than global variable.
> [01/12]: Clear SDHCI_USE_SDMA _iff_ SDHCI_USE_ADMA is set.
> [01/12]: Set either Auto CMD23 or Auto CMD12, but not both, in
>          the Transfer Mode register.
> [02/12]: Check host controller version before reading
>          SDHCI_CAPABILITIES_1.
> [02/12]: Remove spinlock from sdhci_start_signal_voltage_switch
>          and use usleep_range() rather than mdelay().
> [02/12]: Set S18R in OCR to 1 for all UHS-I modes.
> [02/12]: NULL pointer check for start_signal_voltage_switch().
> [02/12]: Set MMC_CAP_UHS_SDR50 if MMC_CAP_UHS_SDR104 is set.
> [06/12]: Add checking for SDR25 in sd_set_bus_speed_mode().
> [09/12]: Remove checking for MMC_SEND_TUNING_BLOCK within
>          sdhci_set_transfer_mode(), since cmd.data is set to
>          NULL inside sdhci_execute_tuning().
> [11/12]: Correctly set clk to SDHCI_PROG_CLOCK_MODE when host
>          controller supports Programmable Clock Mode.
> 
> V1
> ----
> The patches below add support for Host Controller v3.00 as per the
> spec v3.00. It also adds support for UHS-I cards as per Physical
> Layer Specification v3.01.
> 
> Thanks for review.
> 
> Regards,
> Arindam
> 
> Arindam Nath (11):
>   [PATCH 01/11] mmc: sd: add support for signal voltage switch
> procedure
>   [PATCH 02/11] mmc: sd: query function modes for uhs cards
>   [PATCH 03/11] mmc: sd: add support for driver type selection
>   [PATCH 04/11] mmc: sdhci: reset sdclk before setting high speed
> enable
>   [PATCH 05/11] mmc: sd: add support for uhs bus speed mode selection
>   [PATCH 06/11] mmc: sd: set current limit for uhs cards
>   [PATCH 07/11] mmc: sd: report correct speed and capacity of uhs cards
>   [PATCH 08/11] mmc: sd: add support for tuning during uhs
> initialization
>   [PATCH 09/11] mmc: sdhci: enable preset value after uhs
> initialization
>   [PATCH 10/11] mmc: sdhci: add support for programmable clock mode
>   [PATCH 11/11] mmc: sdhci: add support for retuning mode 1
> 
>  drivers/mmc/core/bus.c    |   11 +-
>  drivers/mmc/core/core.c   |    9 +
>  drivers/mmc/core/core.h   |    1 +
>  drivers/mmc/core/sd.c     |  405 ++++++++++++++++++++++++---
>  drivers/mmc/core/sd.h     |    3 +-
>  drivers/mmc/core/sd_ops.c |   34 +++
>  drivers/mmc/core/sd_ops.h |    1 +
>  drivers/mmc/core/sdio.c   |    3 +-
>  drivers/mmc/host/sdhci.c  |  689
> ++++++++++++++++++++++++++++++++++++++++++---
>  drivers/mmc/host/sdhci.h  |   45 +++-
>  include/linux/mmc/card.h  |   43 +++
>  include/linux/mmc/host.h  |   36 +++
>  include/linux/mmc/mmc.h   |    1 +
>  include/linux/mmc/sd.h    |    1 +
>  include/linux/mmc/sdhci.h |   11 +
>  15 files changed, 1211 insertions(+), 82 deletions(-)


