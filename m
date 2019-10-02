From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
Date: Wed, 2 Oct 2019 11:20:07 +0200
Message-ID: <CAMuHMdW=zF=hf2wHEeUHDciYF7wU7j0XZYuiG=T0vpsvykLCSA@mail.gmail.com>
References: <20191001180703.910-1-geert+renesas@glider.be> <bc48041c-df06-8108-9c45-3dfb1d527678@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc48041c-df06-8108-9c45-3dfb1d527678@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Sergei,

On Wed, Oct 2, 2019 at 11:11 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01.10.2019 21:07, Geert Uytterhoeven wrote:
> > As platform_get_irq() now prints an error when the interrupt does not
> > exist, counting interrupts by looping until failure causes the printing
>
>    s/the//?

I believe "the printing" is correct.
Any native English speakers to comment?

> > of scary messages like:
> >
> >      renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found
> >
> > Fix this by using the platform_irq_count() helper to avoid touching
> > non-existent interrupts.
> >
> > Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> [...]
> > @@ -825,24 +825,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> >               host->hs400_complete = renesas_sdhi_hs400_complete;
> >       }
> >
> > -     i = 0;
> > -     while (1) {
> > +     /* There must be at least one IRQ source */
> > +     num_irqs = platform_irq_count(pdev);
> > +     if (num_irqs < 1) {
> > +             ret = num_irqs;
> > +             goto eirq;
>
>     This will return 0 with failed probe if 'num_irqs' is 0, I don't think you
> want this...

Thanks, will fix.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
