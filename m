From: Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Date: Sun, 24 Nov 2019 11:20:38 +0800
Message-ID: <CANhBUQ3CsPbPWrs=NUZoFAv6g_ckuEV9sxy0Z_DTiPRJaXi+7g@mail.gmail.com>
References: <20191018131338.11713-1-hslester96@gmail.com> <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai> <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
 <20191031221211.GA3853@kunai> <CAMuHMdXSKU40E8Br0Z53H2FyrQsLxnB-EERZoN6HQHExP5tqxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXSKU40E8Br0Z53H2FyrQsLxnB-EERZoN6HQHExP5tqxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 7, 2019 at 4:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Wolfram,
>
> On Thu, Oct 31, 2019 at 11:58 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > Well, I don't like to bail out because this error is not fatal for basic
> > > > operations. How about releasing priv->pinctrl again with an additional
> > > > warning that pinctrl settings are broken and will prevent 1.8v modes?
> > > >
> > > > Opinions?
> > >
> > > Hmm, from a mmc driver probe point of view, I don't quite share this approach.
> > >
> > > I would rather fail as it forces the DTB to be corrected immediately,
> > > rather than trusting some developer to look at a warning in a log. The
> > > point is, in such a case it may never get fixed, if the product is
> > > shipped with the wrong DTB.
> >
> > I could agree to this arguement, iff the only way pinctrl_select fails
> > is a DT misconfiguration. I am not sure if this is true right now, and
> > we can't be sure about the future. Or?
>
> Isn't "state_uhs" optional? So bailing out if it doesn't exist is wrong.
> "default" should be there, if the device node has pinctrl properties.
>
> renesas_sdhi_start_signal_voltage_switch() already handles fallback
> to 3v3 operation.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

Just ping this thread.
I am not clear about what is the conclusion of how to deal with the error?
Should I resend a new version of the patch?

Regards,
Chuhong

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
