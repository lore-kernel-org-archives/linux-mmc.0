From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 00/34] i.MX multi-platform support
Date: Thu, 20 Sep 2012 19:52:15 +0800
Message-ID: <20120920115213.GF2450@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920114148.GH17666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120920114148.GH17666@opensource.wolfsonmicro.com>
Sender: linux-media-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-mtd@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Vinod Koul <vinod.koul@linux.intel.com>, Paulius Zaleckas <paulius.zalecka>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2012 at 07:41:50AM -0400, Mark Brown wrote:
> It's usually pretty early but Takashi will be on holiday this time so
> I'm not sure if things might be different (he was going to send the pull
> request from holiday).  I also didn't guarantee that it'll be stable
> yet, can someone please tell me what the depenency is here?

We need the patch to have all imx drivers mach/* inclusion free,
so that we can enable multi-platform support for imx, which is the
whole point of the series.

If your for-3.7 is not stable anyway, I guess the easiest the way
to do it might be you drop the patch "ASoC: mx27vis: retrieve gpio
numbers from platform_data" from your tree and I have it be part of
the series to go via arm-soc tree as a whole.  (This is the original
plan that I mentioned in v1 cover letter)

Shawn
