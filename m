From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [alsa-devel] [PATCH RESEND 0/9] Enable pinctrl support for
 mach-mxs
Date: Mon, 7 May 2012 16:01:32 +0800
Message-ID: <20120507080131.GD23607@shlinux2.ap.freescale.net>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
 <20120507071400.GB23607@shlinux2.ap.freescale.net>
 <20120507074658.GH19389@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120507074658.GH19389@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 07, 2012 at 03:47:00PM +0800, Shawn Guo wrote:
> On Mon, May 07, 2012 at 03:14:00PM +0800, Dong Aisheng wrote:
> > As IMX, basically i'd prefer to add pinctrl states in dts file at the
> > same time within the patch or using a separate patch to add them before
> > this series to avoid breaking the exist platforms.
> > 
> > However i noted that for mxs, most drivers here are still not dt capable,
> > so it may be ok to not add their pinctrl state at this time.
> > 
> There no mxs driver on mainline that has been DT aware of.  What I'm
> going to do is to ask Arnd abandon the mxs/dt branch I sent him before
> and send him an updated one with the whole mxs DT support based on
> mxs common clk and pinctrl series.
> 
> > But for the patch "serial: amba-pl011: adopt pinctrl support" since it is
> > dt capable, so with this patch applied, the mx28 dt boot will fail.
> > Maybe we should at least add pinctrl states for amba-pl011 first.
> > 
> The updated mxs/dt will have pinctrl defined in dts for each device
> that is converted to DT.
> 
Well, i did not see amba-pl011 pinctrl states defined in this patch.
But it would be ok if you can get it done and applied before this patch.

> > > Shawn Guo (9):
> > >   ARM: mxs: enable pinctrl dummy states
> > >   serial: amba-pl011: adopt pinctrl support
> > BTW, will this one break other platforms using this driver?
> > 
> If the platforms do not turn on CONFIG_PINCTRL, they are fine.  If they
> turn on the support, they should provide pinctrl state either dummy or
> real one.
> 

Regards
Dong Aisheng

