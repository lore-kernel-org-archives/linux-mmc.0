From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 07/14] clk: sunxi: Introduce mbus compatible
Date: Mon, 25 Aug 2014 22:17:37 +0800
Message-ID: <CAGb2v64xzwySFcnhAAmPFvUOWGechLZpoxfmb0OmEGOZbV+58Q@mail.gmail.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1405588134-2396-8-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40825 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbaHYOR6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Aug 2014 10:17:58 -0400
In-Reply-To: <1405588134-2396-8-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, Chris Ball <chris@printf.net>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Jul 17, 2014 at 5:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Even though the mbus clock is a regular module clock, given its nature, it
> needs to be enabled all the time.
>
> Introduce a new compatible, to differentiate it from the other module clocks.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index d3a5c3c6d677..112d8525b6e0 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -46,6 +46,7 @@ Required properties:
>         "allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
>         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
> +       "allwinner,sun4i-a10-mbus-clk" - for the MBUS clock on A10

This should probably be sun5i-a13-mbus-clk?
AFAIK the A10 doesn't have MBUS.

>         "allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
>         "allwinner,sun7i-a20-out-clk" - for the external output clocks
>         "allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 130e0d1ae510..bfb82bafbf9b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1110,6 +1110,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
>         {.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
>         {.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
>         {.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
> +       {.compatible = "allwinner,sun4i-a10-mbus-clk", .data = &sun4i_mod0_data,},
>         {.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
>         {.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
>         {}
> --
> 2.0.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
