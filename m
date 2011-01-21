From: Luciano Coelho <coelho@ti.com>
Subject: Re: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem
 problems on mmc1
Date: Fri, 21 Jan 2011 16:49:02 +0200
Message-ID: <1295621342.1925.139.camel@pimenta>
References: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38876 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322Ab1AUOtE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 09:49:04 -0500
In-Reply-To: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: l-o List <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>

On Fri, 2011-01-21 at 15:18 +0100, Koen Kooi wrote:
> Hi,
> 
> I'm trying to bring up a wl1271 sdio expansion board on beagle with 2.6.37 and I'm running into a weird problem when enabling MMC_CAP_POWER_OFF_CARD.
> 
> My patch basically does:
> 
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -270,7 +270,7 @@ static struct omap2_hsmmc_info mmc[] = {
>        {
>                .name           = "wl1271",
>                .mmc            = 2,
> -               .caps           = MMC_CAP_4_BIT_DATA,
> +               .caps           = MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
> 
> And does NOT touch mmc1. But after adding MMC_CAP_POWER_OFF_CARD I get tons of:
> 
> [   22.259490] mmcblk0: error -110 sending status comand
> [   22.264617] mmcblk0: error -110 sending read/write command, response 0x0, card status 0x0
> [   22.273345] mmcblk0: error -110 transferring data, sector 2338228, nr 3, card status 0x0
> [   22.281799] end_request: I/O error, dev mmcblk0, sector 2338228
> [   22.288055] mmcblk0: error -110 sending status comand
> [   22.293151] mmcblk0: error -110 sending read/write command, response 0x0, card status 0x0
> [   22.301879] mmcblk0: error -110 transferring data, sector 2338229, nr 2, card status 0x0
> [   22.310363] end_request: I/O error, dev mmcblk0, sector 2338229
> 
> When using mmcblk0p2 as rootfs. Attached is the complete patch. It looks a bit weird because it's using the expansionboard infrastucture I hacked together.
> 
> I suspect that mmc2 is turning off the shared regulator, but I have various people claiming this code (minus the expansionboard detection) works with the same regulator setup, so I'm extremely puzzled.
> 
> The CC: list was partially generated with the get_maintainer.pl script, apologies if I screwed it up.

I think Ohad is the right person to answer this question.

-- 
Cheers,
Luca.

