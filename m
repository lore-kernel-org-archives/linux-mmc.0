From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: core: properly init drv_type
Date: Mon, 4 Dec 2017 09:57:49 +0100
Message-ID: <20171204085749.67vqrjwqfpszba7b@verge.net.au>
References: <20171130144910.4320-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdWEWRy64foR9tNwxvwg-z3FLE8ZVT5CjmuEQ1sZtyHrBQ@mail.gmail.com>
 <20171204085045.oxodfyuczbbfkach@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204085045.oxodfyuczbbfkach@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 04, 2017 at 09:50:45AM +0100, Wolfram Sang wrote:
> On Mon, Dec 04, 2017 at 09:31:13AM +0100, Geert Uytterhoeven wrote:
> > Hi Wolfram,
> > 
> > On Thu, Nov 30, 2017 at 3:49 PM, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > > When the latest version of parsing the new eMMC bindings was moved from
> > > core.c to mmc.c, it was overlooked that drv_type could be used
> > > uninitialized. Fix it!
> > >
> > > Fixes: 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")
> > > Reported-by: Colin Ian King <colin.king@canonical.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >  drivers/mmc/core/mmc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index a552f61060d212..0d1c6b025ca596 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1290,7 +1290,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >
> > >  static void mmc_select_driver_type(struct mmc_card *card)
> > >  {
> > > -       int card_drv_type, drive_strength, drv_type;
> > > +       int card_drv_type, drive_strength, drv_type = 0;
> > >         int fixed_drv_type = card->host->fixed_drv_type;
> > >
> > >         card_drv_type = card->ext_csd.raw_driver_strength |
> > 
> > Could this be the cause of the issues Simon was seeing, cfr. 'Possible
> > regression due to "arm64: renesas: salvator: set driver type for eMMC"'?
> 
> Yes, there is a chance. It still worked for me, though.

I checked, it does not seem to help the issue I reported.
