From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] drivers: mmc: sunxi: fix A64
 calibration routine
Date: Thu, 5 Jan 2017 18:47:25 +0100
Message-ID: <20170105174725.kmr25iodjnjozqjm@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="enoc76q3xwcga7iz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBOMNXLBQKGQE52EW6NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1483398226-29321-2-git-send-email-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--enoc76q3xwcga7iz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Mon, Jan 02, 2017 at 11:03:42PM +0000, Andre Przywara wrote:
> The calibration facility in the A64 MMC block seems to have been
> misunderstood: the result value is not the value to program into the
> delay bits, but is the number of delay cells that result in a full clock
> cycle delay. So this value has to be scaled by the desired phase, which
> we still have to know and program.
> Change the calibration routine to take a phase parameter and scale the
> calibration value accordingly.
> Also introduce sun50i-a64 delay parameters to store the required phase.
> Looking at the BSP kernel the sample delay for anything below HS200 is
> 0, so we go with that value.
> Once the driver supports HS200 and faster modes, we can enter confirmed
> working values in there.
> 
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>

Exactly how that works hasn't been confirmed, and the only thing that
this patch actually do is... nothing, since the delay is always 0. If
and when we get HS400 to work and we know for a fact how the
calibration works, then we'll be able to use it. Until then, we can
just clear those bits.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--enoc76q3xwcga7iz--
