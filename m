From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Mon, 28 Nov 2016 17:15:25 +0100
Message-ID: <14771688.Q8f97gHC2H@wuerfel>
References: <56B07BA5.4060407@free.fr> <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com> <583C50E7.6030400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:65197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbcK1QQv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2016 11:16:51 -0500
In-Reply-To: <583C50E7.6030400@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Rameshwar Sahu <rsahu@apm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh@kernel.org>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati <sune>

On Monday, November 28, 2016 4:44:39 PM CET Mason wrote:
> Hello,
> 
> @Shawn Lin, could you take a look below and tell me exactly
> which IP core(s) Rockchip is using in its SoCs?
> 
> Based on the feedback I received, here is an updated list of
> compatible strings and controller versions dealt with by the
> drivers/mmc/host/sdhci-of-arasan.c code.
> 
> 
> Xilinx Zynq:
> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: 8.9a is the documentation revision (dated 2011-10-19)
> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
> 
> Xilinx ZynqMP:
> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: using the same compatible string as Zynq
> 
> Sigma SMP87xx
> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
> no compatible string yet, platform-specific init required
> 
> APM:
> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
> "arasan,sdhci-4.9a"
> NB: 4.9a appears to be the documentation revision
> no functional diff with "arasan,sdhci-8.9a"
> 
> Rockchip
> Exact IP unknown, waiting for Shawn's answer
> "arasan,sdhci-5.1"
> NB: 5.1 appears to refer to the eMMC standard supported
> 
> 
> On a final note, there are many variations of the Arasan IP.
> I've tracked down at least the following:
> 
> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
> 
> It seems to me the compatible string should specify
> the SD/SDIO version AND the eMMC version, since it
> seems many combinations are allowed, e.g. eMMC 4.51
> has two possible SD versions.
> 
> What do you think?

It seems wrong to have the eMMC or SD version in the compatible
string.  Is that the only difference between the documents you
found? Normally there should be a version of IP block itself,
besides the supported protocol.

	Arnd
