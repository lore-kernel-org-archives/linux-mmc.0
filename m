From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 8 Oct 2015 11:00:38 +0100
Message-ID: <20151008100038.GB32536@n2100.arm.linux.org.uk>
References: <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
 <20151007155206.GX23801@atomide.com>
 <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
 <5615A723.6090907@ti.com>
 <20151008084020.GY23801@atomide.com>
 <20151008093543.GA32536@n2100.arm.linux.org.uk>
 <20151008095635.GZ23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:47527 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbJHKAs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 06:00:48 -0400
Content-Disposition: inline
In-Reply-To: <20151008095635.GZ23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 08, 2015 at 02:56:36AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [151008 02:40]:
> > On Thu, Oct 08, 2015 at 01:40:21AM -0700, Tony Lindgren wrote:
> > > Well the way distros deal with issues like this is have everything
> > > possible as loadable modules. We should get the regulator_pbiaa
> > > loaded automatically in that case as long as it's in the dts.. And
> > > as long as we have the MODULE_DEVICE_TABLE entries right.
> > 
> > Assuming you have a rootfs which doesn't depend on one of those modules,
> > or an initramfs, and a way to get the built modules into that initial
> > filesystem.  Automated test boot systems do not have that luxury: the
> > generation of initramfs is distro specific, and would be very large if
> > it were to include all possible modules.
> 
> Right, we need to keep the kernel usable in all these configurations
> somehow.
> 
> For the kernel generated minimal initramfs we could grep for the
> needed modules in the dts file.

Yes, you might be able to do that, but the only thing that can generate
the initramfs is the target system itself, or a similar target system.
For example, you can't sanely generate an initramfs for an ARM Ubuntu
system on an x86 Fedora host.

Distros have the luxury of always being able to do the initramfs
generation on the target system at installation or distro kernel update
time.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
