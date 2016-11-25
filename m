From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH mmc/next] mmc: sh_mobile_sdhi: remove support for sh7372
Date: Fri, 25 Nov 2016 14:30:55 +0100
Message-ID: <CAPDyKFqQeLb=ngbZZusZ2ea+5XzSgkhD1bAqt4LEipbrhfZwGQ@mail.gmail.com>
References: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 November 2016 at 11:48, Simon Horman <horms+renesas@verge.net.au> wrote:
> Remove documentation of support for the SH7372 (SH-Mobile AP4) from the MMC
> driver. The driver itself appears to have no SH7372 specific code.
>
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removes this SoC from the kernel in v4.1.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 13df9c2399c3..1db9e74bb9c1 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -11,7 +11,6 @@ optional bindings can be used.
>
>  Required properties:
>  - compatible:  "renesas,sdhi-shmobile" - a generic sh-mobile SDHI unit
> -               "renesas,sdhi-sh7372" - SDHI IP on SH7372 SoC
>                 "renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
>                 "renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
>                 "renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
> --
> 2.7.0.rc3.207.g0ac5344
>
