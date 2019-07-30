From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/2] mmc: core: Fix Marvell WiFi reset by adding SDIO
 API to replug card
Date: Tue, 30 Jul 2019 09:59:42 -0700
Message-ID: <CAD=FV=VfabHB=ALxvAZ_grg_V6Nkv1UkhHjHjp-_Fs=Bx94WAA@mail.gmail.com>
References: <20190722193939.125578-1-dianders@chromium.org> <CALtMJEB871Redpzx1u6G5GVEXz-kAP=vT6Wt98=X=xm4SEMeAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CALtMJEB871Redpzx1u6G5GVEXz-kAP=vT6Wt98=X=xm4SEMeAQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless <linux-wireless@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev <netdev@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>, linux-mmc <linux-mmc@vger.kernel.org>, David Miller <davem@davemloft.net>, Xinming Hu <huxinming820@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jul 30, 2019 at 1:47 AM Andreas Fenkart <afenkart@gmail.com> wrote:
>
> > * Sometimes while I was testing I saw "Fail WiFi 1" indicating a
> >   transitory failure.  Usually this was an association failure, but in
> >   one case I saw the device do "Firmware wakeup failed" after I
> >   triggered the reset.  This caused the driver to trigger a re-reset
> >   of itself which eventually recovered things.  This was good because
> >   it was an actual test of the normal reset flow (not the one
> >   triggered via sysfs).
>
> This error triggers something. I remember that when I was working on
> suspend-to-ram feature, we had problems to wake up the firmware
> reliable. I found this patch in one of my old 3.13 tree
>
>     the missing bit -- ugly hack to force cmd52 before cmd53.

Thanks for the reference!  At the moment I'm not terribly worried
about this particular failure case (compared to other failure modes)
because it's rare and it self-heals.

...my best guess, though, is that the problem isn't exactly the same.
The "Firmware wakeup failed" is a pretty generic error message, kind
of like "something went wrong" and not all instances of this message
will have the same root cause.

I actually dealt with a few suspend/resume issues around mwifiex
recently though.  If you ever uprev, you might be interested in:

b82d6c1f8f82 mwifiex: Make resume actually do something useful again
on SDIO cards
83293386bc95 mmc: core: Prevent processing SDIO IRQs when the card is suspended

-Doug
