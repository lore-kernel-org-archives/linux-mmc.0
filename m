From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
Date: Fri, 26 Apr 2019 15:08:41 -0700
Message-ID: <CAD=FV=UzRbp0w_cN07kQ9dH1B3+v7fmA4_t46kP3cy1k_hn9Ug@mail.gmail.com>
References: <20190410221237.160856-1-dianders@chromium.org>
 <CANBLGcwmNowj9GSmE3bbo1t1o6EF8q-RiJftfdOQnJB9_8aSKg@mail.gmail.com>
 <CAD=FV=UW6d2QHzxx-Vtr+WwC1dkpUfCjxCLnfaP5S2UQxRh1oQ@mail.gmail.com> <CANBLGcxpjDFKNdT7uk8uCS=C8Gjxc9wVqDs_ZGHqRpLFVsJxxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANBLGcxpjDFKNdT7uk8uCS=C8Gjxc9wVqDs_ZGHqRpLFVsJxxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, linux-wireless <linux-wireless@vger.kernel.org>, stable@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Matthias Kaehlcke <mka@chromium.org>, Ryan Case <ryandcase@chromium.org>, Kalle Valo <kvalo@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 26, 2019 at 10:19 AM Emil Renner Berthing
<emil.renner.berthing@gmail.com> wrote:
>
> Hi Doug,
>
> TLDR: I'm no longer convinced this patch breaks suspend/resume more
> than it already is. Sorry about the noise.
>
> On Thu, 25 Apr 2019 at 23:25, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Apr 24, 2019 at 1:19 AM Emil Renner Berthing
> > <emil.renner.berthing@gmail.com> wrote:
> > >
> > > Hi Douglas,
> > >
> > > Unfortunately this seems to beak resume on my rk3399-gru-kevin. I have
> > > a semi-complicated setup with my rootfs as a btrfs on dmcrypt on
> > > mmcblk0 which is the dw_mmc, so I'm guessing something goes wrong when
> > > waking up the dm_mmc which probably wasn't suspended before this
> > > patch. It's not 100% consistent though. Sometimes I see it resume the
> > > first time I try suspending, but then 2nd time I suspend it won't come
> > > back.
> >
> > Thanks for testing!
>
> Thanks for your detailed response. It made me want to make absolutely
> sure that this patch is the culprit.
> As a baseline I booted a vanilla 5.0.9 and suspend/resumed it about a
> dusin times without any errors.
> So I applied this patch and immediately it crashed on suspend, but in
> a way that I could still see the kernel log,
> and it was the mwifiex driver that crashed. I rebooted and tried
> supend/resume again and
> this time it seemed like it was the dwc3 or usb3-phy that crashed.
> I still have the kernel log if anyone is interested.
> However 3rd time booting 5.0.9 with this patch suspend/resume just works.
> At least the 2 dusin times I tried before giving up on making it crash.
> I went back to vanilla 5.0.9 and after a few tries I managed to make
> that one crash too.
> I guess that means this patch is off the hook. I'm sorry about the
> false report :/

No worries, I've certainly been there and I'm super happy to have
people testing patches.  :-)

Odd that you're having suspend/resume patches.  My first guess for
super randomness would be WiFi.  The PCIe bus on rk3399 causes the
most impossible to debug problems if you try to access it at the wrong
time.  If you disable WiFi do all your problems go away?  I tried
putting v5.0.9 on the kevin sitting on my desk and it seems to
suspend/resume OK (25 cycles), but:

* I just jammed it straight onto a normal Chrome OS root filesystem.
Since that filesystem expects the GPU to be there, I'm just booting to
a serial prompt and the screen just displays the boot splash.

* I didn't try to configure WiFi or anything.

* I'm using the Chrome OS "fallback config" for the kernel (the config
our build system picks if building an upstream kernel without the
normal split config).  AKA:
<https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/master/eclass/cros-kernel/rockchip64_defconfig>.
I'm not 100% sure everything is enabled there...

* I'm booting w/ serial console enabled and doing my testing with "no
console suspend" which can certainly affect suspend/resume timing.


Best of luck tracking your problems down!  I suppose if things used to
work maybe a bisect would be possible?

-Doug
