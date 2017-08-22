From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Tue, 22 Aug 2017 13:13:28 +0200
Message-ID: <CAPDyKFpWDP-XqRahy2YHgZZ+c_q4wP3jAboJrJAdWtt=Gukj5A@mail.gmail.com>
References: <CAMuHMdWUxxp75u1VSLY3WnObmhSMDvP3skr9Uf3rV4Bf-ixy_w@mail.gmail.com>
 <1503318311-48664-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35411 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdHVLNa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:13:30 -0400
Received: by mail-qt0-f181.google.com with SMTP id x36so26407025qtx.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:13:29 -0700 (PDT)
In-Reply-To: <1503318311-48664-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 21 August 2017 at 14:25, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v1->v2
>     - Modified the listing SoC's description related to SoC
>       with 1 Clock and 2 Clocks
> v2->v3
>     - Fixed the trailing double quote.
>     - Updated listing SoC's description.
>
> This patch is compiled and tested against linux next tag
> next-20170817.
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 4fd8b7a..54ef642 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -15,6 +15,8 @@ Required properties:
>                 "renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
>                 "renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
>                 "renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
> +               "renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
> +               "renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
>                 "renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
>                 "renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
>                 "renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
> @@ -33,10 +35,8 @@ Required properties:
>           If 2 clocks are specified by the hardware, you must name them as
>           "core" and "cd". If the controller only has 1 clock, naming is not
>           required.
> -         Below is the number clocks for each supported SoC:
> -          1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -             R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> -          2: R7S72100
> +         Devices which have more than 1 clock are listed below:
> +         2: R7S72100
>
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
> --
> 1.9.1
>
