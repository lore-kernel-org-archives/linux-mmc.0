From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: Correct DT properties for Arasan controller
Date: Fri, 20 Nov 2015 13:53:33 +0100
Message-ID: <564F17CD.2020803@sigmadesigns.com>
References: <564DFAB9.3000001@sigmadesigns.com> <6057509.l0OJuA1sv4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.203]:17927 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162723AbbKTMxi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 07:53:38 -0500
In-Reply-To: <6057509.l0OJuA1sv4@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Suman Tripathi <stripathi@apm.com>

On 19/11/2015 21:56, Arnd Bergmann wrote:
> On Thursday 19 November 2015 17:37:13 Marc Gonzalez wrote:
>> Hello everyone,
>>
>> My SoC provides an "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
>> from Arasan Chip Systems (data sheet says rev 6.0, dated Feb 2010).
>>
>> There are two instances of the controller:
>> mmc0 is wired to an SD card reader,
>> mmc1 is wired to an eMMC chip.
>>
>> I'm trying to figure out how to write the DT.
>> (Currently using Linux 4.2)
>>
>> This is what I have so far:
>>
>> 		mmc0: mmc@21000 {
>> 			compatible = "arasan,sdhci-8.9a";
> 
> make this "arasan,sdhci-6.0", plus a chip specific string
> in front of it.

Sorry, I wasn't clear...
6.0 is the revision of the documentation, not of the hardware block.
(Actually, I don't know what 4.9a and 8.9a refer to.
Does anyone know?)

>> 			reg = <0x21000 0x200>;
>> 			clock-names = "clk_xin", "clk_ahb";
>> 			clocks = <&sdio_clk>, <&clkgen 1>;
>> 			interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
>> 			bus-width = <8>;
>> 			cap-sd-highspeed;
>> 			sd-uhs-sdr12;
>> 			sd-uhs-sdr25;
>> 			sd-uhs-sdr50;
>> 			sd-uhs-ddr50;
>> 			sd-uhs-sdr104;
>> 		};
>>
>> 		mmc1: mmc@21200 {
>> 			compatible = "arasan,sdhci-8.9a";
>> 			reg = <0x21200 0x200>;
>> 			clock-names = "clk_xin", "clk_ahb";
>> 			clocks = <&sdio_clk>, <&clkgen 1>;
>> 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
>> 			bus-width = <8>;
>> 			non-removable;
>> 		};
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/mmc.txt
>>
>> (I don't know anything about MMC, SDHCI, SDIO, etc.)
>>
>> Are cap-sd-highspeed and sd-uhs-* limited to mmc0? (wired to SD card reader)
>>
>> Are cap-mmc-highspeed and mmc-* limited to mmc1? (wired to eMMC)
> 
> It depends: if the wiring is board specific, put them into the .dts file
> and put the generic properties (interrupts, clocks, reg, compatible)
> into the .dtsi file.

Hmmm, sorry again. I was not asking where to put them. I was asking
if I should only use sd-uhs-* properties for an SD card reader node?

And should I only use mmc-* for an eMMC node?

>> What about these?
>> - bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
>>   will be <1> if the property is absent.
> 
> board specific

HW guy tells me the controller handles 8 bits. Do you mean that the
board could actually use only 1 or 4 wires?

>> - cap-power-off-card: powering off the card is safe
>> - cap-mmc-hw-reset: eMMC hardware reset is supported
>> - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>> - full-pwr-cycle: full power cycle of the card is supported
>>
>> Also, I set clk_xin to 48 MHz (and clk_ahb is set to 400 MHz).
>> Does clk_xin need to be higher for the faster modes?
> 
> don't know. I think the clock gets set by the driver, so the
> clock controller needs to be programmable.

The input clock is definitely not programmable. I see a clock
divider inside the controller (SDCLK Frequency Select)

I also see "00h - base clock (10MHz-63MHz)"

However, elsewhere the doc states:

> clk_xin - Input SD Clock used to generate SD Clock based on the
> divisor value programmed by the Host Driver. This SD clock input is
> used to generate SD Clock. This clock is also used to derive Sleep
> clock used to detect Card insertion / removal.
> For maximum efficiency > this should be around 52 MHz (for MMC) /
> 208Mhz (for SD3.0) / 50Mhz (for SD2.0)

Since the controller supports SD3.0, I'm wondering if I should use
a faster clock for that.

Regards.

