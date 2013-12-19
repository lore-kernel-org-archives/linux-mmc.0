From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property to the "altr, socfpga-gate-clk"
Date: Thu, 19 Dec 2013 06:50:17 +0100
Message-ID: <201312190650.17806.arnd@arndb.de>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com> <201312182221.46506.arnd@arndb.de> <52B2703A.8090001@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50865 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3LSFus (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 00:50:48 -0500
In-Reply-To: <52B2703A.8090001@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, dinguyen@altera.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thursday 19 December 2013, Dinh Nguyen wrote:
> On 12/18/13 3:21 PM, Arnd Bergmann wrote:
> > On Wednesday 18 December 2013, Mike Turquette wrote:
> > I would definitely prefer using degrees over an arbitrary enumeration that
> > might work on some platforms but not on others.
> >
> > I'm also a bit skeptical about the idea of putting the phase into the clock
> > provider rather than the consumer, given the comments about the
> > clk_set_phase() interface earlier. Generally we try to avoid having
> > consumer-specific settings in a provider node (for any DT binding,
> > not just clocks). Can't you have the same numbers in the dw-mshc
> > node instead and let the mmc driver call clk_set_phase instead?
> > If every clock has a fixed phase for a given piece of hardware, it
> > could even be set automatically by making the common clk code read
> > the clk-phase attribute at the time a driver calls clk_get.
> 
> So I think this is what you're suggesting:
> clocks = <&sdmmc_clk 0 135>, this would specify 0 and 135 degrees phase.

It's not what I meant in the paragraph above, but I have suggested this
method in the past, and I think that would solve the problem very nicely
as well, if Mike agrees. 

> The clock-bindings document is stating that the integer in the clocks
> property is
> specifying the output number of the clock. Would this approach cause a
> conflict and would
> need an update to that document/approach?

I don't think we have to change the common binding. While it lists the
use of the integer for multiple clock outputs, that's not necessarily
the only possible use, and specific bindings can always override the
generic ones in a compatible way.

You would certainly have to update the binding of your clock controller
to do this, in particular because #clock-cells is now <1>. You will
probably need to add a new "compatible" string for a clock that has
a phase setting rather than just a gate, and document what the argument
is for. If possible, try to model the hardware the way it actually
is implemented. If the clock controller supports both the gate and
the phase in the same block, then make it one clock device node, but
if you have one block generating the clock and another one to shift the
phase, it may be best to model that second clock in a separate node
so you can split the driver code according to the registers, like

	mmcclock-shifted {
		compatible = "altr,socfpga-clk-shift";
		reg = <0xabcd>;
		clocks = <&mmcclock>;
		#clock-cells = <1>
	};

	mshc {
		...
		clocks = <&/clocks/mmcclock-shifted 135>;
		clock-names = "ciu";
	};

Coming back to what I actually tried to suggest above was 

	mshc {
		...
		clocks = <&/clocks/mmcclock>;
		clock-names = "ciu";
		clock-phases = <135>;
	};

This would keep the phase setting out of the specific binding and
move it to the generic clock binding. In Linux we could implement
this either by making the mshc driver read the phase value and
call clock_set_phase() on it, or the common clock code could look
up the clock-phases property at the same time it looks up clock-names
and clocks, and set this behind the back of the driver.

	Arnd
