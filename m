From: Kyle Roeschley <kyle.roeschley@ni.com>
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Fri, 22 Sep 2017 08:57:04 -0500
Message-ID: <20170922135704.4s7um4xflv634c3h@senary>
References: <20170921174754.13648-1-kyle.roeschley@ni.com>
 <CAPDyKFru8b+gP+FYuuJ_TekA57mLfAuaFV7NKe2eZqik2FGa7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFru8b+gP+FYuuJ_TekA57mLfAuaFV7NKe2eZqik2FGa7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 22, 2017 at 11:38:40AM +0200, Ulf Hansson wrote:
> On 21 September 2017 at 19:47, Kyle Roeschley <kyle.roeschley@ni.com> wrote:
> > The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> > lowered to less than 0.5V for a minimum of 1 ms when powering off a
> > card. Increase our wait to 10 ms so that voltage has time to drain down
> > to 0.5V and cards can power off correctly.
> >
> > Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> > ---
> >  drivers/mmc/core/core.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 66c9cf49ad2f..38630246de26 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1679,18 +1679,16 @@ void mmc_power_off(struct mmc_host *host)
> >         mmc_set_initial_state(host);
> >
> >         /*
> > -        * Some configurations, such as the 802.11 SDIO card in the OLPC
> > -        * XO-1.5, require a short delay after poweroff before the card
> > -        * can be successfully turned on again.
> > +        * The SD spec requires at least 1 ms with Vdd at less than 0.5 V
> > +        * before a card can be re-powered, but we need to wait longer so that
> > +        * the voltage has time to drain.
> >          */
> > -       mmc_delay(1);
> > +       mmc_delay(10);
> 
> No, this isn't the proper place of adding more "magic" delays.
> 
> Instead, make sure the related ->set_ios() callback in the mmc host
> driver deals with this instead. In case it uses an external regulator,
> via the regulator API, then this is something that should be
> controlled with the definition of the regulator.
> 

Thanks for pointing me in the right direction, I'll reimplement the fix there.

-- 
Kyle Roeschley
Software Engineer
National Instruments
