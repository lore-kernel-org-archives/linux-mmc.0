From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: let GPIO based card detection have
 higher precedence
Date: Fri, 26 Jun 2015 14:00:13 +0300
Message-ID: <1435316413.32171.4.camel@linaro.org>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
	 <1435312810-23957-2-git-send-email-ivan.ivanov@linaro.org>
	 <558D273F.8020108@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <558D273F.8020108@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On Fri, 2015-06-26 at 13:19 +0300, Adrian Hunter wrote:
> On 26/06/15 13:00, Ivan T. Ivanov wrote:
> > Controller could have BROKEN_CARD_DETECTION quirk set, but drivers
> > could use GPIO to detect card present state. Let, when defined, GPIO
> > take precedence, so drivers could properly detect card state and not
> > use polling.
> > 
> > Signed-off-by: Ivan T. Ivanov ivanov@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index bc14452..8bafb9f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1601,15 +1601,18 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
> >         if (host->flags & SDHCI_DEVICE_DEAD)
> >                 return 0;
> > 
> > +       /*
> > +               * Try slot gpio detect, if defined it take precedence
> > +               * over build in controller functionality
> > +               */
> > +       if (!IS_ERR_VALUE(gpio_cd))
> > +               return !!gpio_cd;
> > +
> 
> You've also put it above the MMC_CAP_NONREMOVABLE check which doesn't seem
> right.
> 

Probably, but what are the chances that this is valid GIO for non-removable cards.
I could rework it if you insist.

Thank you,
Ivan

> >         /* If polling/nonremovable, assume that the card is always present. */
> >         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> >                                         (host->mmc->caps & MMC_CAP_NONREMOVABLE))
> >                 return 1;
> > 
> > -       /* Try slot gpio detect */
> > -       if (!IS_ERR_VALUE(gpio_cd))
> > -               return !!gpio_cd;
> > -
> >         /* Host native card detect */
> >         return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> >  }
> > --
> > 1.9.1
> > 
> > 
> > 
> 
> 
