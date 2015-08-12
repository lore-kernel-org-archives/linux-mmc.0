From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Thu, 13 Aug 2015 08:58:31 +0900
Message-ID: <20150812235828.GA5221@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1643858.nkRxsQo3O3@wasted.cogentembedded.com>
 <20150812005628.GE15957@verge.net.au>
 <55CB22E4.5040904@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55CB22E4.5040904@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 12, 2015 at 01:41:40PM +0300, Sergei Shtylyov wrote:
> On 8/12/2015 3:56 AM, Simon Horman wrote:
> 
> >>The "compatible" property text contradicts even the example given in the MMCIF
> >>binding document itself;  moreover, the Renesas MMCIF driver only matches on
> >>the generic "compatible" string and doesn't look for the SoC specific strings
> >>at all. Thus describe "renesas,sh-mmcif" as a fallback value.
> 
> >>Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >I don't believe this file is the appropriate place to describe
> >best-practice for the ordering of compatible strings which must surely be
> >documented elsewhere.
> 
>    Where? I have no idea what you mean...
>    And let me reiterate: this text is *wrong* and needs to be fixed anyway.

The document lists the acceptable compat strings for the driver.
Some are currently implemented by the driver. Some are not.
This provides a mechanism for enhancing the driver while maintaining
compatibility with existing DT blobs.

The document does not describe the way to order the compat strings, which I
believe is a more generic issue as many drivers have more and less specific
compat strings to describe hardware which is compatible with each other. To
some extent I believe it is up to the user, that is the person writing DT
files, to understand what the hardware they are dealing with is compatible
with. And to some extent I believe the ordering is a best-practice that
ought to be described in a high-level document if it is not already.

Your proposed update assumes that all past and future hardware handled by
current and future versions of the driver will be compatible with
"renesas,sh-mmcif". How can you possibly know that is true?

> >>---
> >>The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' and 'next' branches.
> >>
> >>Changes in version 2:
> >>- kept the SoC specific "compatible" property values mandatory and made the
> >>   generic string a fallback.
> >>
> >>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >>===================================================================
> >>--- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >>+++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >>@@ -10,7 +10,7 @@ Required properties:
> >>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> >>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
> >>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> >>-	- "renesas,sh-mmcif" for the generic MMCIF
> >>+  followed by "renesas,sh-mmcif".
> >>
> >>  - clocks: reference to the functional clock
> 
> MBR, Sergei
> 
