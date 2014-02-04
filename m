From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v10 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Tue, 4 Feb 2014 14:02:35 +0530
Message-ID: <52F0A5A3.4020304@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com> <1389627375-9107-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaBDIcv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Feb 2014 03:32:51 -0500
In-Reply-To: <1389627375-9107-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, chris@printf.net, tony@atomide.com
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, broonie@kernel.org

On Monday 13 January 2014 09:06 PM, Balaji T K wrote:
> Few cleanups to reduce code indent,
> Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
> to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.
>

Hi Tony,

Considering the dependencies with regulator, defconfig, mmc and device tree,
Is it possible for you to pick this series.

Thanks and Regards,
Balaji T K

> Balaji T K (7):
>    mmc: omap_hsmmc: use devm_regulator API
>    mmc: omap_hsmmc: handle vcc and vcc_aux independently
>    regulator: add pbias regulator support
>    mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
>    ARM: dts: add pbias dt node
>    ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
>    mmc: omap_hsmmc: remove pbias workaround
>
>   .../bindings/regulator/pbias-regulator.txt         |   27 ++
>   arch/arm/boot/dts/dra7.dtsi                        |   17 ++
>   arch/arm/boot/dts/omap2430.dtsi                    |   17 ++
>   arch/arm/boot/dts/omap3.dtsi                       |   17 ++
>   arch/arm/boot/dts/omap4.dtsi                       |   17 ++
>   arch/arm/boot/dts/omap5.dtsi                       |   17 ++
>   arch/arm/configs/omap2plus_defconfig               |    2 +
>   drivers/mmc/host/omap_hsmmc.c                      |  111 +++++----
>   drivers/regulator/Kconfig                          |    9 +
>   drivers/regulator/Makefile                         |    1 +
>   drivers/regulator/pbias-regulator.c                |  255 ++++++++++++++++++++
>   11 files changed, 441 insertions(+), 49 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
>   create mode 100644 drivers/regulator/pbias-regulator.c
>

