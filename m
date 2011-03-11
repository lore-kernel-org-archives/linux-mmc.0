From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 00/12] add support for host controller v3.00
Date: Fri, 11 Mar 2011 09:29:13 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3B368E5@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <000601cbdfee$1a0692c0$4e13b840$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-am1.bigfish.com ([213.199.180.138]:33423 "EHLO
	AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755549Ab1CKPaZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Mar 2011 10:30:25 -0500
In-Reply-To: <000601cbdfee$1a0692c0$4e13b840$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "prakity@marvell.com" <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Subhash,

In fact I do run checkpatch.pl on my patches before submitting. The warnings if you notice are all from the header files reporting lines over 80 characters. I did not pay attention to these since if you look into the header files, you will find that lines exceeding 80 characters are common in them. So I am really not sure whether they need to be fixed.

Thanks,
Arindam

> -----Original Message-----
> From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> Sent: Friday, March 11, 2011 6:43 PM
> To: Nath, Arindam; cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: RE: [PATCH v2 00/12] add support for host controller v3.00
> 
> Arindam,
> 
> I am not sure whether you run the "./scripts/checkpatch.pl" script for
> your
> patch or not? When I run this script on your patch, it throws following
> warnings.
> You might want to correct these warnings in your next patches.
> 
> $ ./scripts/checkpatch.pl 0001-mmc-SD3.0-patches.patch
> WARNING: line over 80 characters
> #765: FILE: include/linux/mmc/card.h:155:
> +#define MMC_STATE_ULTRAHIGHSPEED (1<<5)                /* card is in
> ultra
> high speed mode */
> 
> WARNING: line over 80 characters
> #830: FILE: include/linux/mmc/host.h:191:
> +#define MMC_CAP_UHS_SDR12      (1 << 15)       /* Host supports UHS
> SDR12
> mode */
> 
> WARNING: line over 80 characters
> #831: FILE: include/linux/mmc/host.h:192:
> +#define MMC_CAP_UHS_SDR25      (1 << 16)       /* Host supports UHS
> SDR25
> mode */
> 
> WARNING: line over 80 characters
> #832: FILE: include/linux/mmc/host.h:193:
> +#define MMC_CAP_UHS_SDR50      (1 << 17)       /* Host supports UHS
> SDR50
> mode */
> 
> WARNING: line over 80 characters
> #833: FILE: include/linux/mmc/host.h:194:
> +#define MMC_CAP_UHS_SDR104     (1 << 18)       /* Host supports UHS
> SDR104
> mode */
> 
> WARNING: line over 80 characters
> #834: FILE: include/linux/mmc/host.h:195:
> +#define MMC_CAP_UHS_DDR50      (1 << 19)       /* Host supports UHS
> DDR50
> mode */
> 
> WARNING: line over 80 characters
> #835: FILE: include/linux/mmc/host.h:196:
> +#define MMC_CAP_SET_XPC_330    (1 << 20)       /* Host supports >150mA
> current at 3.3V */
> 
> WARNING: line over 80 characters
> #836: FILE: include/linux/mmc/host.h:197:
> +#define MMC_CAP_SET_XPC_300    (1 << 21)       /* Host supports >150mA
> current at 3.0V */
> 
> WARNING: line over 80 characters
> #837: FILE: include/linux/mmc/host.h:198:
> +#define MMC_CAP_SET_XPC_180    (1 << 22)       /* Host supports >150mA
> current at 1.8V */
> 
> WARNING: line over 80 characters
> #838: FILE: include/linux/mmc/host.h:199:
> +#define MMC_CAP_DRIVER_TYPE_A  (1 << 23)       /* Host supports Driver
> Type
> A */
> 
> WARNING: line over 80 characters
> #839: FILE: include/linux/mmc/host.h:200:
> +#define MMC_CAP_DRIVER_TYPE_C  (1 << 24)       /* Host supports Driver
> Type
> C */
> 
> WARNING: line over 80 characters
> #840: FILE: include/linux/mmc/host.h:201:
> +#define MMC_CAP_DRIVER_TYPE_D  (1 << 25)       /* Host supports Driver
> Type
> D */
> 
> WARNING: line over 80 characters
> #873: FILE: include/linux/mmc/sd.h:63:
> +#define SCR_SPEC_VER_2         2       /* Implements system
> specification
> 2.00 - 3.0x */
> 
> total: 0 errors, 13 warnings, 778 lines checked
> 
> 
> Regards,
> Subhash
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > Sent: Friday, March 04, 2011 5:03 PM
> > To: cjb@laptop.org
> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> > subhashj@codeaurora.org; linux-mmc@vger.kernel.org; henry.su@amd.com;
> > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> > Subject: [PATCH v2 00/12] add support for host controller v3.00
> >
> > V2
> > ----
> > [01/12]: Make saved_abort_cmd part of struct sdhci_host rather
> >          than global variable.
> > [01/12]: Clear SDHCI_USE_SDMA _iff_ SDHCI_USE_ADMA is set.
> > [01/12]: Set either Auto CMD23 or Auto CMD12, but not both, in
> >          the Transfer Mode register.
> > [02/12]: Check host controller version before reading
> >          SDHCI_CAPABILITIES_1.
> > [02/12]: Remove spinlock from sdhci_start_signal_voltage_switch
> >          and use usleep_range() rather than mdelay().
> > [02/12]: Set S18R in OCR to 1 for all UHS-I modes.
> > [02/12]: NULL pointer check for start_signal_voltage_switch().
> > [02/12]: Set MMC_CAP_UHS_SDR50 if MMC_CAP_UHS_SDR104 is set.
> > [06/12]: Add checking for SDR25 in sd_set_bus_speed_mode().
> > [09/12]: Remove checking for MMC_SEND_TUNING_BLOCK within
> >          sdhci_set_transfer_mode(), since cmd.data is set to
> >          NULL inside sdhci_execute_tuning().
> > [11/12]: Correctly set clk to SDHCI_PROG_CLOCK_MODE when host
> >          controller supports Programmable Clock Mode.
> >
> > V1
> > ----
> > The patches below add support for Host Controller v3.00 as per the
> > spec v3.00. It also adds support for UHS-I cards as per Physical
> > Layer Specification v3.01.
> >
> > Thanks for review.
> >
> > Regards,
> > Arindam
> >
> > Arindam Nath (12):
> >   [PATCH 01/12] mmc: sdhci: add support for auto CMD23
> >   [PATCH 02/12] mmc: sd: add support for signal voltage switch
> > procedure
> >   [PATCH 03/12] mmc: sd: query function modes for uhs cards
> >   [PATCH 04/12] mmc: sd: add support for driver type selection
> >   [PATCH 05/12] mmc: sdhci: reset sdclk before setting high speed
> > enable
> >   [PATCH 06/12] mmc: sd: add support for uhs bus speed mode selection
> >   [PATCH 07/12] mmc: sd: set current limit for uhs cards
> >   [PATCH 08/12] mmc: sd: report correct speed and capacity of uhs
> cards
> >   [PATCH 09/12] mmc: sd: add support for tuning during uhs
> > initialization
> >   [PATCH 10/12] mmc: sdhci: enable preset value after uhs
> > initialization
> >   [PATCH 11/12] mmc: sdhci: add support for programmable clock mode
> >   [PATCH 12/12] mmc: sdhci: add support for retuning mode 1
> >
> >  drivers/mmc/core/bus.c    |   11 +-
> >  drivers/mmc/core/core.c   |    9 +
> >  drivers/mmc/core/core.h   |    1 +
> >  drivers/mmc/core/sd.c     |  436 +++++++++++++++++++++++++---
> >  drivers/mmc/core/sd.h     |    3 +-
> >  drivers/mmc/core/sd_ops.c |   32 ++
> >  drivers/mmc/core/sd_ops.h |    1 +
> >  drivers/mmc/core/sdio.c   |    3 +-
> >  drivers/mmc/host/sdhci.c  |  697
> > ++++++++++++++++++++++++++++++++++++++++++---
> >  drivers/mmc/host/sdhci.h  |   45 +++-
> >  include/linux/mmc/card.h  |   43 +++
> >  include/linux/mmc/host.h  |   26 ++
> >  include/linux/mmc/mmc.h   |    1 +
> >  include/linux/mmc/sd.h    |    3 +-
> >  include/linux/mmc/sdhci.h |   13 +
> >  15 files changed, 1228 insertions(+), 96 deletions(-)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


