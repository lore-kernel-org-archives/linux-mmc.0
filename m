From: Mason <slash.tmp@free.fr>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Mon, 28 Nov 2016 16:44:39 +0100
Message-ID: <583C50E7.6030400@free.fr>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
 <582EF744.8090307@free.fr> <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:38157 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbcK1Ppk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Nov 2016 10:45:40 -0500
In-Reply-To: <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Rameshwar Sahu <rsahu@apm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Zach Brown <zach.brown@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, Suneel Garapati <suneel.garapati@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Frias <sf84@l>

Hello,

@Shawn Lin, could you take a look below and tell me exactly
which IP core(s) Rockchip is using in its SoCs?

Based on the feedback I received, here is an updated list of
compatible strings and controller versions dealt with by the
drivers/mmc/host/sdhci-of-arasan.c code.


Xilinx Zynq:
"SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
"arasan,sdhci-8.9a"
NB: 8.9a is the documentation revision (dated 2011-10-19)
subsequent tweaks labeled 9.0a, 9.1a, 9.2a

Xilinx ZynqMP:
"SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
"arasan,sdhci-8.9a"
NB: using the same compatible string as Zynq

Sigma SMP87xx
"SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
no compatible string yet, platform-specific init required

APM:
"SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
"arasan,sdhci-4.9a"
NB: 4.9a appears to be the documentation revision
no functional diff with "arasan,sdhci-8.9a"

Rockchip
Exact IP unknown, waiting for Shawn's answer
"arasan,sdhci-5.1"
NB: 5.1 appears to refer to the eMMC standard supported


On a final note, there are many variations of the Arasan IP.
I've tracked down at least the following:

SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf

It seems to me the compatible string should specify
the SD/SDIO version AND the eMMC version, since it
seems many combinations are allowed, e.g. eMMC 4.51
has two possible SD versions.

What do you think?

Regards.

