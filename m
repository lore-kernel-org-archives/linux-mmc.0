From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] ARM: shmobile: r8a7790: Add nodes for pfc SD
 voltage regulators
Date: Thu, 7 May 2015 13:33:10 +0900
Message-ID: <20150507043310.GH28846@verge.net.au>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
 <1430397114.5802.43.camel@xylophone.i.decadent.org.uk>
 <20150501005719.GG13754@verge.net.au>
 <1430875082.4222.28.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430875082.4222.28.camel-2NU49sBE5Aze9VDwLV8dzJPsBRI6B4nW9dF7HbQ/qKg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 06, 2015 at 02:18:02AM +0100, Ben Hutchings wrote:
> On Fri, 2015-05-01 at 09:57 +0900, Simon Horman wrote:
> > Hi Ben,
> > 
> > thanks for your patch-set.
> > 
> > On Thu, Apr 30, 2015 at 01:31:54PM +0100, Ben Hutchings wrote:
> > > Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/r8a7790.dtsi |   21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > > index 4bb2f4c17321..23e826153a9d 100644
> > > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > > @@ -483,6 +483,23 @@
> > >  	pfc: pfc@e6060000 {
> > >  		compatible = "renesas,pfc-r8a7790";
> > >  		reg = <0 0xe6060000 0 0x250>;
> > > +
> > > +		vccq_ref_sdhi0: sd-regulator@0 {
> > > +			compatible = "renesas,pfc-r8a7790-sd-regulator";
> > 
> > I'm a little confused. What is "renesas,pfc-r8a7790-sd-regulator"?
> > It suspect that it should at least be documented under
> > Documentation/devicetree/bindings/
> [...]
> 
> It will be if it's agreed that this is the way to represent the voltage
> switch in the pfc.  The sh-pfc driver is changed in patch 3/7 to look
> for sd-regulator@{0..3} nodes in an r8a7790 DT.  The nodes carry only
> their address and status.  The compatible value is currently ignored.

Thanks, that makes sense.

As a rule I generally don't apply DT patches that use bindings
that haven't already been accepted. So if this does turn out to
be the way to go then please document it.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
