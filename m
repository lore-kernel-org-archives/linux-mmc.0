From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for
 eMMC DDR 3.3V
Date: Fri, 27 Jan 2017 10:27:29 +0800
Message-ID: <2d3a5129-1514-1969-89df-1972427f7856@rock-chips.com>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:34459 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdA0C2B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2017 21:28:01 -0500
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

On 2017/1/25 23:12, Ulf Hansson wrote:
> It's been reported that some mmc hosts don't support a VCCQ (signal voltage) of
> 1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC spec, an
> eMMC card must support both if any, which makes the mmc host being the
> potential limitation. Therefore, let's invent a new mmc cap, MMC_CAP_3_3V_DDR,
> and a new corresponding DT binding, which tells whether 3.3V is supported for
> the VCCQ.
>
> In the context of these changes, I took the opportunity to make some clean-ups
> of some related code.
>

This patchset looks good. Just a nit, maybe we could take this chance
to improve the patch 3 as we touch it now:)

s/mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0/
!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180), and so on:)

Anyway,
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

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


-- 
Best Regards
Shawn Lin

