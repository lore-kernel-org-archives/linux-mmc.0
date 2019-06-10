From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 4/7] arm64: dts: actions: Add uSD and eMMC support for
 Bubblegum96
Date: Mon, 10 Jun 2019 21:41:28 +0530
Message-ID: <20190610161128.GC31461@mani>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-5-manivannan.sadhasivam@linaro.org>
 <1381305a-8585-9dcf-6b43-34e852e785ab@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381305a-8585-9dcf-6b43-34e852e785ab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


Hi Andreas,

On Mon, Jun 10, 2019 at 04:08:26PM +0200, Andreas Färber wrote:
> Hi Mani,
> 
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
> > Owl SoC.
> 
> What information does "based on Actions Semi Owl SoC" give us? :)
> The board name should be unique enough - Owl is a family of SoCs,
> "actions:" is in the subject and "s900-" is in the filename.
> 

Makes sense!

> > SD0 is connected to uSD slot and SD2 is connected to eMMC.
> 
> Suggest to add that as comments above the two nodes instead.
> 

Okay.

> > Since there is no PMIC support added yet, fixed regulator has been
> > used as a regulator node.
> 
> Fine with me - maybe add a comment and make sure it's aligned with the
> schematics naming wrt PMIC.
> 

Okay.

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../boot/dts/actions/s900-bubblegum-96.dts    | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > index 732daaa6e9d3..3b596d72de25 100644
> > --- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > +++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> > @@ -13,6 +13,9 @@
> >  
> >  	aliases {
> >  		serial5 = &uart5;
> > +		mmc0 = &mmc0;
> > +		mmc1 = &mmc1;
> > +		mmc2 = &mmc2;
> 
> Sort them alphabetically?
> 

Ack.

> >  	};
> >  
> >  	chosen {
> > @@ -23,6 +26,14 @@
> >  		device_type = "memory";
> >  		reg = <0x0 0x0 0x0 0x80000000>;
> >  	};
> > +
> > +	reg_3p1v: regulator-3p1v {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "fixed-3.1V";
> > +		regulator-min-microvolt = <3100000>;
> > +		regulator-max-microvolt = <3100000>;
> > +		regulator-always-on;
> > +	};
> >  };
> >  
> >  &i2c0 {
> > @@ -241,6 +252,45 @@
> >  			bias-pull-up;
> >  		};
> >  	};
> > +
> > +	mmc0_default: mmc0_default {
> > +		pinmux {
> > +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> > +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> > +			function = "sd0";
> > +		};
> > +	};
> > +
> > +	mmc2_default: mmc2_default {
> > +		pinmux {
> > +			groups = "nand0_d0_ceb3_mfp";
> > +			function = "sd2";
> > +		};
> > +	};
> 
> Wouldn't it make more sense to move these and the below pinctrl-* to
> s900.dtsi for sharing with other theoretical boards? I really dislike
> the imx model where pin muxing is duplicated into each individual board.
> 

Matter of taste. IMO pinctrl config belongs to the board design and I don't
wanna dump all combinations in the soc dtsi.

Thanks,
Mani

> Regards,
> Andreas
> 
> > +};
> > +
> > +&mmc0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc0_default>;
> > +	no-sdio;
> > +	no-mmc;
> > +	no-1-8-v;
> > +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> > +	bus-width = <4>;
> > +	vmmc-supply = <&reg_3p1v>;
> > +	vqmmc-supply = <&reg_3p1v>;
> > +};
> > +
> > +&mmc2 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc2_default>;
> > +	no-sdio;
> > +	no-sd;
> > +	non-removable;
> > +	bus-width = <8>;
> > +	vmmc-supply = <&reg_3p1v>;
> >  };
> >  
> >  &timer {
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
