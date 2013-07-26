From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 26 Jul 2013 11:24:20 -0600
Message-ID: <51F2B0C4.8000301@wwwdotorg.org>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57330 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab3GZRYY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 13:24:24 -0400
In-Reply-To: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/25/2013 04:04 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller

If these are extensions to an existing binding, it feels like the
documentation should be part of that binding, although suppose it's
reasonable to create a HW-specific "sub-class" of an existing binding.

> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +	  specific extensions.

The "altr" vendor prefix doesn't appear in
Documentation/devicetree/bindings/vendor-prefixes.txt. Is there another
patch in flight to add it?

> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which means parent_clock/4.

Should the clocks be represented using the common clock DT binding? If
this register is something that will always be handled entirely
internally to the HW module, then perhaps there's no need. If the driver
is going to need to call clk_set_rate() at all, then representing the
clock using the standard bindings seems better, unless you expect the
driver to call clk_set_rate(desired_rate * internal_divider) instead of
clk_set_rate(desired_rate) everywhere. That might not be unreasonable
though.

> +Required properties for a slot:
> +
> +* bus-width: Data width for card slot. 4-bit or 8-bit data.

Isn't that already part of the standard MMC bindings, and hence not
something you need to duplicate here?

> +Example:
> +
> +  The MSHC controller node can be split into two portions, SoC specific and
> +  board specific portions, as listed below.

That doesn't sound like a good idea. There should be one DT node for
each logical block. The internal construction of the Linux drivers
(presumably you have entirely separate code to handle the two nodes in
Linux so far?) should not influence the DT construction at all.

> +	dwmmc0@ff704000 {
> +		compatible = "altr,socfpga-dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 139 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc0@ff704000 {
> +		num-slots = <1>;
> +		supports-highspeed;
> +		broken-cd;
> +		fifo-depth = <0x400>;
> +		altr,dw-mshc-ciu-div = <3>;
> +      		altr,dw-mshc-sdr-timing = <0 3>;
> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +		};
> +	};
> +

You might want to trim that trailing blank line.
