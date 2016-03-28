From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 09:37:00 +0000
Message-ID: <1459157818.4785.5.camel@synopsys.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
	 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com>
	 <56F6D083.1020402@denx.de> <56F6D1E9.3050606@mentor.com>
	 <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
	 <56F6EFFD.9070007@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F6EFFD.9070007@denx.de>
Content-Language: en-US
Content-ID: <7F731748EFD43647B6CB0C774073CA59@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "marex@denx.de" <marex@denx.de>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Marek, Vladimir,

On Sat, 2016-03-26 at 21:24 +-0100, Marek Vasut wrote:
+AD4- On 03/26/2016 09:12 PM, Vladimir Zapolskiy wrote:
+AD4- +AD4- 
+AD4- +AD4- On 26.03.2016 21:52, Marek Vasut wrote:
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- On 03/26/2016 07:16 PM, Vladimir Zapolskiy wrote:
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- On 26.03.2016 20:10, Marek Vasut wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- On 03/26/2016 06:52 PM, Vladimir Zapolskiy wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- Hi Marek,
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- On 26.03.2016 19:30, Marek Vasut wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- On 03/26/2016 06:26 PM, Vladimir Zapolskiy wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- On 26.03.2016 12:14, Marek Vasut wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- Hi+ACE-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- I noticed that arch/arc/boot/dts/axs10x+AF8-mb.dtsi uses +ACI-altr,+ACI- prefix in
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- the DT compatible string:
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- mmc+AEA-0x15000 +AHs-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-compatible +AD0- +ACI-altr,socfpga-dw-mshc+ACIAOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-reg +AD0- +ADw- 0x15000 0x400 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-num-slots +AD0- +ADw- 1 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-fifo-depth +AD0- +ADw- 16 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-card-detect-delay +AD0- +ADw- 200 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-clocks +AD0- +ADwAJg-apbclk+AD4-, +ADwAJg-mmcclk+AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-clock-names +AD0- +ACI-biu+ACI-, +ACI-ciu+ACIAOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-interrupts +AD0- +ADw- 7 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AKAAoACgAKAAoACgAKAAoA-bus-width +AD0- +ADw- 4 +AD4AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AH0AOw-
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- I don't think this is OK, since ARC is unrelated to Altera, which is
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- what the +ACI-altr,+ACI- prefix stands for. I think the socfpga-dw-mshc shim
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- should be extended with another compatibility string, something like
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +ACI-snps,arc-dw-mshc+ACI- and the axs10x+AF8-mb.dtsi should be adjusted
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- accordingly. What do you think ?
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- There is +ACI-snps,dw-mshc+ACI- described in
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt and supported by
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- dw+AF8-mmc host controller driver.
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- Thanks, that's even better.
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- btw what do you think of using altr, prefix on non-altera system, that
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- +AD4- doesn't seem ok, right ?
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- according to ePAPR the prefix should represent a device (IP block here
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- I believe) manufacturer, so it should be okay to use +ACI-altr+ACI- prefix on
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- non-Altera system, if Altera provides+AKAAoA-another hardware vendor with
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- some own IP block.
+AD4- +AD4- +AD4- +AD4- +AD4- In this case, it's Synopsys who provides the SD/MMC/MS core to other
+AD4- +AD4- +AD4- +AD4- +AD4- chip makers (Altera etc).
+AD4- +AD4- +AD4- +AD4- Correct.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- That said, I would rather prefer to see +ACI-snps,dw-mshc+ACI- prefix on description
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- of an MMC controller found on SoCFPGA series, +ACI-altr,socfpga-dw-mshc+ACI- seems
+AD4- +AD4- +AD4- +AD4- +AD4- +AD4- to be redundant.
+AD4- +AD4- +AD4- +AD4- +AD4- According to drivers/mmc/host/dw+AF8-mmc-pltfm.c , the Altera SoCFPGA one
+AD4- +AD4- +AD4- +AD4- +AD4- +ACI-altr,socfpga-dw-mshc+ACI- and also Imagination Technology Pistacio one
+AD4- +AD4- +AD4- +AD4- +AD4- +ACI-img,pistachio-dw-mshc+ACI- need specialty bit (SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG),
+AD4- +AD4- +AD4- +AD4- +AD4- while the stock one +ACI-snps,dw-mshc+ACI- does not. I am not sure if the ARC
+AD4- +AD4- +AD4- +AD4- +AD4- one needs it as well, but most likely yes.
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- +AD4- I wonder if that bit is needed on some particular version of the DWMMC
+AD4- +AD4- +AD4- +AD4- +AD4- core. In that case, should we have +ACI-snps,dw-mshc+ACI- and +ACI-snps,dw-mshc-vN+ACI-
+AD4- +AD4- +AD4- +AD4- +AD4- binding ? Or should we use DT property to discern the need for this bit ?
+AD4- +AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- That's the most common way to take into account peculiarities, add
+AD4- +AD4- +AD4- +AD4- a property and handle it from the driver.
+AD4- +AD4- +AD4- And by +ACI-that+ACI- you mean which of those two I listed , the
+AD4- +AD4- +AD4- +ACI-snps,dw-mshc-vN+ACI- or adding new DT prop ?
+AD4- +AD4- +AD4- 
+AD4- +AD4- I meant to add a new property, not a new compatible, but that's just
+AD4- +AD4- my experience.
+AD4- +AD4- 
+AD4- +AD4- Let me say it +AF8AXw-might+AF8AXw- happen that a particular change you need is
+AD4- +AD4- specific to a particular version of the DWMMC IP (query Synopsys
+AD4- +AD4- by the way), but more probably it might be e.g. the same IP version with
+AD4- +AD4- a different reduced or extended configuration or a minor fix/improvement
+AD4- +AD4- to the IP block without resulting version number bump.
+AD4- +AD4- 
+AD4- +AD4- For example I don't remember that errata fixes in IP blocks result in
+AD4- +AD4- a new compatible, instead there are quite common optional +ACI-quirk+ACI-
+AD4- +AD4- properties for broken IPs -- e.g. check bindings/usb/dwc3.txt :)
+AD4- Right, this very much matches how I see it as well. Thanks for confirming.
+AD4- 
+AD4- Alexey, can you tell us if the requirement for setting
+AD4- SDMMC+AF8-CMD+AF8-USE+AF8-HOLD+AF8-REG came with some new revision of the core or
+AD4- disappeared with some revision OR if this is some configuration
+AD4- option of the core during synthesis ?

Sorry for not following that discussion during my weekend but I'll try
to address all questions now.

DW Mobile Storage databook says:
---------------------+AD4-8-----------------------
To meet the relatively high Input Hold Time requirement for SDR12, SDR25,
and other MMC speed modes, you should program bit+AFs-29+AF0-use+AF8-hold+AF8-Reg of the
CMD register to 1'b1.
---------------------+AD4-8-----------------------

So I'd say this specific setting has nothing to do with a particular IP block
but instead it is related to card's mode of operation. More precisely bus clock.
SDR12 stands for+AKA-12.5 MByte/s, SDR25 stands for+AKA-25 MByte/s. I.e. we probably need
so set that bit just for certain cases and regardless board that uses DW MMC.

I'm adding DW MMC maintainer as well as linux-mmc mailing list so people who
understands that stuff better may comment here as well.

-Alexey
