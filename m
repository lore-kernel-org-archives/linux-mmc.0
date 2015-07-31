From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Fri, 31 Jul 2015 11:23:04 +0900
Message-ID: <CANqRtoSVU77Q7hnoMJ2_VbqprJYxbvbbe5MHBReH_dVxyvGAQQ@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
	<3979266.lQrOKbu0yo@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34966 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbGaCXG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jul 2015 22:23:06 -0400
In-Reply-To: <3979266.lQrOKbu0yo@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Sergei,

On Fri, Jul 31, 2015 at 4:59 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The "compatible" property text contradicts even the example given in the MMCIF
> binding document itself; moreover, the Renesas MMCIF driver only  matches  on
> the generic "compatible" string, and doesn't look for at SoC specific strings
> currently at all. Thus describe "renesas,sh-mmcif" string as mandatory and the
> others as optional.
>
> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your efforts trying to improve the DT binding documentation.

> --- renesas.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ renesas/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
>
>  Required properties:
>
> -- compatible: must contain one of the following
> +- compatible: must contain "renesas,sh-mmcif"; may also contain one of
> +  the following:
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> -       - "renesas,sh-mmcif" for the generic MMCIF

As you know, each SoC contains a wide range of on-chip devices and the
MMCIF device is just one of them. Exactly how to manage the DT
bindings must be up to each maintainer and of course this needs to be
aligned with the SoC maintainer and SoC vendor with policies used for
SoC support and BSPs and whatnot. Changing policy like this for a
single device without at least discussing this with the SoC
maintainers does not help.

For Renesas hardware we so far use both SoC part number and optionally
a generic binding as well. As commonly expected, the DT binding is
supposed to describe the hardware and if hardware devices are
compatible. Unless we use SoC part number in the compatible string
there is a risk that the SoC integrator simply copy-and-pastes generic
bindings "because it works" but this will result in DT binding based
on software compatibility and not hardware compatibility. Later when
the driver support is extended this may result in broken software due
to incorrect compatibility information through generic bindings.

If anything is unclear please ask and feel free to discuss this DT
topic with Simon, Laurent, Geert and/or me.

Thanks,

/ magnus
