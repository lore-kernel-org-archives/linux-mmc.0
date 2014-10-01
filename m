From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
Date: Wed, 01 Oct 2014 16:00:34 +0200
Message-ID: <1831792.g28ajrp9B5@amdc1032>
References: <01.09.14890.83F4B245@epcpsbge5.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <01.09.14890.83F4B245@epcpsbge5.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: yuvaraj.cd@samsung.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, cpgs@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Doug Anderson <dianders@google.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-mmc@vger.kernel.org


Hi,

On Wednesday, October 01, 2014 12:47:52 AM YUVARAJ CD wrote:

> Since I am out of station, i dont have an access to my work set up.
> Can you send me the dts entries of sd crad and their corresponding regulator entries?

>From arch/arm/boot/dts/exynos5420-arndale-octa.dts:

...
        mmc@12200000 {
                status = "okay";
                broken-cd;
                supports-highspeed;
                card-detect-delay = <200>;
                samsung,dw-mshc-ciu-div = <3>;
                samsung,dw-mshc-sdr-timing = <0 4>;
                samsung,dw-mshc-ddr-timing = <0 2>;
                pinctrl-names = "default";
                pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
                vmmc-supply = <&ldo10_reg>;

                slot@0 {
                        reg = <0>;
                        bus-width = <8>;
                };
        };

        mmc@12220000 {
                status = "okay";
                supports-highspeed;
                card-detect-delay = <200>;
                samsung,dw-mshc-ciu-div = <3>;
                samsung,dw-mshc-sdr-timing = <2 3>;
                samsung,dw-mshc-ddr-timing = <1 2>;
                pinctrl-names = "default";
                pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
                vmmc-supply = <&ldo10_reg>;

                slot@0 {
                        reg = <0>;
                        bus-width = <4>;
                };
        };
...
                                ldo10_reg: LDO10 {
                                        regulator-name = "PVDD_PRE_1V8";
                                        regulator-min-microvolt = <1800000>;
                                        regulator-max-microvolt = <1800000>;
                                        regulator-always-on;
                                };
...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
