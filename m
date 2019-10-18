From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date: Fri, 18 Oct 2019 21:32:36 +0200
Message-ID: <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
References: <20191018154052.1276506-1-arnd@arndb.de> <87v9slg9k5.fsf@belgarion.home>
 <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 18, 2019 at 9:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Oct 18, 2019 at 9:04 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> >
> > > Hi PXA maintainers,
> > >
> > > I'm in the process of getting the old ARM platforms to all build
> > > in a single kernel. The largest part of that work is changing all
> > > the device drivers to no longer require mach/*.h header files.
> > >
> > > This series does it for arch/pxa/.
> > >
> > > As with the omap1 and s3c24xx series I sent before, I don't
> > > expect this all to be correct in the first version, though
> > > a lot of the patches are fairly simple and I did exhaustive
> > > compile-time testing on them.
> > >
> > > Please test if you have the hardware, or review!
> >
> > Hi Arnd,
> >
> > Would you have a git tree I can pull from ?
> > That would make my life easier than applying manually 46 patches...
>
> I've now pushed it to
>
> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> pxa-multiplatform

Sorry for the duplication, I had some problems with email configuration
so my reply got rejected, let's see if it goes through this time.

       Arnd
