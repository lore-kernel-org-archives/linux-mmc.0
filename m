From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for
 eMMC DDR 3.3V
Date: Fri, 27 Jan 2017 13:06:52 +0100
Message-ID: <20170127120652.GA24844@hardcore>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:53120
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932761AbdA0MII (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Jan 2017 07:08:08 -0500
Content-Disposition: inline
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>

On Wed, Jan 25, 2017 at 04:12:17PM +0100, Ulf Hansson wrote:
> It's been reported that some mmc hosts don't support a VCCQ (signal voltage) of
> 1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC spec, an
> eMMC card must support both if any, which makes the mmc host being the
> potential limitation. Therefore, let's invent a new mmc cap, MMC_CAP_3_3V_DDR,
> and a new corresponding DT binding, which tells whether 3.3V is supported for
> the VCCQ.
> 
> In the context of these changes, I took the opportunity to make some clean-ups
> of some related code.

Works fine with the new Cavium driver (enables DDR mode for the eMMC).

Tested-by: Jan Glauber <jglauber@cavium.com>

> Ulf Hansson (6):
>   mmc: core: Remove redundant code in mmc_set_signal_voltage()
>   mmc: core: Clarify usage of mmc_set_signal_voltage()
>   mmc: core: Rename __mmc_set_signal_voltage() to
>     mmc_set_signal_voltage()
>   mmc: core: Invent MMC_CAP_3_3V_DDR
>   mmc: dt: Document binding for eMMC DDR 3.3V I/O voltage support
>   mmc: core: Extend mmc_of_parse() to check for mmc-ddr-3_3v
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |  1 +
>  drivers/mmc/core/core.c                       | 19 ++++++-------------
>  drivers/mmc/core/core.h                       |  4 ++--
>  drivers/mmc/core/host.c                       |  2 ++
>  drivers/mmc/core/mmc.c                        | 27 +++++++++++++++------------
>  drivers/mmc/core/sd.c                         |  3 +--
>  drivers/mmc/core/sdio.c                       |  3 +--
>  include/linux/mmc/host.h                      | 21 ++++++++++-----------
>  8 files changed, 38 insertions(+), 42 deletions(-)
> 
> -- 
> 1.9.1
