From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] ARM: dts: r8a7793: Add MMCIF0
Date: Thu, 21 Apr 2016 14:52:09 +0200
Message-ID: <CAMuHMdW0uJZU947gXR0QVYOUFYH2K0fvuhBaD+rd8=RuvTVq-A@mail.gmail.com>
References: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35081 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbcDUMwK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 08:52:10 -0400
In-Reply-To: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Apr 18, 2016 at 6:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Same as on r8a7794.

r8a7791?

> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -510,6 +510,19 @@
>                 reg = <0 0xe6060000 0 0x250>;
>         };
>
> +       mmcif0: mmcif@ee200000 {
> +               compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
> +               reg = <0 0xee200000 0 0x80>;
> +               interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;

s/0/GIC_SPI/

> +               clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
> +               dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> +                      <&dmac1 0xd1>, <&dmac1 0xd2>;
> +               dma-names = "tx", "rx", "tx", "rx";
> +               power-domains = <&cpg_clocks>;
> +               reg-io-width = <4>;
> +               status = "disabled";

max-frequency = <97500000>;?

It's always a good idea to compare r8a7791.dts and r8a7793.dtsi
after s/r8a779[13]/r8a779x/...

> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
