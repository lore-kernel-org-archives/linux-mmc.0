From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch
 to mmc3 for onboard eMMC
Date: Sun, 24 Jan 2016 17:56:31 +0100
Message-ID: <20160124165631.GB7908@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-10-git-send-email-wens@csie.org>
 <20160122203927.GC3682@lukather>
 <CAGb2v658auQfvZy8jr__bmuk6=zGicvvE=5Fa5pOnubkgYvjDA@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQEESS2QKGQE6LSPDOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v658auQfvZy8jr__bmuk6=zGicvvE=5Fa5pOnubkgYvjDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sat, Jan 23, 2016 at 12:21:55PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jan 23, 2016 at 4:39 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi,
> >
> > On Thu, Jan 21, 2016 at 01:26:36PM +0800, Chen-Yu Tsai wrote:
> >> According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
> >> Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
> >> voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
> >> instance can use eMMC hardware reset.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> ---
> >>  arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> >> index ea69fb8ad4d8..4ec0c8679b2e 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> >> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> >> @@ -61,12 +61,14 @@
> >>  };
> >>
> >>  /* eMMC on core board */
> >> -&mmc2 {
> >> +&mmc3 {
> >>       pinctrl-names = "default";
> >> -     pinctrl-0 = <&mmc2_8bit_emmc_pins>;
> >> +     pinctrl-0 = <&mmc3_8bit_emmc_pins>;
> >>       vmmc-supply = <&reg_dcdc1>;
> >> +     vqmmc-supply = <&reg_dcdc1>;
> >
> > That seems odd. IIRC the VCC was supposed to be fixed and VCCQ could
> > be either at 1.8 or 3V. Having the same regulator on both would make
> > VCCQ forced to 3.3V, which seems to go against your commit log.
> >
> > What's the catch ? :)
> 
> That is how the board is routed. Which means the only use for
> vqmmc-supply is the driver will know that it can only do 3.3V,
> i.e. voltage sensing.
> 
> It is the reason I requested Olimex to look into this. Allwinner
> reference designs all tie vqmmc directly to 3.3V.
> 
> Actually with the latest driver patches, this is not even needed. To
> make the driver backward compatible, if no vqmmc-supply is given, it
> just assumes 3.3V signaling.

Ok. I've applied this patch and changed the commit log to remove the
voltage switching mention then, since it won't happen.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--f2QGlHpHGjS2mn6Y--
