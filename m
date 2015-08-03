From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Mon, 3 Aug 2015 10:09:39 +0900
Message-ID: <CANqRtoTQjyvBE=diuhicuKRhf-JU85uoAiFuE2-UPWTvxw3FQA@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
	<3979266.lQrOKbu0yo@wasted.cogentembedded.com>
	<CANqRtoSVU77Q7hnoMJ2_VbqprJYxbvbbe5MHBReH_dVxyvGAQQ@mail.gmail.com>
	<55BB44DC.8040706@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <55BB44DC.8040706@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson" <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-mmc@vger.kernel.org

Hi Sergei,

On Fri, Jul 31, 2015 at 6:50 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 7/31/2015 5:23 AM, Magnus Damm wrote:
>
>>> The "compatible" property text contradicts even the example given in the
>>> MMCIF
>>> binding document itself; moreover, the Renesas MMCIF driver only  matches
>>> on
>>> the generic "compatible" string, and doesn't look for at SoC specific
>>> strings
>>> currently at all. Thus describe "renesas,sh-mmcif" string as mandatory
>>> and the
>>> others as optional.
>
>
>>> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>> Thanks for your efforts trying to improve the DT binding documentation.
>
>
>>> --- renesas.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
>>> +++ renesas/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
>>> @@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
>>>
>>>   Required properties:
>>>
>>> -- compatible: must contain one of the following
>>> +- compatible: must contain "renesas,sh-mmcif"; may also contain one of
>>> +  the following:
>>>          - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>>>          - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>>>          - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
>>> -       - "renesas,sh-mmcif" for the generic MMCIF
>
>
>> As you know, each SoC contains a wide range of on-chip devices and the
>> MMCIF device is just one of them. Exactly how to manage the DT
>> bindings must be up to each maintainer and of course this needs to be
>> aligned with the SoC maintainer and SoC vendor with policies used for
>> SoC support and BSPs and whatnot. Changing policy like this for a
>> single device without at least discussing this with the SoC
>> maintainers does not help.
>
>
>    I'm not changing the policy, I'm making the binding actually reflect the
> driver reality (and even the example given in the binding).

Adjusting the binding after driver implementation seems a bit reverse to me.

The way I see it, first you make a DT binding describing the hardware.
Then as second step, you make sure the device driver support the
hardware and the DT binding. As third or second parallel step you
integrate via a DT.

If you are concerned about the order of the compatible strings, unless
specified by the SoC vendor documentation it is in my opinion up to
each driver maintainer and/or developer to judge if the hardware is
compatible or not. So the development activity of determining if the
devices are compatible shall result in a correct compat string order.
I'm not so sure if it is required that this order is supposed to be
documented in the DT binding. Being more clear does not hurt though.

>> For Renesas hardware we so far use both SoC part number and optionally
>> a generic binding as well. As commonly expected, the DT binding is
>> supposed to describe the hardware and if hardware devices are
>> compatible. Unless we use SoC part number in the compatible string
>> there is a risk that the SoC integrator simply copy-and-pastes generic
>> bindings "because it works" but this will result in DT binding based
>> on software compatibility and not hardware compatibility. Later when
>> the driver support is extended this may result in broken software due
>> to incorrect compatibility information through generic bindings.
>
>> If anything is unclear please ask and feel free to discuss this DT
>> topic with Simon, Laurent, Geert and/or me.
>
>    I didn't quite understand what you're proposing instead. Making SoC based
> strings mandatory? Changing the driver to look at the SoC based strings?

I think Laurent describes it pretty well. I'm not sure why you feel
that you need to change the driver though, so I wonder if there is
some misunderstanding going on here...

Please understand that all the compat strings included in the DT
binding document not necessarily have to be used by the driver. But
before merging DT integration code it seems customary that the DT
binding needs to be documented.

Thanks,

/ magnus
