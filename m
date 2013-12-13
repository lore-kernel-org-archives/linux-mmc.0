From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 3/8] Documentation: dt: kona-sdhci: Add clocks property
Date: Fri, 13 Dec 2013 00:02:25 -0800
Message-ID: <CAEPRUYr7DpMhEjp3xd1t21usjWGdod0dsqdsAeu2gyVY-pqQKw@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-4-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386271244-3927-4-git-send-email-tim.kryger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> The Kona SDHCI block requires a clock that must be specified in the
> device tree.  Update the documentation to reflect this requirement.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/kona-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> index 789fb07..aaba248 100644
> --- a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> @@ -6,12 +6,16 @@ and the properties present in the bcm281xx SDHCI
>  Required properties:
>  - compatible : Should be "brcm,kona-sdhci"
>  - DEPRECATED: compatible : Should be "bcm,kona-sdhci"
> +- clocks: phandle + clock specifier pair of the external clock
> +
> +Refer to clocks/clock-bindings.txt for generic clock consumer properties.
>
>  Example:
>
>  sdio2: sdio@0x3f1a0000 {
>         compatible = "brcm,kona-sdhci";
>         reg = <0x3f1a0000 0x10000>;
> +       clocks = <&sdio3_clk>;
>         interrupts = <0x0 74 0x4>;
>  };
>
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
