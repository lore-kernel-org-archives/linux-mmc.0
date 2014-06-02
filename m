From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt: bindings: mmc: Document the
 practice of using subnodes for slots
Date: Mon, 2 Jun 2014 08:45:13 +0200
Message-ID: <20140602064513.GQ15686@pengutronix.de>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
 <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
 <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
 <538AF124.9040106@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDVL3QMXTAOBBAN3WCOAKGQE65KF5UQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <538AF124.9040106-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 01, 2014 at 11:23:48AM +0200, Hans de Goede wrote:
> Hi,
> 
> >Neither seems to actually ever have been used with
> >more than one slot. I doubt anyone building an exynos-based system
> >will ever do a multi-slot solution, and it seems that the at91 driver
> >doesn't actually handle more than one slot.
> >
> >I'm personally not that excited about complicating the bindings by
> >opening up for this -- I would rather work towards removing the
> >concept of slots if it's one of those things that are going to remain
> >unused. We have actually been talking about reworking the dw_mmc
> >binding to remove the slot concept (and simplify the driver by doing
> >so).
> 
> I'm fine with removing the slot subnode, I added it because of it being
> brought up in the powerup sequence discussion. I explicitly asked there
> if adding such a subnode level was seen as desirable but nobody
> answered :|

MMC bus support was removed back in 2007:

| commit b855885e3b60cf6f9452848712a62517b94583eb
| Author: Pierre Ossman <drzeus-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
| Date:   Wed Jan 3 19:47:29 2007 +0100
| 
|     mmc: deprecate mmc bus topology
|     
|     The classic MMC bus was defined as multi card bus
|     system, which is reflected in the design in the MMC
|     layer.
|     
|     When SD showed up, the bus topology was abandoned
|     and a star topology (one card per host) was mandated.
|     MMC version 4 has followed this, officially deprecating
|     the bus topology.
|     
|     As we do not have any known users of the bus
|     topology we can remove support for it. This will
|     simplify the code and rectify some incorrect
|     assumptions in the newer additions.
|     
|     Signed-off-by: Pierre Ossman <drzeus-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>

I doubt we will ever need support for it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
