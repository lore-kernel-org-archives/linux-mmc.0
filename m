From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v4 16/26] docs: Fix more broken references
Date: Fri, 15 Jun 2018 18:41:02 +0200
Message-ID: <CANiq72=g9wjB2OhW0btcDN+dD-VwNFEhbBxAXpSAgCNqm4QnAQ@mail.gmail.com>
References: <cover.1529079119.git.mchehab+samsung@kernel.org> <48f1131d560eba1d0758e3a7714593f1d878d3de.1529079120.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <48f1131d560eba1d0758e3a7714593f1d878d3de.1529079120.git.mchehab+samsung@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-hwmon@vger.kernel.org, intel-wired-lan@lists.osuosl.org, alsa-devel@alsa-project.org, linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 15, 2018 at 6:30 PM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix
>
> Manually checked that produced results are valid.
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../bindings/clock/st/st,clkgen.txt           |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt     |  2 +-
>  .../bindings/clock/ti/interface.txt           |  2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt     |  2 +-
>  .../bindings/devfreq/rk3399_dmc.txt           |  2 +-
>  .../bindings/gpu/arm,mali-midgard.txt         |  2 +-
>  .../bindings/gpu/arm,mali-utgard.txt          |  2 +-
>  .../devicetree/bindings/mfd/mt6397.txt        |  2 +-
>  .../devicetree/bindings/mfd/sun6i-prcm.txt    |  2 +-
>  .../bindings/mmc/exynos-dw-mshc.txt           |  2 +-
>  .../devicetree/bindings/net/dsa/ksz.txt       |  2 +-
>  .../devicetree/bindings/net/dsa/mt7530.txt    |  2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt |  2 +-
>  .../bindings/power/wakeup-source.txt          |  2 +-
>  .../devicetree/bindings/usb/rockchip,dwc3.txt |  2 +-
>  Documentation/hwmon/ina2xx                    |  2 +-
>  Documentation/maintainer/pull-requests.rst    |  2 +-
>  Documentation/translations/ko_KR/howto.rst    |  2 +-
>  MAINTAINERS                                   | 20 +++++++++----------
>  drivers/net/ethernet/intel/Kconfig            |  8 ++++----
>  drivers/soundwire/stream.c                    |  8 ++++----
>  fs/Kconfig.binfmt                             |  2 +-
>  fs/binfmt_misc.c                              |  2 +-
>  23 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/D=
ocumentation/devicetree/bindings/clock/st/st,clkgen.txt
> index 7364953d0d0b..45ac19bfa0a9 100644
> --- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> +++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> @@ -31,10 +31,10 @@ This binding uses the common clock binding[1].
>  Each subnode should use the binding described in [2]..[7]
>
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[3] Documentation/devicetree/bindings/clock/st,clkgen-mux.txt
> -[4] Documentation/devicetree/bindings/clock/st,clkgen-pll.txt
> -[7] Documentation/devicetree/bindings/clock/st,quadfs.txt
> -[8] Documentation/devicetree/bindings/clock/st,flexgen.txt
> +[3] Documentation/devicetree/bindings/clock/st/st,clkgen-mux.txt
> +[4] Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
> +[7] Documentation/devicetree/bindings/clock/st/st,quadfs.txt
> +[8] Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>
>
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Docume=
ntation/devicetree/bindings/clock/ti/gate.txt
> index 03f8fdee62a7..56d603c1f716 100644
> --- a/Documentation/devicetree/bindings/clock/ti/gate.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
> @@ -10,7 +10,7 @@ will be controlled instead and the corresponding hw-ops=
 for
