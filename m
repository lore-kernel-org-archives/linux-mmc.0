From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] mmc: dw_mmc: Make the use of the hold reg generic
Date: Fri, 6 Dec 2013 18:36:26 +0100
Message-ID: <201312061836.26251.arnd@arndb.de>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61156 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab3LFRgq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 12:36:46 -0500
In-Reply-To: <1386346223-18464-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

On Friday 06 December 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi,
> 
> This patch series makes the setting of the SDMMC_CMD_USE_HOLD_REG bit generic
> for all platforms that requires it. According the Synopsys spec on the dw_mmc,
> setting the SDMMC_CMD_USE_HOLD_REG should be done for all speeds except for the
> following higher speed modes: SDR104, SDR50, DDR50. I am also include MMC_HS200
> speed as not needing the SDMMC_CMD_USE_HOLD_REG bit set as well.
> 
> Currently, Rockchip and SOCFPGA's variant of the dw_mmc requires that the
> SDMMC_CMD_USE_HOLD_REG be set. For SOCFPGA, the dw_mmc is operating at 
> MMC_TIMING_SD_HS mode. I don't know Rockchip's variant is operating at.
> 


Very nice, thanks for implementing this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Obviously this needs to be tested on at least the rockchips variant, but
ideally on most others too.

	Arnd
