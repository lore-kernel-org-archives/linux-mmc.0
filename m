From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host Controller
Date: Tue, 18 Oct 2016 15:29:54 +0200
Message-ID: <87k2d5eqel.fsf@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
        <fc0ca2b3140287cbccf5c176a12b7dce25d06a47.1475853198.git-series.gregory.clement@free-electrons.com>
        <20161010213417.GA11795@rob-hp-laptop>
        <d95c3035-e3cd-a93c-d408-27f4c8dba589@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:60582 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754205AbcJRNaH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 09:30:07 -0400
In-Reply-To: <d95c3035-e3cd-a93c-d408-27f4c8dba589@marvell.com> (Ziji Hu's
        message of "Tue, 11 Oct 2016 18:03:47 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Ziji Hu <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>Xu

Hi Rob,
 
 On mar., oct. 11 2016, Ziji Hu <huziji@marvell.com> wrote:
[...]

>>> +  Different Xenon SDHC release has different register set size.
>>> +  The specific size should also refer to the SOC implementation.
>>> +
>>> +Optional Properties:
>>> +- Slot Index
>>> +  A single Xenon IP can support multiple slots.
>>> +  During initialization, each slot should set corresponding setting bit in
>>> +  some Xenon-specific registers. The corresponding bit is determined by
>>> +  this property.
>>> +  - xenon,slotno = <slot_index>;
>> 
>> Slots should probably be represented as child nodes with the reg 
>> property being the slot number.
>
> 	Since each SDHC slot is independent, I find it is more
> convenient to implement each one as independent SD host/MMC host
> instant.
> 	Otherwise, a main function should loop and initialize each
> slot, like sdhci-pci. I prefer to avoiding such a unnecessary main
> function.
>
> 	It is very hard to determine the slot number by reg property.
> 	Xenon slots are likely to be different types. 1st slot might
> be eMMC and 2nd one might be SD. They might have different register
> size.
> 	The register size might also varies in different Xenon versions.
>

Something that took me a while to figure out is that even it is the same
hardware block which handle multiple SoCs.

Each slots is managed by its own set of register. From the point of view
of the OS, it is as if we have an independent controller for each
slot.

But for an obscure reason, some command need to know which slot is
used. That's why we ended with this property.

With some example what you had in mind was something like that:
sdhci@aa0000 {
		compatible = "marvell,armada-3700-sdhci";
		reg = <0xaa0000 0x1000>;
[...]
                slot0 {
                      /* slot0 is an eMMC */
                      reg = <0>;
                      bus-width = <8>;
                      xenon,pad-type = "fixed-1-8v";

                }
                slot1 {
                      /* slot1 is an SD Card */
                      reg = <1>;
                      bus-width = <4>;
                      xenon,pad-type = "fixed-1-8v";

                }
	};

But it won't work as each slot uses its own address registers, that why we
ended with this:
sdhci@aa0000 {
                /* slot0 is an eMMC */
		compatible = "marvell,armada-3700-sdhci";
		reg = <0xaa0000 0x1000>;
[...]
                xenon,slotno = <0>;
                bus-width = <8>;
                xenon,pad-type = "fixed-1-8v";
	};
sdhci@bb0000 {
                /* slot1 is an SD Card */
		compatible = "marvell,armada-3700-sdhci";
		reg = <0xbb0000 0x1000>;
[...]
                xenon,slotno = <1>;
                bus-width = <4>;
                xenon,pad-type = "fixed-1-8v";
	};

I hope it is more clear now.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
