From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH] mmc: slot-gpio: restore error reporting
Date: Tue, 19 Aug 2014 20:32:58 +0200
Message-ID: <20140819183258.GA14825@schnuecks.de>
References: <1408418880-10250-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFq4CjwRfZeCbLf-wtBc7LU+YyLcD8xThPJQKbi49KpZ6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq4CjwRfZeCbLf-wtBc7LU+YyLcD8xThPJQKbi49KpZ6g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf, Linus,

On Tue, Aug 19, 2014 at 09:29:59AM +0200, Ulf Hansson wrote:
> On 19 August 2014 05:28, Linus Walleij <linus.walleij@linaro.org> wrote:
> > The patch switching the MMC core to use GPIO descriptors
> > depromoted errors to debug messages for unsuccessful attempt
> > to get CD or WP GPIOs. This was because sometimes these are
> > not specified, and that should not be an error.
> >
> > However that is not so helpful: explicitly check whether a
> > GPIO is not specified (i.e. -ENOENT is returned) and if there
> > is some other error, report it with dev_err().
> >
> > Reported-by: Simon Baatz <gmbnomis@gmail.com>
> > Cc: Simon Baatz <gmbnomis@gmail.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Until we have a fix for the !GPIOLIB, I will drop the four gpiod
> patches I recently applied.
> 
> I suggest we fold this change into one of the earlier patcher instead.
> Please send a new version of the complete patchset.
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/core/host.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 048c6d687cc9..6f7ed9c50346 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -368,9 +368,11 @@ int mmc_of_parse(struct mmc_host *host)
> >                 if (ret) {
> >                         if (ret == -EPROBE_DEFER)
> >                                 return ret;
> > -                       dev_dbg(host->parent,
> > -                               "Failed to request CD GPIO: %d\n",
> > -                               ret);
> > +                       if (ret != -ENOENT) {
> > +                               dev_err(host->parent,
> > +                                       "Failed to request CD GPIO: %d\n",
> > +                                       ret);

Previously, we returned the error code to the caller. As said, it is
debatable whether failure to get the GPIO is "bad enough" to let the
driver's probe fail (see the past discussion [1,2]).  In the end it
is a policy decision that should be taken by you and Chris.  If it
stays as proposed here, you can add my Tested-By (on Kirkwood using
mvsdio) if you like.


> > +                       }
> >                 } else
> >                         dev_info(host->parent, "Got CD GPIO\n");
> >         }
> > @@ -383,9 +385,11 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (ret) {
> >                 if (ret == -EPROBE_DEFER)
> >                         goto out;
> > -               dev_dbg(host->parent,
> > -                       "Failed to request WP GPIO: %d\n",
> > -                       ret);
> > +               if (ret != -ENOENT) {
> > +                       dev_err(host->parent,
> > +                               "Failed to request WP GPIO: %d\n",
> > +                               ret);

Same reasoning applies here, of course.

> > +               }
> >         } else
> >                 dev_info(host->parent, "Got WP GPIO\n");
> >
> > --
> > 1.9.3
> >
> 

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168039.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168248.html
