From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 6/8] Documentation: dt: kona-timer: Add clocks property
Date: Sat, 14 Dec 2013 00:19:08 -0800
Message-ID: <CAEPRUYo+7G2KT_87bA9sY-97MmiNFVdgGHQo2o4cSX=kGf2hfg@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-7-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386271244-3927-7-git-send-email-tim.kryger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> The frequency for the Kona timer can either be specified through the
> device tree or determined by checking the rate of the clock specified
> in the device tree.  Update the documentation to reflect both ways.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/bcm/kona-timer.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
> index 17d88b2..39adf54 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/kona-timer.txt
> @@ -8,13 +8,18 @@ Required properties:
>  - DEPRECATED: compatible : "bcm,kona-timer"
>  - reg : Register range for the timer
>  - interrupts : interrupt for the timer
> +- clocks: phandle + clock specifier pair of the external clock
>  - clock-frequency: frequency that the clock operates
>
> +Only one of clocks or clock-frequency should be specified.
> +
> +Refer to clocks/clock-bindings.txt for generic clock consumer properties.
> +
>  Example:
>         timer@35006000 {
>                 compatible = "brcm,kona-timer";
>                 reg = <0x35006000 0x1000>;
>                 interrupts = <0x0 7 0x4>;
> -               clock-frequency = <32768>;
> +               clocks = <&hub_timer_clk>;
>         };
>
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
