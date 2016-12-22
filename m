From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 06/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Thu, 22 Dec 2016 11:18:02 +0000
Message-ID: <20161222111802.GX14217@n2100.armlinux.org.uk>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <b8acb86f1e7977648977ed5c6b4eb86323e4b777.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36088 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757285AbcLVLU2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 06:20:28 -0500
Content-Disposition: inline
In-Reply-To: <b8acb86f1e7977648977ed5c6b4eb86323e4b777.1481651244.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>

On Tue, Dec 13, 2016 at 06:48:35PM +0100, Gregory CLEMENT wrote:
> +Optional Properties:
> +- mmc-card:
> +  mmc-card child node must be provided when current SDHC is for eMMC.
> +  Xenon SDHC often can support both SD and eMMC. This child node indicates that
> +  current SDHC is for eMMC card. Thus Xenon eMMC specific configuration and
> +  operations can be enabled prior to eMMC init sequence.
> +  Please refer to Documentation/devicetree/bindings/mmc/mmc-card.txt.
> +  This child node should not be set if current Xenon SDHC is for SD/SDIO.

This looks like a typo - shouldn't it be "mmccard" and not "mmc-card"?
Your examples below use "mmccard" as does the documentation you point
towards.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
