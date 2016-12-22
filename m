From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 00/12] mmc: Add support to Marvell Xenon SD Host
 Controller
Date: Thu, 22 Dec 2016 11:25:28 +0000
Message-ID: <20161222112528.GZ14217@n2100.armlinux.org.uk>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36186 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755276AbcLVLZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 06:25:40 -0500
Content-Disposition: inline
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>

On Tue, Dec 13, 2016 at 06:48:29PM +0100, Gregory CLEMENT wrote:
> This the forth version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).

With the problems and niggles fixed, it seems to work here on my 8040
board (along with dma-coherent):

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on f06e0000.sdhci [f06e0000.sdhci] using ADMA 64-bit
mmc0: new high speed MMC card at address 0001
mmcblk0: mmc0:0001 8GND3R 7.28 GiB
mmc1: SDHCI controller on f2780000.sdhci [f2780000.sdhci] using ADMA 64-bit
mmcblk0boot0: mmc0:0001 8GND3R partition 1 4.00 MiB
mmcblk0boot1: mmc0:0001 8GND3R partition 2 4.00 MiB
mmcblk0rpmb: mmc0:0001 8GND3R partition 3 512 KiB
mmc1: new high speed SDHC card at address 0001
mmcblk1: mmc1:0001 00000 14.6 GiB
 mmcblk1: p1 p2 p3

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
