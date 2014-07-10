From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCHv3 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Thu, 10 Jul 2014 22:10:00 +0900
Message-ID: <021601cf9c40$42da0c60$c88e2520$@samsung.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
 <1404976119-10777-6-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFoQ_ER7FAk_jCBURAa3_hVT25GXfQQfiDhMoYypdA=fHg@mail.gmail.com>
 <53BE5F9F.6070809@samsung.com>
 <CAPDyKFrLJJn=SGpjtCq+x88EetBQQBCqgef9z9+3oEVut4upTg@mail.gmail.com>
 <002101cf9c35$8da5b240$a8f116c0$%jun@samsung.com>
 <CAPDyKFo4gC8Mmbt+f88EMqGvPH9hqW4Fw9d05hq3YGB=iFgaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39686 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbaGJNKF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 09:10:05 -0400
In-reply-to: <CAPDyKFo4gC8Mmbt+f88EMqGvPH9hqW4Fw9d05hq3YGB=iFgaXw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>, devicetree@vger.kernel.org, =?UTF-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, dinguyen@altera.com, 'Mark Rutland' <mark.rutland@arm.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Ulf Hansson wrote:
> 
> On 10 July 2014 13:53, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Thu, July 10, 2014, Ulf Hansson wrote:
> >> On 10 July 2014 11:40, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> > Hi, Ulf.
> >> >
> >> > On 07/10/2014 06:15 PM, Ulf Hansson wrote:
> >> >> On 10 July 2014 09:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> >>> Replaced the "disable-wp" into host's quirks.
> >> >>> (Because the slot-node is removed at dt-file.)
> >> >>>
> >> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> >>
> >> >> Hi Jaehoon,
> >> >>
> >> >> I plan to carry these patches through my mmc tree and I will share
> >> >> them through a PR from an immutable branch with the ARM SoC guys.
> >> >> Please tell me if you have any concern with this set up.
> >>
> >> Hmm, I having a second thought around this. Could I just apply the mmc
> >> patches for my next branch instead of involving ARM SoC? In other
> >> words, are there any decencies? If not, I might just apply patch 1 and
> >> 5.
> >>
> >
> > [PATCHv4 2/5] ARM: dts: exynos: unuse the slot-node and deprecated the supports-highspeed for dw-mmc
> > [PATCHv4 4/5] ARM: dts: rockchip: unuse the slot-node and deprecated the supports-highspeed for dw-
> mmc
> > [PATCHv4 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk
> >
> > 2nd and 4th are closely related 5th.
> > I think it shall be picked together. How about taking whole patch?
> > And I hope that it is applied for 3.16-rcX fix.
> > (Also, 3rd patch is close to fix patch.)
> >
> > Kukjin,
> > Is it fine to be taken in Ulf's?
> 
> I tried applied the complete patchset for 3.16 rc4, but some of the
> DTS patches fails. What are these patches based upon?
> 
> I wonder if it's not best to leave all these for Kukjin to handle
> instead. You have my ack for all of the mmc patches!
> 
Hi, Ulf

For exynos DT:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

And you may take following change on top of v3.16-rc4 cleanly. BTW it should be
merged into 3.16 so that I could avoid useless merge conflicts for 3.17.

Note that this patch doesn't make any conflicts with my for-next for 3.17.

Thanks,
Kukjin

----------------

From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv4 2/5] ARM: dts: remove the slot-node and deprecated the supports-highspeed for dw-mmc for exynos

