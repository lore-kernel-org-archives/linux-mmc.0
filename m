From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date: Wed, 3 Oct 2018 20:34:55 +0900
Message-ID: <CAK7LNAS6TxN8rU-=wr1XXjkTJ2n+FK8YHqWCvOqMvXrMFHXoXg@mail.gmail.com>
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
 <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com> <20181002230115.GB812@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002230115.GB812@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,


On Wed, Oct 3, 2018 at 8:02 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Hi Yamada-san,
>
> On Mon, Oct 01, 2018 at 09:31:01PM +0900, Masahiro Yamada wrote:
> > CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
> >
> > Add a new hook host->reset for performing a platform-specific reset
> > sequence, and move CTL_RESET_SDIO over there.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I like it in general.
>
> > +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> > +{
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> > +     usleep_range(10000, 11000);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> > +     usleep_range(10000, 11000);
> > +}
> > +
>
> Are you sure resetting SDIO works independently of resetting SD? Maybe
> we should add resetting SD here, too, to keep the pattern...

I am not 100% sure
since I do not have this hardware.


> > --- a/drivers/mmc/host/tmio_mmc_core.c
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -164,14 +164,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
> >  {
> >       /* FIXME - should we set stop clock reg here */
> >       sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> > -     if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> > -             sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> >       usleep_range(10000, 11000);
> >       sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> > -     if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> > -             sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> >       usleep_range(10000, 11000);
>
> ... and have this simplified reset pattern either also in a seperate
> function, or doing...
>
> >
> > +     if (host->reset)
> > +             host->reset(host);
>         else
>                 simplified_reset_pattern
>
> ?
>
> What's your opinion?


OK, I will send v2.



> Regards,
>
>    Wolfram
>


-- 
Best Regards
Masahiro Yamada
