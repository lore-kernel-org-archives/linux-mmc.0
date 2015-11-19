From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Document r8a7793 DT bindings
Date: Thu, 19 Nov 2015 12:32:51 +0100
Message-ID: <CAPDyKFqcxQtE=d=kGVgf5KLbCss7r9CuFv0d+GB-dR9Rgvm53Q@mail.gmail.com>
References: <1445964991-7825-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35821 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933769AbbKSLcw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 06:32:52 -0500
Received: by ykba77 with SMTP id a77so103840120ykb.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 03:32:51 -0800 (PST)
In-Reply-To: <1445964991-7825-1-git-send-email-geert+renesas@glider.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On 27 October 2015 at 17:56, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> [geert: Rebased]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index cae29eb5733d8a52..ff611fa66871dec9 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> +       - "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
>         - "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
>
>  - clocks: reference to the functional clock
> --
> 1.9.1
>
