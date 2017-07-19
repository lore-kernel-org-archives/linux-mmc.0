From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mmc: core: Fix access to HS400-ES devices
Date: Wed, 19 Jul 2017 21:32:29 +0200
Message-ID: <20170719193229.GA8020@kroah.com>
References: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
 <CAPDyKFq61A0AgO=P0yVCYFDwym=32yVRAJG9rT0tBnyNjXEyaw@mail.gmail.com>
 <CAD=FV=WszhdQ8NY8atSzzhNfbZxjPzU8SthGiiHgQJO=942xAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WszhdQ8NY8atSzzhNfbZxjPzU8SthGiiHgQJO=942xAw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>, Brian Norris <briannorris@chromium.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 19, 2017 at 11:12:45AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 14, 2017 at 9:22 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 1 March 2017 at 23:11, Guenter Roeck <linux@roeck-us.net> wrote:
> >> HS400-ES devices fail to initialize with the following error messages.
> >>
> >> mmc1: power class selection to bus width 8 ddr 0 failed
> >> mmc1: error -110 whilst initialising MMC card
> >>
> >> This was seen on Samsung Chromebook Plus. Code analysis points to
> >> commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
> >> high-speed mode"), which attempts to set the bus width for all but
> >> HS200 devices unconditionally. However, for HS400-ES, the bus width
> >> is already selected.
> >>
> >> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> >> Cc: Douglas Anderson <dianders@chromium.org>
> >> Cc: Brian Norris <briannorris@chromium.org>
> >> Fixes: 3d4ef329757c ("mmc: core: fix multi-bit bus width ...")
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Sorry for the delay. Been traveling.
> >
> > Applied for fixes, thanks!
> 
> +stable
> 
> The commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
> high-speed mode") got backported to many stable branches, so probably
> this commit 773dc118756b ("mmc: core: Fix access to HS400-ES devices")
> also needs to get picked to the same stable branches.
> 
> In the very least v4.9 and v4.4 stable includes the broken patch but
> not this fix.

Ah, thanks, I missed that somehow, I think I saw the fixes: field and
didn't realize that that commit was already backported.

I'll queue it up after these next kernels are released in a few days.

thanks,

greg k-h
