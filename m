From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
Date: Tue, 23 Apr 2019 18:09:19 -0700
Message-ID: <CAD=FV=XuCrymazJDKBYqLezkYkikzGNiv6X0FdzNG0SaR8PuRw@mail.gmail.com>
References: <20190410221237.160856-1-dianders@chromium.org>
 <CAD=FV=Wm+T+W=LWTSiwBT3UQWG7YKQdGuL2+BmAFQhk8CYY1mQ@mail.gmail.com> <6e5c9395-51b0-7f28-ec91-de95cb54f58d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6e5c9395-51b0-7f28-ec91-de95cb54f58d-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ryan Case <ryandcase-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 23, 2019 at 5:57 PM Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>
> The intention seems reasonable to me, but just wonder if we need
> mask/unmask SDIO interrupt when it's never used?

I don't think we do.

Specifically "client_sdio_enb" starts out as false.  If nobody ever
calls dw_mci_enable_sdio_irq() then "client_sdio_enb" will always
continue to be false.

Now at suspend time we'll call "__dw_mci_enable_sdio_irq".  Because
"client_sdio_enb" is false then the local variable "enb" will always
be false.  Sure we'll clear the "SDMMC_INT_SDIO" from the "INTMASK"
register, but it should already have been cleared so this is a no-op.

...at resume time we'll have a similar situation where
"client_sdio_enb" is false and thus we'll (again) just clear the
"SDMMC_INT_SDIO" from the "INTMASK".

I could potentially optimize away the "mci_writel()" if we're not
changing anything if you're worried about that?


> It's the same
> situation for SDMMC_CLKEN_LOW_PWR that we couldn't stop providing
> clock for SDIO cards, so I guess we need to check MMC_CAP_SDIO_IRQ
> as well.

I think it might be a slightly different situation though.  In this
case I believe it's not just a problem with clock stoppage.  I believe
the problem is that the interrupt will be passed to the SDIO device
driver right away and that'll call back into dw_mmc.  dw_mmc is just
not in a state to handle it until we've more fully resumed things.

In any case with my patch the only way we'd ever end up unmasking the
SDIO IRQ here would be if dw_mci_enable_sdio_irq() was called.  That
will only happen if there's an SDIO card plugged in.


-Doug
