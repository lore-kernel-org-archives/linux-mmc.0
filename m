From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3 3/4] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Tue, 3 Jun 2014 14:43:13 +0100
Message-ID: <20140603134313.GE1310@leverpostej>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
 <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFpTTYHtkKjFmbPi6P_xfdfd8Fv8qfpKZMfpQBppRNZLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpTTYHtkKjFmbPi6P_xfdfd8Fv8qfpKZMfpQBppRNZLwg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 30, 2014 at 09:01:16AM +0100, Ulf Hansson wrote:
> On 28 May 2014 07:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> > Removed the parser for "supports-highspeed".
> > It can be parsed with "cap-mmc-highsped" or "cap-sd-highspeed" at
> > mmc_of_parse().
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 3285bdd..34b5210 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -2281,9 +2281,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
> >                         return ERR_PTR(ret);
> >         }
> >
> > -       if (of_find_property(np, "supports-highspeed", NULL))
> > -               pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> > -
> 
> According to DT guys, normally we shouldn't remove DT bindings. Thus,
> you need to keep this, unless you can get some of the DT guys to ack
> it.

In general, yes. Unless there's a compelling reason to drop a binding,
and all users are happy with it being dropped, then there's not much
point in removing it. It's usually not possible to get agreement because
it's usually nto possible to know the full set of users, so in general
we can't drop or change stuff.

> Though, you still want to move the DTs to use common mmc bindings. And
> you could mark the documentation of the above binding as deprecated.

Deprecated bindings can be supported even if discouraged. As far as I
can see, keeping the existing binding along side the new one looks
relatively simple in this case.

Thanks,
Mark.
