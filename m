From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/6] ARM: shmobile: lager: Set sdhi and mmcif clock rates
Date: Sun, 17 May 2015 10:13:13 +0200
Message-ID: <CAMuHMdWN1EPdq+TAdtZ5wW+G2r5he55SnjYEsHDg6T3-=n6r=g@mail.gmail.com>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
	<1431822574.4222.172.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33232 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbbEQINO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2015 04:13:14 -0400
In-Reply-To: <1431822574.4222.172.camel@xylophone.i.decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>

On Sun, May 17, 2015 at 2:29 AM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>
> [bwh: Fold in fix from Ian Molton]
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index aaa4f258e279..343ec0ccc8df 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -413,6 +413,11 @@
>         vmmc-supply = <&fixedregulator3v3>;
>         bus-width = <8>;
>         non-removable;
> +
> +       assigned-clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
> +       assigned-clock-rates = <97500000>;
> +       max-frequency = <50000000>;

Are all these properties Lager-specific, or r8a7790-specific?
If the latter, they belong in r8a7790.dtsi.
Same comment for the other nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
