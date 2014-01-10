From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 5/7] ARM: dts: add pbias dt node
Date: Fri, 10 Jan 2014 11:32:34 +0000
Message-ID: <20140110113234.GA25741@e106331-lin.cambridge.arm.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-6-git-send-email-balajitk@ti.com>
 <20140106181928.GK24664@e106331-lin.cambridge.arm.com>
 <52CBD467.6060909@ti.com>
 <20140107105738.GA4180@e106331-lin.cambridge.arm.com>
 <52CBF1CF.4040706@ti.com>
 <52CD6602.7040603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37228 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbaAJLc7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2014 06:32:59 -0500
Content-Disposition: inline
In-Reply-To: <52CD6602.7040603@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "broonie@kernel.org" <broonie@kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Wed, Jan 08, 2014 at 02:51:46PM +0000, Balaji T K wrote:
> On Tuesday 07 January 2014 05:53 PM, Balaji T K wrote:
> > On Tuesday 07 January 2014 04:27 PM, Mark Rutland wrote:
> >> On Tue, Jan 07, 2014 at 10:18:15AM +0000, Balaji T K wrote:
> >>> On Monday 06 January 2014 11:49 PM, Mark Rutland wrote:
> >>>> On Fri, Dec 20, 2013 at 05:35:53PM +0000, Balaji T K wrote:
> >>>>> Add pbias regulator node as a child of system control
> >>>>> module - syscon.
> >>>>>
> >>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
> >>>>> ---
> >>>>>    arch/arm/boot/dts/dra7.dtsi     |   18 ++++++++++++++++++
> >>>>>    arch/arm/boot/dts/omap2430.dtsi |   18 ++++++++++++++++++
> >>>>>    arch/arm/boot/dts/omap3.dtsi    |   18 ++++++++++++++++++
> >>>>>    arch/arm/boot/dts/omap4.dtsi    |   18 ++++++++++++++++++
> >>>>>    arch/arm/boot/dts/omap5.dtsi    |   18 ++++++++++++++++++
> >>>>>    5 files changed, 90 insertions(+), 0 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> >>>>> index d0df4c4..4e68df1 100644
> >>>>> --- a/arch/arm/boot/dts/dra7.dtsi
> >>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
> >>>>> @@ -110,6 +110,23 @@
> >>>>>                ti,hwmods = "counter_32k";
> >>>>>            };
> >>>>>
> >>>>> +        dra7_ctrl_general: tisyscon@4a002e00 {
> >>>>> +            compatible = "ti,control-syscon", "syscon", "simple-bus";
> >>>>
> >>>> Please, don't use simple-bus like that. The components below this node
> >>>> depend on it. It is _NOT_ a simple bus. Make the ti,control-syscon
> >>>> driver probe it's children.
> >>>
> >>> Hi Mark,
> >>>
> >>> Actually ti,control-syscon driver does not exist, so I can remove it,
> >>> and simple-bus is needed for child creation.
> >>
> >> This still shows up as a syscon node, with a reg property, and syscon is
> >> not an extension of simple-bus.
> >>
> >> There are properties in the parent node that children depend on, and
> >> that makes me wary of describing it as a simple bus. I'd expect to be
> >> able to move child nodes out of a simple-bus if ranges provided an
> >> idmap, and I can't do that here.
> >>
> > Hi Mark,
> >
> > Not sure if I am understanding here, can you please add more info.

A node's compatible string list describes the set of devices (or rather
descriptions of devices) with which it is compatible. The list goes from
most specific to least specific. The idea is that an OS reads through
the list until it finds a string it knows how to handle, then treats the
node as that.

Ignoring "ti,control-syscon", the node has both "syscon" and
"simple-bus". Given you expect the OS to recognise "syscon", you should
_not_ expect it to also treat the node as "simple-bus". Doing so is an
abuse of the property and current Linux implementation details.

The "syscon" binding is not a more specific version of "simple-bus".
They imply completely different things.

Either make a ti,control-syscon driver that probes the child nodes, or
move the child nodes out and give them a phandle to the
dra7_ctrl_general node that they can parse. I'd prefer the latter as
relies on fewer topology details, is as easy to implement as your
current parent node parsing, and is easier to extend in future.

> >
> Hi Mark,
> 
>  From Documentation/devicetree/bindings.. , I could get below info about simple-bus
> - "simple-bus" compatible value (to ensure creation of the children)
> 	compatible = "simple-bus";

That's from the vexpress binding description of the smb node?

In that case, the smb node _is_ a simple-bus. It has no nonstandard
properties, and the child nodes aren't reading arbitrary properties out
of the smb node.

There the simple-bus is used to remap addresses of child nodes via
ranges. It does represent a simple bus, and that's all the OS is
expected to know.

Thanks,
Mark.
