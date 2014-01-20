From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 17:16:21 +0000
Message-ID: <20140120171621.GG15937@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1390190215-22700-2-git-send-email-olof@lixom.net> <20140120164859.GF15937@n2100.arm.linux.org.uk> <CAOMZO5AfSe_c7gfee0BcZso8ZYg=PaTDwfsXwzpEcM1554VQ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43032 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751887AbaATRQa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 12:16:30 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5AfSe_c7gfee0BcZso8ZYg=PaTDwfsXwzpEcM1554VQ6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, chris@printf.net

On Mon, Jan 20, 2014 at 03:03:50PM -0200, Fabio Estevam wrote:
> On Mon, Jan 20, 2014 at 2:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > So far so good.  Now, what about this external oscillator which has its
> > own separate power control.  My immediate thought is that this can be
> > specified via card_ext_clock - I would simply need to declare a fixed-rate
> > clock with either a regulator (power switch) controlled via a gpio (which
> > would probably be closer to the hardware) or a gpio as an enable... ah,
> > that requires me to write a common clock driver for that bit since this
> > is currently not modelled by CCF...
> 
> Isn't this covered by the gpios property of fixed-clock?
> 
> We do the following to enable the 26MHz codec clock in
> imx51-babbage.dts via GPIO4_26:
> 
>         clk_26M: codec_clock {
>             compatible = "fixed-clock";
>             reg=<0>;
>             #clock-cells = <0>;
>             clock-frequency = <26000000>;
>             gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
>         };

Not as far as I can see.  fixed-clock appears to have two properies:

	clock-frequency
	clock-output-names

and nothing else.  See of_fixed_clk_setup in drivers/clk/clk-fixed-rate.c.
You'll also find that the documentation in this file says this about it:

 * DOC: basic fixed-rate clock that cannot gate
 *
 * Traits of this clock:
 * prepare - clk_(un)prepare only ensures parents are prepared
 * enable - clk_enable only ensures parents are enabled
 * rate - rate is always a fixed value.  No clk_set_rate support
 * parent - fixed parent.  No clk_set_parent support

So, I think the bit which you quote from imx51-babbage.dts is wishful
thinking on the part of the author of the DT file, rather than actually
being implemented in any way by the kernel DT support.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
