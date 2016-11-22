From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host Controller
Date: Tue, 22 Nov 2016 18:23:16 +0100
Message-ID: <87d1hno2d7.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
        <ee296deafdcbeb431a592b591ae38a758ba4cce7.1477911954.git-series.gregory.clement@free-electrons.com>
        <20161109182426.vfrpb4i2mfatdzz3@rob-hp-laptop>
        <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39531 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756549AbcKVRcZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 12:32:25 -0500
In-Reply-To: <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e@marvell.com> (Ziji Hu's
        message of "Thu, 10 Nov 2016 19:44:19 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ziji Hu <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>

Hi Rob,
 
 On jeu., nov. 10 2016, Ziji Hu <huziji@marvell.com> wrote:

[...]

>>> +
>>> +- reg:
>>> +  * For "marvell,xenon-sdhci", one register area for Xenon IP.
>>> +
>>> +  * For "marvell,armada-3700-sdhci", two register areas.
>>> +    The first one for Xenon IP register. The second one for the Armada 3700 SOC
>>> +    PHY PAD Voltage Control register.
>>> +    Please follow the examples with compatible "marvell,armada-3700-sdhci"
>>> +    in below.
>>> +    Please also check property marvell,pad-type in below.
>>> +
>>> +Optional Properties:
>>> +- marvell,xenon-slotno:
>> 
>> Multiple slots should be represented as child nodes IMO. I think some 
>> other bindings already do this.
>> 
>
> 	All the slots are entirely independent.
> 	I prefer to consider it as multiple independent SDHCs placed in
> 	a single IP, instead of that a IP contains multiple child slots.

It was indeed what I tried to show in my answer for the 1st version:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461860.html

Maybe you missed it.

You also mentioned other bindings using child nodes, but for this one
we have one controller with only one set of register with multiple slots
(Atmel is an example). Here each slot have it own set of register.

Actually giving the fact that each slot is controlled by a different set
of register I wonder why the hardware can't also deduce the slot number
from the address register. For me it looks like an hardware bug but we
have to deal with it.

Do you still think we needchild node here?

>
> 	It is unlike the implementation which put multiple slots behind PCIe EP interface. sdhci-pci.c will handle each slot init one by one.
> 	If Xenon SDHC slots are represented as child nodes, there should also be a main entry in Xenon driver to init each child node one by one.
> 	In my very own opinion, it is inconvenient and unnecessary.


Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
