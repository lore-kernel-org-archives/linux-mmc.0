From: Haibo Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Wed, 30 Mar 2016 09:07:21 +0000
Message-ID: <HE1PR0401MB180138D15E4D2101330543DC90980@HE1PR0401MB1801.eurprd04.prod.outlook.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
 <1458587912-32665-2-git-send-email-broonie@kernel.org>
 <56F0624C.8010004@gmail.com>
 <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
 <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
 <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
 <20160327090859.GH5028@sirena.org.uk>
 <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
 <20160329145823.GK2350@sirena.org.uk>
 <CAMuHMdXx_=LzH7w+9u=o3WZ-qVPqMA2LDCeanvdGs-ywXRCy_A@mail.gmail.com>
 <20160329182725.GD2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-am1on0071.outbound.protection.outlook.com ([157.56.112.71]:46310
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751954AbcC3Jk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 05:40:28 -0400
In-Reply-To: <20160329182725.GD2350@sirena.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Brown,

I also meet the similar issue on i.MX6 platforms.

With your patch   ---> regulator: core: Ensure we are at least in bounds for our constraints
When I insert an SD3.0 card, shows the following log:

root@imx6qdlsolo:~# [   59.733941] sdhci-esdhc-imx 2190000.usdhc: could not set regulator OCR (-22)
[   60.829911] sdhci-esdhc-imx 2190000.usdhc: could not set regulator OCR (-22)
[   61.917951] sdhci-esdhc-imx 2190000.usdhc: could not set regulator OCR (-22)
[   63.009498] sdhci-esdhc-imx 2190000.usdhc: could not set regulator OCR (-22)

I did a quick debug, and find when I change the operator   &&  to  !=  , this issue gone.
-       if (constraints->min_uV != constraints->max_uV) {
+       if (constraints->min_uV && constraints->max_uV) {


In our sdhci.c, we call the function 
regulator_set_voltage ---> regulator_set_voltage_unlocked(struct regulator *regulator, int min_uV, int max_uV)
here, the parameter min_uV is 3300000, and the max_uV is 3400000

currently with your patch (the upper operator is &&), when insert a SD3.0 card, 
it will do the sanity check, and return -EINVAL

but when I change the upper operator from && to !=, 
before the sanity check, it will first get the current_uV, and then go to out.

I'm not familiar with regulator common code. Hope the upper describe can help you debug this issue.

The following attach our dts piece code.

126 &usdhc1 {
127         pinctrl-names = "default", "state_100mhz", "state_200mhz";
128         pinctrl-0 = <&pinctrl_usdhc1>;
129         pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
130         pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
131         cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
132         keep-power-in-suspend;
133         wakeup-source;
134         vmmc-supply = <&reg_sd1_vmmc>;
135         status = "okay";
136 };

regulators {
 26                 compatible = "simple-bus";
 27                 #address-cells = <1>;
 28                 #size-cells = <0>;
 29
 30                 reg_sd1_vmmc: sd1_regulator {
 31                         compatible = "regulator-fixed";
 32                         regulator-name = "VSD_3V3";
 33                         regulator-min-microvolt = <3300000>;
 34                         regulator-max-microvolt = <3300000>;
 35                         gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 36                         enable-active-high;
 37                 };
 38         };

Best Regards
Haibo Chen



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Wednesday, March 30, 2016 2:27 AM
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Bjorn Andersson <bjorn@kryo.se>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>;
> Liam Girdwood <lgirdwood@gmail.com>; linux-kernel@vger.kernel.org; Ulf
> Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-mmc@vger.kernel.org>;
> linux-samsung-soc <linux-samsung-soc@vger.kernel.org>; Javier Martinez
> Canillas <javier@osg.samsung.com>; Marek Szyprowski
> <m.szyprowski@samsung.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
> our constraints
> 
> On Tue, Mar 29, 2016 at 08:05:34PM +0200, Geert Uytterhoeven wrote:
> 
> >         sh_mobile_sdhi ee100000.sd: Got WP GPIO ======> sh_mobile_sdhi
> > ee100000.sd: could not set regulator OCR (-22)
> >         gpio_rcar e6055400.gpio: sense irq = 6, type = 3
> >         sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate
> > 97 MHz
> 
> > The line marked with the arrow is introduced by the changed check, and
> > looks to be the origin of the failure.
> 
> This isn't making any sense.  Why would a change in how we apply voltage
> constraints on initial probe of the regulator have an impact here?  The changed
> code shouldn't even be executing at the point where the SDHCI driver is trying
> to use the regulator.  There's something else going on here.
