From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to
 8K DMA buffer
Date: Thu, 5 Jan 2017 18:57:46 +0100
Message-ID: <20170105175746.fq6crpc3krz7tzxi@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
 <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chu2rgfkbjn4epfw"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBM4SXLBQKGQEOGGHP7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--chu2rgfkbjn4epfw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Rob,

On Wed, Jan 04, 2017 at 08:07:50AM -0600, Rob Herring wrote:
> On Mon, Jan 02, 2017 at 11:03:43PM +0000, Andre Przywara wrote:
> > From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > Unlike the A64 user manual reports, the third MMC controller on the
> > A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
> > DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
> > This does not affect the other two controllers, so introduce a new
> > DT compatible string to let the driver use different settings for that
> > particular device. This will also help to enable the high-speed transfer
> > modes of that controller later.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
> >  drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
> >  2 files changed, 8 insertions(+)
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Some kind of a digression on this: we have three MMC controllers on
this SoC. Like this patch shows, the third one is clearly different,
and supports both more modes, a wider bus, and specific quirks. We
need a new compatible for this one, everything's perfect.

However, the other two are mostly the same, but seems to need
different tuning parameters to get more performances out of the
controller (but this is unclear yet). How do we usually deal with
that?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--chu2rgfkbjn4epfw--
