From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
Date: Wed, 5 Jun 2013 23:45:06 +0200
Message-ID: <20130605214506.GC14209@lukather>
References: <201306030055.15413.heiko@sntech.de>
 <201306030102.20890.heiko@sntech.de>
 <20130605091119.18432af4@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130605091119.18432af4@skate>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, John Stultz <john.stultz@linaro.org>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

On Wed, Jun 05, 2013 at 09:11:19AM +0200, Thomas Petazzoni wrote:
> Dear Heiko St=FCbner,
>=20
> On Mon, 3 Jun 2013 01:02:20 +0200, Heiko St=FCbner wrote:
> > index 0000000..a2d8c70
> > --- /dev/null
> > +++ b/arch/arm/mach-rockchip/Makefile.boot
> > @@ -0,0 +1,3 @@
> > +zreladdr-$(CONFIG_ARCH_ROCKCHIP)	:=3D 0x60408000
> > +params_phys-$(CONFIG_ARCH_ROCKCHIP)	:=3D 0x60088000
> > +initrd_phys-$(CONFIG_ARCH_ROCKCHIP)	:=3D 0x60800000
>=20
> Thanks to the AUTO_ZRELADDR thing that you're using as part of the
> MULTIPLATFORM support, this Makefile.boot file is no longer useful. S=
ee
> mach-socfpga, mach-mvebu, mach-bcm2835, mach-bcm, mach-highbank, etc.
>=20
> Cc'ing Maxime Ripard, since I see that mach-sunxi does have a
> Makefile.boot, even though I believe it is not needed.

Yes, it is a left-over and should be removed obviously.

Thanks for reminding it to me :)

Maxime
