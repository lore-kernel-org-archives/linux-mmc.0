From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Thu, 21 Apr 2016 14:54:30 +0200
Message-ID: <CAMuHMdUwHhd-C=PCTubUUpQY4w5hDPjiCQMF65KMRojrnQgd+w@mail.gmail.com>
References: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36533 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDUMyb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 08:54:31 -0400
In-Reply-To: <1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Mon, Apr 18, 2016 at 6:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -510,6 +510,42 @@
>                 reg = <0 0xe6060000 0 0x250>;
>         };
>
> +       sdhi0: sd@ee100000 {
> +               compatible = "renesas,sdhi-r8a7793";
> +               reg = <0 0xee100000 0 0x328>;
> +               interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;

GIC_SPI (x3)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
