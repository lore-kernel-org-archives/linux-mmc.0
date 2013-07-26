From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 26 Jul 2013 14:33:40 -0500
Message-ID: <1374867220.20685.44.camel@linux-builds1>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
	 <51F2B0C4.8000301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:56012
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab3GZTe2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 15:34:28 -0400
In-Reply-To: <51F2B0C4.8000301@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Chris Ball <cjb@laptop.org>, dinh.linux@gmail.com, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2013-07-26 at 11:24 -0600, Stephen Warren wrote:
> On 07/25/2013 04:04 PM, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> > Add "syscon" to the "altr,sys-mgr" binding.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> > +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> > +  Storage Host Controller
> 
> If these are extensions to an existing binding, it feels like the
> documentation should be part of that binding, although suppose it's
> reasonable to create a HW-specific "sub-class" of an existing binding.
> 
> > +Required Properties:
> > +
> > +* compatible: should be
> > +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> > +	  specific extensions.
> 
> The "altr" vendor prefix doesn't appear in
> Documentation/devicetree/bindings/vendor-prefixes.txt. Is there another
> patch in flight to add it?

I will send one shortly.

> 
> > +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> > +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> > +  value is fixed at 3, which means parent_clock/4.
> 
> Should the clocks be represented using the common clock DT binding? If
> this register is something that will always be handled entirely
> internally to the HW module, then perhaps there's no need. If the driver
> is going to need to call clk_set_rate() at all, then representing the
> clock using the standard bindings seems better, unless you expect the
> driver to call clk_set_rate(desired_rate * internal_divider) instead of
> clk_set_rate(desired_rate) everywhere. That might not be unreasonable
> though.

I will have to explore this option. But yes, this register is handled
entirely in the HW module in the case of Exynos, and in SOCFPGA's case
its in another HW block that is not clock related at all.

Since I've based this code on the exynos implementation, I've CCed a few
of those guys to see if this is possible.

> 
> > +Required properties for a slot:
> > +
> > +* bus-width: Data width for card slot. 4-bit or 8-bit data.
> 
> Isn't that already part of the standard MMC bindings, and hence not
> something you need to duplicate here?

Yes, I will remove.

> 
> > +Example:
> > +
> > +  The MSHC controller node can be split into two portions, SoC specific and
> > +  board specific portions, as listed below.
> 
> That doesn't sound like a good idea. There should be one DT node for
> each logical block. The internal construction of the Linux drivers
> (presumably you have entirely separate code to handle the two nodes in
> Linux so far?) should not influence the DT construction at all.

In the end, there is only 1 DT node for each logical block:

dwmmc0@ff704000 {
	compatible = "altr,socfpga-dw-mshc";
	reg = <0xff704000 0x00001000>;
	interrupts = <0x00000000 0x0000008b 0x00000004>;
	fifo-depth = <0x00000400>;
	#address-cells = <0x00000001>;
	#size-cells = <0x00000000>;
	clocks = <0x00000016 0x00000017>;
	clock-names = "biu", "ciu";
	num-slots = <0x00000001>;
	supports-highspeed;
	broken-cd;
 	altr,dw-mshc-ciu-div = <0x00000003>;
  	altr,dw-mshc-sdr-timing = <0x00000000 0x00000003>;
	slot@0 {
		reg = <0x00000000>;
		bus-width = <0x00000004>;
		};
	};

> 
> > +	dwmmc0@ff704000 {
> > +		compatible = "altr,socfpga-dw-mshc";
> > +		reg = <0xff704000 0x1000>;
> > +		interrupts = <0 139 4>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +	};
> > +
> > +	dwmmc0@ff704000 {
> > +		num-slots = <1>;
> > +		supports-highspeed;
> > +		broken-cd;
> > +		fifo-depth = <0x400>;
> > +		altr,dw-mshc-ciu-div = <3>;
> > +      		altr,dw-mshc-sdr-timing = <0 3>;
> > +
> > +		slot@0 {
> > +			reg = <0>;
> > +			bus-width = <4>;
> > +		};
> > +	};
> > +
> 
> You might want to trim that trailing blank line.
> 

Will do. Thanks for reviewing this.

Dinh


