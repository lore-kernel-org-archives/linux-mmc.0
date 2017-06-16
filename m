From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: rockchip: add efuse device node for rk3228
Date: Fri, 16 Jun 2017 11:35:12 +0200
Message-ID: <2264017.eLNdPIXHd9@diego>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <2537345.MJmYY2BcSn@phil> <da5fbd76-c9a1-a16f-3ed8-adfd2b1c346f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <da5fbd76-c9a1-a16f-3ed8-adfd2b1c346f-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, charles.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kevan.lan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wmc-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Freitag, 16. Juni 2017, 17:24:23 CEST schrieb Frank Wang:
> Hi Heiko,
> 
> On 2017/6/15 23:10, Heiko Stuebner wrote:
> > Hi Frank,
> > 
> > Am Donnerstag, 15. Juni 2017, 15:23:16 CEST schrieb Frank Wang:
> >> From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >> 
> >> Add a efuse node in the device tree for the rk3228 SoC.
> >> 
> >> Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >> ---
> >> 
> >>   arch/arm/boot/dts/rk322x.dtsi | 17 +++++++++++++++++
> >>   1 file changed, 17 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/rk322x.dtsi
> >> b/arch/arm/boot/dts/rk322x.dtsi
> >> index c2a78f4..dad195e 100644
> >> --- a/arch/arm/boot/dts/rk322x.dtsi
> >> +++ b/arch/arm/boot/dts/rk322x.dtsi
> >> @@ -314,6 +314,23 @@
> >> 
> >>   		status = "disabled";
> >>   	
> >>   	};
> >> 
> >> +	efuse: efuse@11040000 {
> >> +		compatible = "rockchip,rk322x-efuse";
> > 
> > was this binding included already? Simply because compatibles should
> > not contain placeholders, so rockchip,rk3228-efuse please - same for
> > the driver side.
> 
> Actually, I always remember it should be without placeholders from the
> first time you commented :-)
> but I saw that the binding and driver (rockchip,rk322x-efuse) have
> already been applied, so I send this one keep the same with driver side.
> Shall I resend a new patch to correct both of them to
> 'rockchip,rk3228-efuse' ?

Yes please :-) .

As it was probably applied for 4.13, changing the compatible shouldn't be
a problem.


Thanks
Heiko

> 
> 
> BR.
> Frank
> 
> > Heiko
> > 
> >> +		reg = <0x11040000 0x20>;
> >> +		#address-cells = <1>;
> >> +		#size-cells = <1>;
> >> +		clocks = <&cru PCLK_EFUSE_256>;
> >> +		clock-names = "pclk_efuse";
> >> +
> >> +		/* Data cells */
> >> +		efuse_id: id@7 {
> >> +			reg = <0x7 0x10>;
> >> +		};
> >> +		cpu_leakage: cpu_leakage@17 {
> >> +			reg = <0x17 0x1>;
> >> +		};
> >> +	};
> >> +
> >> 
> >>   	i2c0: i2c@11050000 {
> >>   	
> >>   		compatible = "rockchip,rk3228-i2c";
> >>   		reg = <0x11050000 0x1000>;


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
