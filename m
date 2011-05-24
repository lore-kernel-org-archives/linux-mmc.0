From: Chris Ball <cjb@laptop.org>
Subject: Re: [v6 5/5] MMC: SDHCI AutoCMD23 support.
Date: Tue, 24 May 2011 19:27:26 -0400
Message-ID: <m3oc2ry90h.fsf@pullcord.laptop.org>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
	<1306181199-13915-6-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58235 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab1EXX0X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 May 2011 19:26:23 -0400
In-Reply-To: <1306181199-13915-6-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 23 May 2011 15:06:39 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, arnd@arndb.de, subhashj@codeaurora.org, malchev@google.com, Philip Rakity <prakity@marvell.com>, zhangfei.gao@gmail.com

Hi Andrei,

On Mon, May 23 2011, Andrei Warkentin wrote:
> Enables Auto-CMD23 support where available (SDHCI 3.0 controllers)
>
> Cc: arindam.nath@amd.com
> Cc: cjb@laptop.org
> Cc: arnd@arndb.de
> Cc: subhashj@codeaurora.org
> Cc: malchev@google.com
> Tested-by: Arindam Nath <arindam.nath@amd.com>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Looks like this patch is breaking boot on my XO-1.75/Marvell MMP2 A2
with SD 3.0 controller.  :/

[    1.217156] sdhci: Secure Digital Host Controller Interface driver
[    1.223361] sdhci: Copyright(c) Pierre Ossman
[    1.227793] mmc0: Auto-CMD23 available
[    1.227793] mmc0: no vmmc regulator found
[    1.242557] mmc0: SDHCI controller on MMC [sdhci-pxa.0] using DMA
[    1.248748] mmc1: Auto-CMD23 available
[    1.252479] mmc1: no vmmc regulator found
[    1.256599] mmc1: SDHCI controller on MMC [sdhci-pxa.1] using DMA
[    1.262694] mmc2: Auto-CMD23 available
[    1.266571] mmc2: no vmmc regulator found
[    1.270655] mmc2: SDHCI controller on MMC [sdhci-pxa.2] using DMA
[    1.656280] mmc1: new SDIO card at address 0001
[    2.423849] libertas: 20:7c:8f:4a:79:c5, fw 9.70.7p0, cap 0x000003a3
[    2.432951] libertas: wlan0: Marvell WLAN 802.11 adapter
[    2.438262] Waiting for root device /dev/mmcblk0p2...
[    2.528607] mmc2: new high speed DDR MMC card at address 0001
[    2.534597] mmcblk0: mmc2:0001 SEM04G 3.68 GiB
[    2.539198] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
[    2.545166] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
[    2.555985]  mmcblk0: unknown partition table
^^^^^
[    2.562610]  mmcblk0boot1: unknown partition table
[    2.569715]  mmcblk0boot0: unknown partition table
[    2.663264] VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2)

With the patch reverted, mmcblk0 comes up with partitions 1 and 2 and
mmcblk0p2 is mounted.  In this log, we fail to find a partition table
and panic.

Any ideas/suggestions?  I'm surprised that we enabled Auto-CMD23 on this
hardware; it is a v3 controller, but it has SDHCI_QUIRK_BROKEN_ADMA set..

Philip/Zhangfei, were you able to test this patch on MMP2?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
