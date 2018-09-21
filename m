From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect
 sd-card
Date: Fri, 21 Sep 2018 23:09:00 +0200
Message-ID: <20180921210900.GA12384@kozik-lap>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
 <20180920175826.1284-6-linux.amoon@gmail.com>
 <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
 <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2018 at 06:01:07PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Fri, 21 Sep 2018 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > add the Write Protect GPIO property for sdcard, to fix
> > > the warning message during boot time.
> > > of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > New patch to this series.
> > > If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> > > ---
> > >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > index 03fe02ceae66..475c38bbc99e 100644
> > > --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > @@ -370,6 +370,7 @@
> > >         cap-sd-highspeed;
> > >         max-frequency = <200000000>;
> > >         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> > > +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
> >
> > Two issues here:
> > 1. You need also proper pinctrl setting.
> 
> Thanks for pointing out. Yes proper pinctrl is needed to support this setting.
> probably pinctrl sd2_wp is needed to support this feature.
> 
> > 2. On schematics the WP is not connected... so how do you know that it
> From XU4_MAIN_REV0.1 schematics page 7 "Micro Socket" their is no
> connection to WP pin.
> but below schematics page "EXYNOS 5422 MMC UFS" it's shows
> XMMC2WP/GPC4_0/EXT_INT13_0.
> 
> > is active high? How did you test it? How do you want to test it on
> > microSD?
> 
> I just tested this with the DTS change to GPIO_ACTIVE_LOW which
> resulted the microSD card booted into RO mode.
> So I set this to GPIO_ACTIVE_HIGH just to avoid warning.
> 
> I will study the changes requires and then post proper separate patch
> to support this feature.

Please squash it with cd-gpios change and send it only for the purpose
of describing the hardware. They do not have any meaningful change from
functional point of view (maybe except slower code as now it goes
through gpio subsystem instead of just reading dw-mmc registers).

Please use full sentences in commit msg (so start with capital letter)
and remove reference for warning because there is no warning.
You can follow up on my change for XU:
https://patchwork.kernel.org/patch/10610985/

Best regards,
Krzysztof
