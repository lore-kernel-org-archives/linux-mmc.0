From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Correct DT properties for Arasan controller
Date: Thu, 19 Nov 2015 17:37:13 +0100
Message-ID: <564DFAB9.3000001@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:32687 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755829AbbKSQoD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 11:44:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>

Hello everyone,

My SoC provides an "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
from Arasan Chip Systems (data sheet says rev 6.0, dated Feb 2010).

There are two instances of the controller:
mmc0 is wired to an SD card reader,
mmc1 is wired to an eMMC chip.

I'm trying to figure out how to write the DT.
(Currently using Linux 4.2)

This is what I have so far:

		mmc0: mmc@21000 {
			compatible = "arasan,sdhci-8.9a";
			reg = <0x21000 0x200>;
			clock-names = "clk_xin", "clk_ahb";
			clocks = <&sdio_clk>, <&clkgen 1>;
			interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
			bus-width = <8>;
			cap-sd-highspeed;
			sd-uhs-sdr12;
			sd-uhs-sdr25;
			sd-uhs-sdr50;
			sd-uhs-ddr50;
			sd-uhs-sdr104;
		};

		mmc1: mmc@21200 {
			compatible = "arasan,sdhci-8.9a";
			reg = <0x21200 0x200>;
			clock-names = "clk_xin", "clk_ahb";
			clocks = <&sdio_clk>, <&clkgen 1>;
			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
			bus-width = <8>;
			non-removable;
		};

https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/mmc.txt

(I don't know anything about MMC, SDHCI, SDIO, etc.)

Are cap-sd-highspeed and sd-uhs-* limited to mmc0? (wired to SD card reader)

Are cap-mmc-highspeed and mmc-* limited to mmc1? (wired to eMMC)

What about these?
- bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
  will be <1> if the property is absent.
- cap-power-off-card: powering off the card is safe
- cap-mmc-hw-reset: eMMC hardware reset is supported
- cap-sdio-irq: enable SDIO IRQ signalling on this interface
- full-pwr-cycle: full power cycle of the card is supported

Also, I set clk_xin to 48 MHz (and clk_ahb is set to 400 MHz).
Does clk_xin need to be higher for the faster modes?

Regards.
