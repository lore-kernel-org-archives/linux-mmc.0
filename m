From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Thu, 22 Dec 2016 11:47:47 +0100
Message-ID: <20161222114747.734faa50@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
        <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
        <20161222104502.GV14217@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46430 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbcLVKrv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 05:47:51 -0500
In-Reply-To: <20161222104502.GV14217@n2100.armlinux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello,

On Thu, 22 Dec 2016 10:45:02 +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 13, 2016 at 06:48:40PM +0100, Gregory CLEMENT wrote:
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > index 7b6136182ad0..181e8c5de3bf 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > @@ -229,6 +229,15 @@
> >  
> >  			};
> >  
> > +			ap_sdhci0: sdhci@6e0000 {
> > +				compatible = "marvell,armada-7000-sdhci";
> > +				reg = <0x6e0000 0x300>;
> > +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > +				clock-names = "core";
> > +				clocks = <&cpm_syscon0 1 4>;  
> 
> This seems to be the wrong clock - how can the AP SDHCI core be connected
> to the CPM syscon (which is on a different die.)

Agreed. This cannot be the right clock.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
