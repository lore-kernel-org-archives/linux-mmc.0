From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Fri, 16 Oct 2015 15:07:23 +0200
Message-ID: <CAPDyKFqLuH9u2n1EKSc-89E6iDR8JH0A+5c=wn8g3THPKvDX7A@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
	<2657565.2y8qYzu3eL@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34980 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbJPNHZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 09:07:25 -0400
Received: by wicll6 with SMTP id ll6so9171752wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 06:07:24 -0700 (PDT)
In-Reply-To: <2657565.2y8qYzu3eL@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 16 October 2015 at 00:40, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Renesas R8A7794 SoC also has the MMCIF controller...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied for next.

Kind regards
Uffe


>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branches plus the
> patch I posted earlier today...
>
> Changes in version 3:
> - resolved reject.
>
> Changes in version 2:
> - deferred R8A7793 support to the patch posted earlier by Ulrich Hecht;
> - fixed typo in the changelog.
>
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> ===================================================================
> --- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> +       - "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
>
>  - clocks: reference to the functional clock
>
>
