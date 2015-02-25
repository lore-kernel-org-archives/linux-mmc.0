From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Wed, 25 Feb 2015 11:02:43 +0100
Message-ID: <54ED9DC3.4070601@collabora.co.uk>
References: <1424464316-4397-1-git-send-email-dianders@chromium.org>	<54EB5658.6080004@collabora.co.uk>	<CAD=FV=Uc+x=qAEmUwJ=ifq0n=5TqDuwmOAnFQ30gkz2GOdVcUQ@mail.gmail.com>	<54EC5E70.40300@collabora.co.uk> <CAD=FV=WqbOWQtFCXe+2wOpHOB1puu0p01jbVBpwufg_9M65Crw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WqbOWQtFCXe+2wOpHOB1puu0p01jbVBpwufg_9M65Crw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Doug,

On 02/25/2015 06:43 AM, Doug Anderson wrote:
> 
> OK, so looking through things I _think_ I found another difference
> that _might_ matter...
>

Yes it does! when adding the "sd1_bus1" the slot pinctrl I do have
the WiFi module working, thanks a lot for your help!
 
> Upstream (arch/arm/boot/dts/exynos5420-pinctrl.dtsi):
>                 sd1_bus1: sd1-bus-width1 {
>                         samsung,pins = "gpc1-3";
>                         ...
>                 };
> 
>                 sd1_bus4: sd1-bus-width4 {
>                         samsung,pins = "gpc1-4", "gpc1-5", "gpc1-6";
>                         ...
>                };
> 
>                 sd1_bus8: sd1-bus-width8 {
>                         samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
>                         ...
>                };
> 
> Upsttream (arch/arm/boot/dts/exynos5420-peach-pit.dts) -- your patch:
>        pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus4>,
>                    <&sd1_bus8>, <&wifi_en>, <&wifi_rst>;
> 
> Downstream (arch/arm/boot/dts/exynos542x-pinctrl.dtsi):
>                 sd1_bus1: sd1-bus-width1 {
>                         samsung,pins = "gpc1-3";
>                         ...
>                };
> 
>                 sd1_bus4: sd1-bus-width4 {
>                         samsung,pins = "gpc1-3", "gpc1-4", "gpc1-5", "gpc1-6";
>                         ...
>                };
> 
>                 sd1_bus8: sd1-bus-width8 {
>                         samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
>                         ...
>                };
> 
> Downstream (arch/arm/boot/dts/exynos542x-peach.dtsi):
>                 pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_int &sd1_bus4 &sd1_bus8>;
> 
> 
> Notice the difference?  You need to add "sd1_bus1" to the pinctrl for
> upstream.  The upstream DTS makes more sense.  I think I remember
> discussing this in the past (finding the conversation on the lists is
> left as an exercise to the reader) and you can in fact see that the
> upstream 5250 pinctrl file is like the downstream 5420 pinctrl...
>

Yeah, I didn't notice that there was an inconsistency in the pinctrl
defines in mainline around the different SoCs. So for 5250 you need:

* only sd1_bus1 for bus-width = <1>
* only sd1_bus4 for bus-width = <4>
* sd1_bus4 + sd1_bus8 for bus-width = <8>

and for 5440 you need:

* only sd1_bus1 for bus-width = <1>
* only sd1_bus1 + sd1_bus4 for bus-width = <4>
* sd1_bus1 + sd1_bus4 + sd1_bus8 for bus-width = <8>

Is true that 5440 is at least more consistent in the sense that you
have to add all the pins but IMHO this approach is very error prone.

I would preferred if sd1_busN included all pins needed for width N
so you only had to define a single pinctrl group but for now I'll
include "sd1_bus1" to fix the SDIO WiFi issue.

> I think the same bug is present in eMMC and SD but possibly the
> bootloader inits the pinctrl properly there?
>

Correct, I'll fix those too so the kernel does not rely on the boot
loader to setup those pins.

> 
> Crossing my fingers that's your bug, but I can't say for sure why
> adding a tons of resets would somehow make it better?
>

It is, thanks a lot again for finding this issue. I feel very dumb for
not realizing there was a difference in the included pinctrl definition.

> -Doug
>

Best regards,
Javier
