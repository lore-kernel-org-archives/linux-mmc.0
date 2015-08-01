From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Sat, 01 Aug 2015 12:41:52 +0300
Message-ID: <2743376.X2l1zDXaCd@avalon>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com> <3979266.lQrOKbu0yo@wasted.cogentembedded.com> <CANqRtoSVU77Q7hnoMJ2_VbqprJYxbvbbe5MHBReH_dVxyvGAQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:59727 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbHAJlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Aug 2015 05:41:13 -0400
In-Reply-To: <CANqRtoSVU77Q7hnoMJ2_VbqprJYxbvbbe5MHBReH_dVxyvGAQQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>

On Friday 31 July 2015 11:23:04 Magnus Damm wrote:
> On Fri, Jul 31, 2015 at 4:59 AM, Sergei Shtylyov wrote:
> > The "compatible" property text contradicts even the example given in the
> > MMCIF binding document itself; moreover, the Renesas MMCIF driver only 
> > matches  on the generic "compatible" string, and doesn't look for at SoC
> > specific strings currently at all. Thus describe "renesas,sh-mmcif"
> > string as mandatory and the others as optional.
> > 
> > Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your efforts trying to improve the DT binding documentation.
> 
> > --- renesas.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> > +++ renesas/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> > @@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
> > 
> >  Required properties:
> > -- compatible: must contain one of the following
> > +- compatible: must contain "renesas,sh-mmcif"; may also contain one of
> > 
> > +  the following:
> >         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> >         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
> >         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> > 
> > -       - "renesas,sh-mmcif" for the generic MMCIF
> 
> As you know, each SoC contains a wide range of on-chip devices and the
> MMCIF device is just one of them. Exactly how to manage the DT
> bindings must be up to each maintainer and of course this needs to be
> aligned with the SoC maintainer and SoC vendor with policies used for
> SoC support and BSPs and whatnot. Changing policy like this for a
> single device without at least discussing this with the SoC
> maintainers does not help.
> 
> For Renesas hardware we so far use both SoC part number and optionally
> a generic binding as well. As commonly expected, the DT binding is
> supposed to describe the hardware and if hardware devices are
> compatible. Unless we use SoC part number in the compatible string
> there is a risk that the SoC integrator simply copy-and-pastes generic
> bindings "because it works" but this will result in DT binding based
> on software compatibility and not hardware compatibility. Later when
> the driver support is extended this may result in broken software due
> to incorrect compatibility information through generic bindings.
> 
> If anything is unclear please ask and feel free to discuss this DT
> topic with Simon, Laurent, Geert and/or me.

To clarify this, the current DT compatible strings policy for Renesas SoCs is 
to use a mandatory SoC-based string followed by a optional generic strings. 
Optional here refers to the fact that individual DT bindings can decide 
whether to use a generic string or not, based on hardware information. An IP 
core that has a different, incompatible implementation for each SoC it is 
present in can't make use of a generic compatible string. If a particular 
binding defines generic compatible strings those should be made mandatory by 
that binding.

In the MMCIF case, I would propose wording it as

- compatible: must contain one of the following
      - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
      - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
      - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
  followed by "renesas,sh-mmcif".

-- 
Regards,

Laurent Pinchart

