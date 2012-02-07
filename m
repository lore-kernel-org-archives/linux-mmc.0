From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Tue, 7 Feb 2012 15:32:22 +0530
Message-ID: <CANfBPZ-pD55YgneQSyfs1kKB-DUH8g7TQkKO7O6B95Ydfc8cFg@mail.gmail.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58240 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756691Ab2BGKCp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 05:02:45 -0500
In-Reply-To: <1328367090-10402-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, balajitk@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> This series mainly cleans up all instances of hardcoding's in
> the driver based on pdev->id. This is cleanup leading to the
> DT adaptation of omap_hsmmc driver.
>
> Patches are based on 3.3-rc2 and can be found here
> git://gitorious.org/omap-pm/linux.git omap_hsmmc_cleanup
>
> Tested the patches on my omap4 boards (panda and SDP) but
> haven't tested yet on omap3/2 since I did'nt have boards
> handy. So any testing on any omap3/2 boards is really
> appreciated.

I gave it a spin on Beagleboard-XM (OMAP3630) with root filesystem
on the SD card, and checked again on 4430SDP.

Tested-by: Venkatraman S <svenkatr@ti.com>

>
> regards,
> Rajendra
>
> Balaji T K (3):
> =A0mmc: omap_hsmmc: use platform_get_resource_byname for tx/rx DMA
> =A0 =A0channels
> =A0mmc: omap_hsmmc: remove unused .set_sleep function
> =A0mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag to remove
> =A0 =A0host->id based hardcoding
>
> Rajendra Nayak (3):
> =A0mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power function
> =A0mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power function
> =A0mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc supply
>
> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A02 -
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 | =A0158 +++--------=
----------------------
> =A02 files changed, 14 insertions(+), 146 deletions(-)
>
