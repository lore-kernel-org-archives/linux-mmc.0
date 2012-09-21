From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 00/34] i.MX multi-platform support
Date: Sat, 22 Sep 2012 00:46:26 +0800
Message-ID: <20120921164622.GA5394@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
 <201209201556.57171.arnd@arndb.de>
 <20120921080123.GM2450@S2101-09.ap.freescale.net>
 <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Paulius Zaleckas <paulius.zaleckas-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Javier Martin <javier.martin-N4RbWZIug12MkV8/HQOAswC/G2K4zDHf@public.gmane.org>, Andrew Morton <akpm@linux->
List-Id: linux-mmc@vger.kernel.org

Hi Olof,

On Fri, Sep 21, 2012 at 01:26:43AM -0700, Olof Johansson wrote:
> I'll take a look at merging it tomorrow after I've dealt with smp_ops;
> if it looks reasonably conflict-free I'll pull it in. We need the
> sound dependency sorted out (or agreed upon) first though.
> 
I just published the branch below with this series rebased on top of
the necessary dependant branches.

  git://git.linaro.org/people/shawnguo/linux-2.6.git staging/imx-multiplatform

The dependant branches include:

* arm-soc/multiplatform/platform-data

* arm-soc/multiplatform/smp_ops

* git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.7

  It contains dependant patch "ASoC: mx27vis: retrieve gpio numbers
  from platform_data"

* git://git.infradead.org/mtd-2.6.git master

  The series is based on this tree to solve some non-trivial conflicts
  on mxc_nand driver.  Because mtd tree completely missed 3.6 merge
  window, having the series base on 3.6-rc actually means 3.5 code base
  in term of mtd support.  There are currently two cycles changes
  accumulated on mtd, and we need to base the series on it to sort out
  the conflicts.

* git://linuxtv.org/mchehab/media-next.git master

  The media tree renames mx2/mx3 camera drivers twice.  I'm not sure
  if git merge can detect them, so I just rebased the series on media
  tree to solve that.  The bonus point is that a number of trivial
  conflicts with imx27-coda support on media tree gets solved as well.

I'm not requesting you to pull the branch into arm-soc as a stable
branch but staging one, because the external dependencies which might
not be stable.  I attempt to use it for exposing the series on
linux-next, so that we can send it to Linus for 3.7 if there is chance
for us to (e.g. all the dependant branches hit mainline early during
3.7 merge window).

Shawn
