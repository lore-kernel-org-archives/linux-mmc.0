From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv4 1/4] arm: dts: Add support for SD/MMC on SOCFPGA
Date: Thu, 5 Dec 2013 16:10:52 -0600
Message-ID: <1386281452.26656.8.camel@linux-builds1>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
	 <1386263677-7733-2-git-send-email-dinguyen@altera.com>
	 <201312052208.38342.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:10854
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab3LEWMe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 17:12:34 -0500
In-Reply-To: <201312052208.38342.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dinh.linux@gmail.com, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2013-12-05 at 22:08 +0100, Arnd Bergmann wrote:
> On Thursday 05 December 2013, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Re-use the "rockchip,rk2928-dw-mshc" binding that will support SD/MMC on
> > Altera's SOCFPGA platform.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > ---
> > v3: Re-use "rockchip,rk2928-dw-mshc" binding
> > v3: none
> > v2: none
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi          |   11 +++++++++++
> >  arch/arm/boot/dts/socfpga_arria5.dtsi   |   12 ++++++++++++
> >  arch/arm/boot/dts/socfpga_cyclone5.dtsi |   12 ++++++++++++
> >  arch/arm/boot/dts/socfpga_vt.dts        |   12 ++++++++++++
> >  4 files changed, 47 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f936476..3d9f01b 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -469,6 +469,17 @@
> >  			cache-level = <2>;
> >  		};
> >  
> > +		mmc: dwmmc0@ff704000 {
> > +			compatible = "rockchip,rk2928-dw-mshc";
> > +			reg = <0xff704000 0x1000>;
> > +			interrupts = <0 139 4>;
> > +			fifo-depth = <0x400>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
> > +			clock-names = "biu", "ciu";
> > +		};
> 
> 
> I think it's great that you can reuse the existing driver, but I'd recommend
> using a generic compatible string here in addition to one that identifies
> your specific implementation. You can list "rockchip,rk2928-dw-mshc" as
> well, but that is probably not necessary.
> 
> What I'd expect to see here is either
> 
> 	compatible = "altr,socfpga-dw-mshc", "rockchip,rk2928-dw-mshc", "snps,dw-mshc";
> 
> or 
> 
> 	compatible = "altr,socfpga-dw-mshc", "rockchip,rk2928-dw-mshc", "snps,dw-mshc";
> 
> 
> It's probably not too late to generalize the SDMMC_CMD_USE_HOLD_REG
> handling, which is currently the only difference between the generic
> "snps,dw-mshc" and the newer "rockchip,rk2928-dw-mshc" variant.

Ok, I will try to generalize the driver.

> 
> It's quite likely that all implementations should actually set
> SDMMC_CMD_USE_HOLD_REG (if both rockchips and altera set it) and you
> don't need to have any distinction in the dw_mmc-pltfm.c driver at all.
> 
> If it's actually needed on some but not others, you could add a binary
> DT property to tell the driver about it rather than keying it off of
> the compatible string. If it's needed only on older (or only on newer)
> versions of the dw-mshc design, it could be encoded as a version in the
> string, such as "snps,dw-mshc-1.234".

Perhaps Seungwon and Chris might have an opinion on this:

>From the Synopsys databook for this IP, using the SDMMC_CMD_USE_HOLD_REG
is not recommended for SDR104, SDR50 and DDR50 speed modes. For other
speeds, SDR12, and SDR25, it would be necessary to use
SDMMC_CMD_USE_HOLD_REG.

I am referencing v2.50a of the Synopsys DesignWare Cores Mobile Storage
Host Databook.

So I think a binary DT property should suffice?

Thanks,
Dinh
> 
> 	Arnd
> 



