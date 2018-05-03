From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Date: Thu, 3 May 2018 20:05:53 +0200
Message-ID: <20180503180553.qjjgnw5jnvtdn46n@flea>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
 <20180502093601.fvkacdv62aqxshbr@flea>
 <aa2d6072-87a5-cd52-d3a5-17df889e6bc9@arm.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBDE7VXLQKGQED7UE5MQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <aa2d6072-87a5-cd52-d3a5-17df889e6bc9-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 02, 2018 at 12:01:53PM +0100, Andre Przywara wrote:
> >>>> It looks like there are more users of those power rails, so we could
> >>>> keep those supplies connected to these fixed regulators here, even with
> >>>> AXP-805 support in the kernel.
> >>>
> >>> It's not a good choice.
> >>>
> >>>>
> >>>> Or we keep this back until we get proper AXP support in the kernel? I
> >>>> guess it's quite close to the existing PMICs, so it might be more a
> >>>> copy&paste exercise to support the AXP-805?
> >>>
> >>> It's not a reason to keep it back.
> >>
> >> So I compared the manuals of the AXP806 and the AXP805, the register
> >> interface looks identical to me. I only have a (somewhat) Chinese
> >> version of the AXP806 manual, so couldn't really find the difference
> >> between the two. Do you know more about it? Is it just maybe the
> >> packaging and the electrical properties (like max current supported)?
> >>
> >> If the I2C register interface is really the same, we could just add the
> >> DT nodes for the regulator and be done.
> > 
> > And that argument is only valid if you 100% trust the fact that both
> > datasheet are complete and accurate.
> > 
> > And experience show that you can't.
> 
> Well, but I wonder how paranoid we are going to be? And in this case we
> have confirmation from Wink that they are the same.

Paranoid enough so that we don't blindly trust that the reviewer had a
coffee, no interruptions or moment of distraction, or that the
datasheet is correct.

But not so paranoid that having the driver running on a kernel is
enough.

> So I think we can go with just a DT addition, given that we test it
> and confirm that it works for our use case. Should we discover
> something odd or undocumented later, I'd consider this a bug fix,
> which we then (and only then!) could fix by adding the compatible
> string to the driver. Any DT would be fine already, because we list
> both compatible strings in there.

In this particular case, yeah, it seems reasonable.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
