From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
Date: Wed, 10 Jul 2019 13:21:57 -0700
Message-ID: <CAD=FV=WL_Hy78REn+0CMOjYgPcuDcN1w-+94QD9HHJraQBNj4g@mail.gmail.com>
References: <20190708195613.205729-1-dianders@chromium.org>
 <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
 <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com> <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Guenter Roeck <groeck@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux MMC List <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jul 9, 2019 at 3:02 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 9, 2019 at 9:38 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 9, 2019 at 2:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> > > > response errors.") we fixed a tuning-induced hang that I saw when
> > > > stress testing tuning on certain SD cards.  I won't re-hash that whole
> > > > commit, but the summary is that as a normal part of tuning you need to
> > > > deal with transfer errors and there were cases where these transfer
> > > > errors was putting my system into a bad state causing all future
> > > > transfers to fail.  That commit fixed handling of the transfer errors
> > > > for me.
> > > >
> > > > In downstream Chrome OS my fix landed and had the same behavior for
> > > > all SD/MMC commands.  However, it looks like when the commit landed
> > > > upstream we limited it to only SD tuning commands.  Presumably this
> > > > was to try to get around problems that Alim Akhtar reported on exynos
> > > > [1].
> > > >
> > > > Unfortunately while stress testing reboots (and suspend/resume) on
> > > > some rk3288-based Chromebooks I found the same problem on the eMMC on
> > > > some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> > > > tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> > > > vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> > > > same situation.
> > > >
> > > > I'm hoping that whatever problems exynos was having in the past are
> > > > somehow magically fixed now and we can make the behavior the same for
> > > > all commands.
> > > >
> > > > [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
> > > >
> > > > Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Alim Akhtar <alim.akhtar@gmail.com>
> > > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > ---
> > > > Marek (or anyone else using exynos): is it easy for you to test this
> > > > and check if things are still broken when we land this patch?  If so,
> > > > I guess we could have a quirk to have different behavior for just
> > > > Rockchip SoCs but I'd rather avoid that if possible.
> > > >
> > > > NOTE: I'm not hoping totally in vain here.  It is possible that some
> > > > of the CTO/DTO timers that landed could be the magic that would get
> > > > exynos unstuck.
> > >
> > > I have eMMC module attached to Odroid U3 (Exynos4412,
> > > samsung,exynos4412-dw-mshc). What is the testing procedure? With your
> > > patch it boots fine:
> > > [    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> > > req 52000000Hz, actual 50000000HZ div = 0)
> > > [    3.703900] mmc1: new DDR MMC card at address 0001
> > > [    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB
> >
> > To really test it, it'd be nice to see some HS200 eMMC cards enumerate
> > OK.  Specifically the patch adjusts the error handling and the place
> > where that happens mostly is during tuning.
> >
> > I'll also try to find some time today to check a peach_pit or a
> > peach_pi.  I think I saw one in the pile near my desk so if it isn't
> > in too bad of a shape I can give mainline a shot on it.
>
> OK, I managed to get an exynos5800-peach-pi up and running.  I put my
> patch in place and am currently at 45 reboots and counting w/ no
> problems.

In case it helps, I made it through 2379 more reboots on my peach_pi
w/ no hangs.  I'm putting the device back in mothball now.  :-P  I
didn't go back and try to reproduce the original problems so I guess I
can't assert with 100% authority that the original issue is gone, but
my testing combined with Enric's seems like things are working fine.

-Doug
