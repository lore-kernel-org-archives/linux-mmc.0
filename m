From: Mason <slash.tmp@free.fr>
Subject: mmc0: Invalid maximum block size, assuming 512 bytes
Date: Tue, 19 Jan 2016 16:33:46 +0100
Message-ID: <569E575A.5070401@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:26935 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbcASPd4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jan 2016 10:33:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Frias <sf84@laposte.net>

Hello,

My SoC provides an Arasan SDIO/eMMC controller supported by the
drivers/mmc/host/sdhci-of-arasan.c driver.

At init, the driver prints a warning to the console:

[    0.887301] sdhci: Secure Digital Host Controller Interface driver
[    0.893537] sdhci: Copyright(c) Pierre Ossman
[    0.897928] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.903903] sdhci-arasan 21000.mmc: No vmmc regulator found
[    0.909537] sdhci-arasan 21000.mmc: No vqmmc regulator found
[    0.915247] mmc0: Invalid maximum block size, assuming 512 bytes
[    0.953797] mmc0: SDHCI controller on 21000.mmc [21000.mmc] using ADMA
[    0.961494] sdhci-arasan 21200.mmc: No vmmc regulator found
[    0.967110] sdhci-arasan 21200.mmc: No vqmmc regulator found

Is "mmc0: Invalid maximum block size, assuming 512 bytes" something
serious which requires investigating, in your experience?

The corresponding DT is:

mmc0: mmc@21000 {
	compatible = "arasan,sdhci-8.9a";
	reg = <0x21000 0x200>;
	clock-names = "clk_xin", "clk_ahb";
	clocks = <&sdio_clk>, <&clkgen 1>;
	interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
};

Regards.
