From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Wed, 14 Mar 2012 14:30:13 +0800
Message-ID: <20120314063012.GB8494@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314054116.GD21337@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:44519
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030332Ab2CNG2Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 02:28:24 -0400
Content-Disposition: inline
In-Reply-To: <20120314054116.GD21337@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng <b29396@freescale.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, rob.herring@calxeda.com, cjb@laptop.org, rdunlap@xenotime.net, vinod.koul@linux.intel.com

On Wed, Mar 14, 2012 at 01:41:20PM +0800, Shawn Guo wrote:
> On Tue, Mar 13, 2012 at 11:23:51AM -0600, Grant Likely wrote:
> ...
> > > +	apb@80000000 {
> > > +		compatible = "simple-bus";
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		reg = <0x80000000 0x80000>;
> > > +		ranges;
> > > +
> > > +		apbh@80000000 {
> > > +			compatible = "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x80000000 0x3c900>;
> > > +			ranges;
> > > +
> > > +			icoll: interrupt-controller@80000000 {
> > > +				compatible = "fsl,imx28-icoll";
> > > +				interrupt-controller;
> > > +				#interrupt-cells = <1>;
> > > +				reg = <0x80000000 0x2000>;
> > > +			};
> > > +		};
> > > +
> > > +		apbx@80040000 {
> > > +			compatible = "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x80040000 0x40000>;
> > > +			ranges;
> > > +
> > > +			uart1: uart@80074000 {
> > > +				compatible = "arm,pl011", "arm,primecell";
> > > +				reg = <0x80074000 0x2000>;
> > > +				interrupts = <47>;
> > > +			};
> > > +		};
> > 
> > What is the purpose of the apbh and apbx busses?  Will more device nodes
> > get added to them later, or does each only contain a single device?
> > 
> Since our ultimate goal is to convert mach-mxs over to device tree,
> I would also suggest we have all the hardware blocks defined in dts
> from the beginning.
> 
Also agree.
Will add them all in later patches.

Regards
Dong Aisheng