>  that is used.
>
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> +[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
>  [3] Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/D=
ocumentation/devicetree/bindings/clock/ti/interface.txt
> index 3111a409fea6..3f4704040140 100644
> --- a/Documentation/devicetree/bindings/clock/ti/interface.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
> @@ -9,7 +9,7 @@ companion clock finding (match corresponding functional g=
ate
>  clock) and hardware autoidle enable / disable.
>
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> +[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
>
>  Required properties:
>  - compatible : shall be one of:
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.t=
xt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index d36f07e0a2bb..0551c78619de 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -8,7 +8,7 @@ Required properties:
>         "intermediate"  - A parent of "cpu" clock which is used as "inter=
mediate" clock
>                           source (usually MAINPLL) when the original CPU =
PLL is under
>                           transition and not stable yet.
> -       Please refer to Documentation/devicetree/bindings/clk/clock-bindi=
ngs.txt for
> +       Please refer to Documentation/devicetree/bindings/clock/clock-bin=
dings.txt for
>         generic clock consumer properties.
>  - operating-points-v2: Please refer to Documentation/devicetree/bindings=
/opp/opp.txt
>         for detail.
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/D=
ocumentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index d6d2833482c9..fc2bcbe26b1e 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,7 +12,7 @@ Required properties:
>  - clocks:               Phandles for clock specified in "clock-names" pr=
operty
>  - clock-names :                 The name of clock used by the DFI, must =
be
>                          "pclk_ddr_mon";
> -- operating-points-v2:  Refer to Documentation/devicetree/bindings/power=
/opp.txt
> +- operating-points-v2:  Refer to Documentation/devicetree/bindings/opp/o=
pp.txt
>                          for details.
>  - center-supply:        DMC supply node.
>  - status:               Marks the node enabled/disabled.
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b=
/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 039219df05c5..18a2cde2e5f3 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -34,7 +34,7 @@ Optional properties:
>  - mali-supply : Phandle to regulator for the Mali device. Refer to
>    Documentation/devicetree/bindings/regulator/regulator.txt for details.
>
> -- operating-points-v2 : Refer to Documentation/devicetree/bindings/power=
/opp.txt
> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/o=
pp.txt
>    for details.
>
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/=
Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index c1f65d1dac1d..63cd91176a68 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -44,7 +44,7 @@ Optional properties:
>
>    - memory-region:
>      Memory region to allocate from, as defined in
> -    Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.tx=
t
>
>    - mali-supply:
>      Phandle to regulator for the Mali device, as defined in
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documenta=
tion/devicetree/bindings/mfd/mt6397.txt
> index d1df77f4d655..0ebd08af777d 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -12,7 +12,7 @@ MT6397/MT6323 is a multifunction device with the follow=
ing sub modules:
>  It is interfaced to host controller using SPI interface by a proprietary=
 hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwr=
ap.
>  See the following for pwarp node definitions:
> -Documentation/devicetree/bindings/soc/pwrap.txt
> +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
>
>  This document describes the binding for MFD device and its sub module.
>
> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Docum=
entation/devicetree/bindings/mfd/sun6i-prcm.txt
> index dd2c06540485..4d21ffdb0fc1 100644
> --- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> @@ -9,7 +9,7 @@ Required properties:
>
>  The prcm node may contain several subdevices definitions:
>   - see Documentation/devicetree/clk/sunxi.txt for clock devices
> - - see Documentation/devicetree/reset/allwinner,sunxi-clock-reset.txt fo=
r reset
> + - see Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-res=
et.txt for reset
>     controller devices
>
>
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/D=
ocumentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index a58c173b7ab9..0419a63f73a0 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -62,7 +62,7 @@ Required properties for a slot (Deprecated - Recommend =
to use one slot per host)
>    rest of the gpios (depending on the bus-width property) are the data l=
ines in
>    no particular order. The format of the gpio specifier depends on the g=
pio
>    controller.
> -(Deprecated - Refer to Documentation/devicetree/binding/pinctrl/samsung-=
pinctrl.txt)
> +(Deprecated - Refer to Documentation/devicetree/bindings/pinctrl/samsung=
-pinctrl.txt)
>
>  Example:
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/ksz.txt b/Document=
ation/devicetree/bindings/net/dsa/ksz.txt
> index fd23904ac68e..a700943218ca 100644
> --- a/Documentation/devicetree/bindings/net/dsa/ksz.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/ksz.txt
> @@ -6,7 +6,7 @@ Required properties:
>  - compatible: For external switch chips, compatible string must be exact=
ly one
>    of: "microchip,ksz9477"
>
> -See Documentation/devicetree/bindings/dsa/dsa.txt for a list of addition=
al
> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of addi=
tional
>  required and optional properties.
>
>  Examples:
> diff --git a/Documentation/devicetree/bindings/net/dsa/mt7530.txt b/Docum=
entation/devicetree/bindings/net/dsa/mt7530.txt
> index a9bc27b93ee3..aa3527f71fdc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mt7530.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/mt7530.txt
> @@ -31,7 +31,7 @@ Required properties for the child nodes within ports co=
ntainer:
>  - phy-mode: String, must be either "trgmii" or "rgmii" for port labeled
>          "cpu".
>
> -See Documentation/devicetree/bindings/dsa/dsa.txt for a list of addition=
al
> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of addi=
tional
>  required, optional properties and how the integrated switch subnodes mus=
t
>  be specified.
>
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Do=
cumentation/devicetree/bindings/power/fsl,imx-gpc.txt
> index b31d6bbeee16..726ec2875223 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -14,7 +14,7 @@ Required properties:
>    datasheet
>  - interrupts: Should contain one interrupt specifier for the GPC interru=
pt
>  - clocks: Must contain an entry for each entry in clock-names.
> -  See Documentation/devicetree/bindings/clocks/clock-bindings.txt for de=
tails.
> +  See Documentation/devicetree/bindings/clock/clock-bindings.txt for det=
ails.
>  - clock-names: Must include the following entries:
>    - ipg
>
> diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/=
Documentation/devicetree/bindings/power/wakeup-source.txt
> index 5d254ab13ebf..cfd74659fbed 100644
> --- a/Documentation/devicetree/bindings/power/wakeup-source.txt
> +++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
> @@ -22,7 +22,7 @@ List of legacy properties and respective binding docume=
nt
>  3. "has-tpo"                   Documentation/devicetree/bindings/rtc/rtc=
-opal.txt
>  4. "linux,wakeup"              Documentation/devicetree/bindings/input/g=
pio-matrix-keypad.txt
>                                 Documentation/devicetree/bindings/mfd/tc3=
589x.txt
> -                               Documentation/devicetree/bindings/input/a=
ds7846.txt
> +                               Documentation/devicetree/bindings/input/t=
ouchscreen/ads7846.txt
>  5. "linux,keypad-wakeup"       Documentation/devicetree/bindings/input/q=
com,pm8xxx-keypad.txt
>  6. "linux,input-wakeup"                Documentation/devicetree/bindings=
/input/samsung-keypad.txt
>  7. "nvidia,wakeup-source"      Documentation/devicetree/bindings/input/n=
vidia,tegra20-kbc.txt
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Do=
cumentation/devicetree/bindings/usb/rockchip,dwc3.txt
> index 50a31536e975..252a05c5d976 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> @@ -16,7 +16,7 @@ A child node must exist to represent the core DWC3 IP b=
lock. The name of
>  the node is not important. The content of the node is defined in dwc3.tx=
t.
>
>  Phy documentation is provided in the following places:
> -Documentation/devicetree/bindings/phy/rockchip,dwc3-usb-phy.txt
> +Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
>
>  Example device nodes:
>
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index cfd31d94c872..72d16f08e431 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -53,7 +53,7 @@ bus supply voltage.
>
>  The shunt value in micro-ohms can be set via platform data or device tre=
e at
>  compile-time or via the shunt_resistor attribute in sysfs at run-time. P=
lease
> -refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindin=
gs
> +refer to the Documentation/devicetree/bindings/hwmon/ina2xx.txt for bind=
ings
>  if the device tree is used.
>
>  Additionally ina226 supports update_interval attribute as described in
> diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/m=
aintainer/pull-requests.rst
> index a19db3458b56..22b271de0304 100644
> --- a/Documentation/maintainer/pull-requests.rst
> +++ b/Documentation/maintainer/pull-requests.rst
> @@ -41,7 +41,7 @@ named ``char-misc-next``, you would be using the follow=
ing command::
>
>  that will create a signed tag called ``char-misc-4.15-rc1`` based on the
>  last commit in the ``char-misc-next`` branch, and sign it with your gpg =
key
> -(see :ref:`Documentation/maintainer/configure_git.rst <configuregit>`).
> +(see :ref:`Documentation/maintainer/configure-git.rst <configuregit>`).
>
>  Linus will only accept pull requests based on a signed tag. Other
>  maintainers may differ.
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/t=
ranslations/ko_KR/howto.rst
> index 624654bdcd8a..a8197e072599 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -160,7 +160,7 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
>      =EB=8F=85=ED=8A=B9=ED=95=9C =ED=96=89=EB=8F=99=EC=97=90 =EA=B4=80=ED=
=95=98=EC=97=AC =ED=9D=94=ED=9E=88 =EC=9E=88=EB=8A=94 =EC=98=A4=ED=95=B4=EB=
=93=A4=EA=B3=BC =ED=98=BC=EB=9E=80=EB=93=A4=EC=9D=84 =ED=95=B4=EC=86=8C=ED=
=95=98=EA=B3=A0 =EC=9E=88=EA=B8=B0
>      =EB=95=8C=EB=AC=B8=EC=9D=B4=EB=8B=A4.
>
> -  :ref:`Documentation/process/stable_kernel_rules.rst <stable_kernel_rul=
es>`
> +  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rul=
es>`
>      =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94 =EC=95=88=EC=A0=95=EC=A0=81=EC=
=9D=B8 =EC=BB=A4=EB=84=90 =EB=B0=B0=ED=8F=AC=EA=B0=80 =EC=9D=B4=EB=A3=A8=EC=
=96=B4=EC=A7=80=EB=8A=94 =EA=B7=9C=EC=B9=99=EC=9D=84 =EC=84=A4=EB=AA=85=ED=
=95=98=EA=B3=A0 =EC=9E=88=EC=9C=BC=EB=A9=B0
>      =EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =EC=9D=B4=EB=9F=AC=ED=
=95=9C =EB=B0=B0=ED=8F=AC=EB=93=A4 =EC=A4=91 =ED=95=98=EB=82=98=EC=97=90 =
=EB=B3=80=EA=B2=BD=EC=9D=84 =ED=95=98=EA=B8=B8 =EC=9B=90=ED=95=9C=EB=8B=A4=
=EB=A9=B4
>      =EB=AC=B4=EC=97=87=EC=9D=84 =ED=95=B4=EC=95=BC =ED=95=98=EB=8A=94=EC=
=A7=80=EB=A5=BC =EC=84=A4=EB=AA=85=ED=95=9C=EB=8B=A4.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09554034be46..5871dd5060f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4513,7 +4513,7 @@ DRM DRIVER FOR ILITEK ILI9225 PANELS
>  M:     David Lechner <david@lechnology.com>
>  S:     Maintained
>  F:     drivers/gpu/drm/tinydrm/ili9225.c
> -F:     Documentation/devicetree/bindings/display/ili9225.txt
> +F:     Documentation/devicetree/bindings/display/ilitek,ili9225.txt
>
>  DRM DRIVER FOR INTEL I810 VIDEO CARDS
>  S:     Orphan / Obsolete
> @@ -4599,13 +4599,13 @@ DRM DRIVER FOR SITRONIX ST7586 PANELS
>  M:     David Lechner <david@lechnology.com>
>  S:     Maintained
>  F:     drivers/gpu/drm/tinydrm/st7586.c
> -F:     Documentation/devicetree/bindings/display/st7586.txt
> +F:     Documentation/devicetree/bindings/display/sitronix,st7586.txt
>
>  DRM DRIVER FOR SITRONIX ST7735R PANELS
>  M:     David Lechner <david@lechnology.com>
>  S:     Maintained
>  F:     drivers/gpu/drm/tinydrm/st7735r.c
> -F:     Documentation/devicetree/bindings/display/st7735r.txt
> +F:     Documentation/devicetree/bindings/display/sitronix,st7735r.txt
>
>  DRM DRIVER FOR TDFX VIDEO CARDS
>  S:     Orphan / Obsolete
> @@ -4824,7 +4824,7 @@ M:        Eric Anholt <eric@anholt.net>
>  S:     Supported
>  F:     drivers/gpu/drm/v3d/
>  F:     include/uapi/drm/v3d_drm.h
> -F:     Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
> +F:     Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>
>  DRM DRIVERS FOR VC4
> @@ -5735,7 +5735,7 @@ M:        Madalin Bucur <madalin.bucur@nxp.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/freescale/fman
> -F:     Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +F:     Documentation/devicetree/bindings/net/fsl-fman.txt
>
>  FREESCALE QORIQ PTP CLOCK DRIVER
>  M:     Yangbo Lu <yangbo.lu@nxp.com>
> @@ -7425,7 +7425,7 @@ M:        Linus Walleij <linus.walleij@linaro.org>
>  L:     linux-iio@vger.kernel.org
>  S:     Maintained
>  F:     drivers/iio/gyro/mpu3050*
> -F:     Documentation/devicetree/bindings/iio/gyroscope/inv,mpu3050.txt
> +F:     Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu305=
0.txt
>
>  IOC3 ETHERNET DRIVER
>  M:     Ralf Baechle <ralf@linux-mips.org>
> @@ -8700,7 +8700,7 @@ M:        Guenter Roeck <linux@roeck-us.net>
>  L:     linux-hwmon@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/hwmon/max6697
> -F:     Documentation/devicetree/bindings/i2c/max6697.txt
> +F:     Documentation/devicetree/bindings/hwmon/max6697.txt
>  F:     drivers/hwmon/max6697.c
>  F:     include/linux/platform_data/max6697.h
>
> @@ -9080,7 +9080,7 @@ M:        Martin Donnelly <martin.donnelly@ge.com>
>  M:     Martyn Welch <martyn.welch@collabora.co.uk>
>  S:     Maintained
>  F:     drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> -F:     Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx=
-ge-b850v3-fw.txt
> +F:     Documentation/devicetree/bindings/display/bridge/megachips-stdpxx=
xx-ge-b850v3-fw.txt
>
>  MEGARAID SCSI/SAS DRIVERS
>  M:     Kashyap Desai <kashyap.desai@broadcom.com>
> @@ -10728,7 +10728,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
>  M:     Willy Tarreau <willy@haproxy.com>
>  M:     Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>  S:     Odd Fixes
> -F:     Documentation/misc-devices/lcd-panel-cgram.txt
> +F:     Documentation/auxdisplay/lcd-panel-cgram.txt
>  F:     drivers/misc/panel.c
>

For Documentation/auxdisplay/lcd-panel-cgram.txt:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

>  PARALLEL PORT SUBSYSTEM
> @@ -13291,7 +13291,7 @@ M:      Vinod Koul <vkoul@kernel.org>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:     Supported
> -F:     Documentation/sound/alsa/compress_offload.txt
> +F:     Documentation/sound/designs/compress-offload.rst
>  F:     include/sound/compress_driver.h
>  F:     include/uapi/sound/compress_*
>  F:     sound/core/compress_offload.c
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/in=
tel/Kconfig
> index 14d287bed33c..1ab613eb5796 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -33,7 +33,7 @@ config E100
>           to identify the adapter.
>
>           More specific information on configuring the driver is in
> -         <file:Documentation/networking/e100.txt>.
> +         <file:Documentation/networking/e100.rst>.
>
>           To compile this driver as a module, choose M here. The module
>           will be called e100.
> @@ -49,7 +49,7 @@ config E1000
>           <http://support.intel.com>
>
>           More specific information on configuring the driver is in
> -         <file:Documentation/networking/e1000.txt>.
> +         <file:Documentation/networking/e1000.rst>.
>
>           To compile this driver as a module, choose M here. The module
>           will be called e1000.
> @@ -94,7 +94,7 @@ config IGB
>           <http://support.intel.com>
>
>           More specific information on configuring the driver is in
> -         <file:Documentation/networking/e1000.txt>.
> +         <file:Documentation/networking/e1000.rst>.
>
>           To compile this driver as a module, choose M here. The module
>           will be called igb.
> @@ -130,7 +130,7 @@ config IGBVF
>           <http://support.intel.com>
>
>           More specific information on configuring the driver is in
> -         <file:Documentation/networking/e1000.txt>.
> +         <file:Documentation/networking/e1000.rst>.
>
>           To compile this driver as a module, choose M here. The module
>           will be called igbvf.
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 8974a0fcda1b..4b5e250e8615 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1291,7 +1291,7 @@ static int _sdw_prepare_stream(struct sdw_stream_ru=
ntime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in de=
tail
>   */
>  int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1348,7 +1348,7 @@ static int _sdw_enable_stream(struct sdw_stream_run=
time *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in de=
tail
>   */
>  int sdw_enable_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1400,7 +1400,7 @@ static int _sdw_disable_stream(struct sdw_stream_ru=
ntime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in de=
tail
>   */
>  int sdw_disable_stream(struct sdw_stream_runtime *stream)
>  {
> @@ -1456,7 +1456,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_=
runtime *stream)
>   *
>   * @stream: Soundwire stream
>   *
> - * Documentation/soundwire/stream.txt explains this API in detail
> + * Documentation/driver-api/soundwire/stream.rst explains this API in de=
tail
>   */
>  int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  {
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 57a27c42b5ac..56df483de619 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -168,7 +168,7 @@ config BINFMT_MISC
>           will automatically feed it to the correct interpreter.
>
>           You can do other nice things, too. Read the file
> -         <file:Documentation/binfmt_misc.txt> to learn how to use this
> +         <file:Documentation/admin-guide/binfmt-misc.rst> to learn how t=
o use this
>           feature, <file:Documentation/admin-guide/java.rst> for informat=
ion about how
>           to include Java support. and <file:Documentation/admin-guide/mo=
no.rst> for
>            information about how to include Mono-based .NET support.
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 4de191563261..4b5fff31ef27 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 1997 Richard G=C3=BCnther
>   *
>   * binfmt_misc detects binaries via a magic or filename extension and in=
vokes
> - * a specified wrapper. See Documentation/binfmt_misc.txt for more detai=
ls.
> + * a specified wrapper. See Documentation/admin-guide/binfmt-misc.rst fo=
r more details.
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> --
> 2.17.1
>
