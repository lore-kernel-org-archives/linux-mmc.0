From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv9 1/4] clk: socfpga: Add a clk-phase property to the "altr,
 socfpga-gate-clk"
Date: Fri, 10 Jan 2014 20:00:25 +0100
Message-ID: <201401102000.25484.arnd@arndb.de>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
 <003501cf0e06$9c194c50$d44be4f0$%jun@samsung.com>
 <1389369111.13556.29.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389369111.13556.29.camel@linux-builds1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: devicetree@vger.kernel.org, dinh.linux@gmail.com, heiko@sntech.de, bzhao@marvell.com, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, dianders@chromium.org, jh80.chung@samsung.com, alim.akhtar@samsung.com, zhangfei.gao@linaro.org, mturquette@linaro.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Friday 10 January 2014, Dinh Nguyen wrote:
> > > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > > index f936476..e776512 100644
> > > --- a/arch/arm/boot/dts/socfpga.dtsi
> > > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > > @@ -413,6 +413,7 @@
> > >                                             compatible = "altr,socfpga-gate-clk";
> > >                                             clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>,
> > > <&per_nand_mmc_clk>;
> > >                                             clk-gate = <0xa0 8>;
> > > +                                           clk-phase = <0 135>;
> > 
> > Can clk-phase be applicable commonly for various board?
> > Isn't specific timing values?
> 
> No, the clock-phase does not change for various board. It is a
> SoC-specific property.

I'm curious about this: If the setting is fixed per soc, why is it even
configurable, rather than hardwired to the correct setting, or set up
by the boot loader?

	Arnd
