From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: [PATCH 1/3]: Support cpu frequency scaling and power management
 for iMX6SL
Date: Mon, 16 Dec 2013 18:37:14 -0800
Message-ID: <CACUGKYN_b0x4xg_Me3TXQGKEvz61SDZk4CFk5YHFnVCWT_6GPg@mail.gmail.com>
References: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Need some correction:

From: John Tobias <john.tobias.ph@gmail.com>


diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..6035e7e 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -38,6 +38,21 @@
                        device_type = "cpu";
                        reg = <0x0>;
                        next-level-cache = <&L2>;
+                       operating-points = <
+                               /* kHz    uV */
+                               1000000 1275000
+                               996000  1250000
+                               792000  1150000
+                               396000  950000
+                       >;
+                       clock-latency = <61036>; /* two CLK32 periods */
+                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
+                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
IMX6SL_CLK_PLL1_SYS>;
+                       clock-names = "arm", "pll2_pfd2_396m", "step",
+                                     "pll1_sw", "pll1_sys";
+                       arm-supply = <&reg_arm>;
+                       pu-supply = <&reg_pu>;
+                       soc-supply = <&reg_soc>;
                };
        };


On Mon, Dec 16, 2013 at 5:40 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> iMX6SL device tree doesn't have a configuration settings to enable the
> frequency scaling and power management.
>
> From: John Tobias <john.tobias.ph@gmail.com>
>
>
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 28558f1..0ad2f6a 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -38,6 +38,19 @@
>                         device_type = "cpu";
>                         reg = <0x0>;
>                         next-level-cache = <&L2>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               1000000 1275000
> +                               792000  1150000
> +                       >;
> +                       clock-latency = <61036>; /* two CLK32 periods */
> +                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
> IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
> +                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
> IMX6SL_CLK_PLL1_SYS>;
> +                       clock-names = "arm", "pll2_pfd2_396m", "step",
> +                                     "pll1_sw", "pll1_sys";
> +                       arm-supply = <&reg_arm>;
> +                       pu-supply = <&reg_pu>;
> +                       soc-supply = <&reg_soc>;
>                 };
>         };
