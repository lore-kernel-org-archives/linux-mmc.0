From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC 3/3] ARM: dts: r8a7790: lager: Enable UHS-I SDR-104
Date: Tue, 10 May 2016 18:13:55 +0900
Message-ID: <CANqRtoRjZjC=uEBvJsWYwu0EMEZwO3zS0JWNwVoBR8zjakMpnA@mail.gmail.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
	<1462859524-28522-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462859524-28522-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 10, 2016 at 2:52 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add the sd-uhs-sdr104 property to SDHI0.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 749ba02b6a53..05d1ff7acee2 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -559,6 +559,7 @@
>         vqmmc-supply = <&vccq_sdhi0>;
>         cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
>         sd-uhs-sdr50;
> +       sd-uhs-sdr104;
>         status = "okay";

Hi Simon,

Thanks for this - interesting to see!! From what I can tell this code
is targeting r8a7790 Lager, and based on the data sheet and the DTS
there are four SDHI channels for the r8a7790 SoC. All R-Car Gen2 SDHI
channels are not identical, so on r8a7790 it looks like SDHI0 and
SDHI1 have extended capabilities for the clocks (and probably support
SDR104) while SDHI2 and SDHI3 do not have this hardware feature. How
is this difference handled today? In my mind it would make sense to
have different compat strings, but I think we differentiate with
resource size today?

So with this patches I can see that you enable SDR104 on SDHI0 on
Lager which makes sense, but is SDHI2 support still OK?

Cheers,

/ magnus
