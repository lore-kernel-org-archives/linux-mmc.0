From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 08/15] ARM: dts: sun6i: Add mmc3 pins
 for 8 bit emmc
Date: Sun, 24 Jan 2016 17:54:47 +0100
Message-ID: <20160124165447.GA7908@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-9-git-send-email-wens@csie.org>
 <20160122203138.GB3682@lukather>
 <CAGb2v66Ma7QmJpNO=Gv=ojrwL3n_MZm3H5XNKA2fpf_3AbOTBA@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBWEDSS2QKGQEIVEOSNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66Ma7QmJpNO=Gv=ojrwL3n_MZm3H5XNKA2fpf_3AbOTBA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sat, Jan 23, 2016 at 07:04:54PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sat, Jan 23, 2016 at 4:31 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi,
> >
> > On Thu, Jan 21, 2016 at 01:26:35PM +0800, Chen-Yu Tsai wrote:
> >> mmc2 and mmc3 are available on the same pins, with different mux values.
> >> However, only mmc3 supports 8 bit DDR transfer modes.
> >>
> >> Since preference for mmc3 over mmc2 is due to DDR transfer modes, just
> >> set the drive strength to 40mA, which is needed for DDR.
> >>
> >> This pinmux setting also includes the hardware reset pin for emmc.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> ---
> >>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> index b6ad7850fac6..1867af24ff52 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> @@ -709,6 +709,16 @@
> >>                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>                       };
> >>
> >> +                     mmc3_8bit_emmc_pins: mmc3@1 {
> >> +                             allwinner,pins = "PC6", "PC7", "PC8", "PC9",
> >> +                                              "PC10", "PC11", "PC12",
> >> +                                              "PC13", "PC14", "PC15",
> >> +                                              "PC24";
> >> +                             allwinner,function = "mmc3";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_40_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >
> > Is that reset pin optional?
> >
> > If so, I'd prefer it to be a separate node, like we're doing for the
> > SPI chip selects for example.
> >
> > It allows more reusability between different devices without declaring
> > new nodes.
> 
> All eMMC devices have a reset pin. The MMC standard specifies this as
> one way to reset the card, others being a special reset command, or
> powering the card off. It also notes a state when the card will not
> accept commands, and will require a power cycle or asserting the reset
> pin.
> 
> I assume all designs would route this pin. The FEX files also have this
> pin included by default.

I was more concerned about the case were you'd have a 8bits bus
without an emmc. But I guess that can't happen, since all SD cards are
using a 4 bits width anyway.

I'll apply this patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--pWyiEgJYm5f9v55/--
