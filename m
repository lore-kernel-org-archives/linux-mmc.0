From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date: Fri, 25 Oct 2019 12:50:46 +0200
Message-ID: <CAK8P3a0L3_Hs48X5bh0UD2L_AaxLcUOQ_YS7ZpSd5W-8xcgAog@mail.gmail.com>
References: <20191018154052.1276506-1-arnd@arndb.de> <87v9slg9k5.fsf@belgarion.home>
 <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
 <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
 <87r239f2g8.fsf@belgarion.home> <87eez1rhqo.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87eez1rhqo.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 24, 2019 at 10:50 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> >>> I've now pushed it to
> >>>
> >>> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> >>> pxa-multiplatform
> >>
> >> Sorry for the duplication, I had some problems with email configuration
> >> so my reply got rejected, let's see if it goes through this time.
> > I have it now, thanks, I'll test and review as soon as I can.
> >
> > Cheers.
>
> Ok Arnd, I have a preliminary test report.
>
> I tested only the pxa27x (mioa701), which happens to have a lot of drivers, and
> only the platform_data flavor (ie. no device-tree test yet). Apart a panic in
> the regulator framework (which is a known issue [1]), your version seems
> equivalent so far in terms of runtime to Linux 5.4-rc3).
>
> The sound and RTC seem broken, but not by you ...
>
> I'll continue the test onwards for pxa3xx and pxa2xx when I'll gather a bit of
> time, and try to review as well the mach-pxa part.

Awesome, thanks for testing so far and for the report!

        Arnd
