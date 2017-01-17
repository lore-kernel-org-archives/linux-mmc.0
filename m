From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Dropping device tree pinmux nodes for GPIO usage
 (Was: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes)
Date: Tue, 17 Jan 2017 09:33:51 +0100
Message-ID: <20170117083351.jy7jsdpi2zvufq5q@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
 <20170115155931.l5tjcdhbz6sj3wke@localhost>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibjbuieytilcvimr"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB6VN67BQKGQEWZ7WNTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170115155931.l5tjcdhbz6sj3wke@localhost>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rask Ingemann Lambertsen <rask-SivP7zSAdNDZaaYASwVUlg@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--ibjbuieytilcvimr
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Jan 15, 2017 at 04:59:32PM +0100, Rask Ingemann Lambertsen wrote:
> On Tue, Jan 03, 2017 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
> > On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wrote:
> > > +
> > > +                       mmc0_default_cd_pin: mmc0_cd_pin@0 {
> > > +                               pins = "PF6";
> > > +                               function = "gpio_in";
> > > +                               bias-pull-up;
> > > +                       };
> > 
> > We are starting to drop pinmux nodes for gpio usage.
> 
> How do we get the equivalent of bias-pull-up/down and drive-strength if we
> run across a pin that needs it?

Hmm, that's actually a very good question...

For those cases, leave the pinctrl node for now, we'll deal with that
in due time

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ibjbuieytilcvimr--