dw-mmc controller can support multiple slots. But, there are no use-cases
anywhere. So we don't need to support the slot-node for dw-mmc controller.
And "supports-highspeed" property in dw-mmc is deprecated.
"supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts      |    8 ++------
 arch/arm/boot/dts/exynos4412-origen.dts       |    8 ++------
 arch/arm/boot/dts/exynos4412-trats2.dts       |    8 ++------
 arch/arm/boot/dts/exynos5250-arndale.dts      |   18 +++++------------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |   26 +++++++------------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |   18 +++++------------
 arch/arm/boot/dts/exynos5250-snow.dts         |    6 ++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts    |   18 +++++------------
 arch/arm/boot/dts/exynos5410-smdk5410.dts     |   18 +++++------------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   16 ++++-----------
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   16 ++++-----------
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   16 ++++-----------
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   16 ++++-----------
 13 files changed, 51 insertions(+), 141 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 31db28a..778aec6 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -45,17 +45,13 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	regulator_p3v3 {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e925c9f..de15114 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -137,17 +137,13 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	codec@13400000 {
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 7787844..65ab885 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -520,7 +520,6 @@
 
 	mmc@12550000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		non-removable;
 		card-detect-delay = <200>;
@@ -532,11 +531,8 @@
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		status = "okay";
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	serial@13800000 {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index d0de1f5..42a3590 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -401,7 +401,6 @@
 	mmc_0: mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -410,17 +409,13 @@
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc_2: mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
@@ -428,12 +423,9 @@
 		vmmc-supply = <&mmc_reg>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
+		bus-width = <4>;
+		disable-wp;
+		cap-sd-highspeed;
 	};
 
 	i2s0: i2s@03830000 {
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 89ac90f..af51361 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -248,7 +248,6 @@
 
 	mmc@12200000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -256,44 +255,33 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			wp-gpios = <&gpc2 1 0>;
-		};
+		bus-width = <4>;
+		wp-gpios = <&gpc2 1 0>;
+		cap-sd-highspeed;
 	};
 
 	mmc@12230000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		/* See board-specific dts files for pin setup */
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <4>;
+		cap-sd-highspeed;
 	};
 
 	spi_1: spi@12d30000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..e00ffc6 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -282,7 +282,6 @@
 	mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -290,29 +289,22 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
+		bus-width = <4>;
+		disable-wp;
+		cap-sd-highspeed;
 	};
 
 	spi_1: spi@12d30000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index c682c88..851bf06 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -240,10 +240,8 @@
 	 */
 	mmc@12230000 {
 		status = "okay";
-		slot@0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
 	};
 
 	i2c@12CD0000 {
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 8c84ab2..a803b60 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -69,7 +69,7 @@
 	num-slots = <1>;
 	broken-cd;
 	bypass-smu;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	supports-hs200-mode; /* 200 Mhz */
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -77,27 +77,19 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 7275bbd..be3e025 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -40,33 +40,25 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 434fd9d..29dd71b 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -50,7 +50,6 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
@@ -58,16 +57,12 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 		vmmc-supply = <&ldo10_reg>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
@@ -75,11 +70,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 		vmmc-supply = <&ldo10_reg>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <4>;
+		cap-mmc-highspeed;
 	};
 
 	hsi2c_4: i2c@12CA0000 {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 6c7cab0..dcbf429 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -175,7 +175,7 @@
 	num-slots = <1>;
 	broken-cd;
 	caps2-mmc-hs200-1_8v;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
@@ -184,17 +184,13 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -202,11 +198,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
+	bus-width = <4>;
 };
 
 &hsi2c_7 {
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6052aa9..8be3d7b 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -76,34 +76,26 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
 		samsung,dw-mshc-ddr-timing = <0 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
 	};
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
+		bus-width = <4>;
+		cap-sd-highspeed;
 	};
 
 	dp-controller@145B0000 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 28f2a25..f73a385 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -173,7 +173,7 @@
 	num-slots = <1>;
 	broken-cd;
 	caps2-mmc-hs200-1_8v;
-	supports-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
@@ -182,17 +182,13 @@
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
+	bus-width = <8>;
 };
 
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <3>;
@@ -200,11 +196,7 @@
 	samsung,dw-mshc-ddr-timing = <1 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
+	bus-width = <4>;
 };
 
 &dp {
-- 
1.7.9.5

