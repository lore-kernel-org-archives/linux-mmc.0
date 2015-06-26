From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: let GPIO based card detection have
 higher precedence
Date: Fri, 26 Jun 2015 14:12:54 +0300
Message-ID: <1435317174.32171.9.camel@linaro.org>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
		 <1435312810-23957-2-git-send-email-ivan.ivanov@linaro.org>
		 <558D273F.8020108@intel.com> <1435316413.32171.4.camel@linaro.org>
	 <558D32EF.8020708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33937 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbFZLM5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 07:12:57 -0400
Received: by wicnd19 with SMTP id nd19so42275478wic.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 04:12:56 -0700 (PDT)
In-Reply-To: <558D32EF.8020708@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org


On Fri, 2015-06-26 at 14:09 +0300, Adrian Hunter wrote:
> On 26/06/15 14:00, Ivan T. Ivanov wrote:
> > On Fri, 2015-06-26 at 13:19 +0300, Adrian Hunter wrote:
> > > On 26/06/15 13:00, Ivan T. Ivanov wrote:
> > > > Controller could have BROKEN_CARD_DETECTION quirk set, but drivers
> > > > could use GPIO to detect card present state. Let, when defined, GPIO
> > > > take precedence, so drivers could properly detect card state and not
> > > > use polling.
> > > > 
> > > > Signed-off-by: Ivan T. Ivanov ivanov@linaro.org>
> > > > ---
> > > >  drivers/mmc/host/sdhci.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > > index bc14452..8bafb9f 100644
> > > > --- a/drivers/mmc/host/sdhci.c
> > > > +++ b/drivers/mmc/host/sdhci.c
> > > > @@ -1601,15 +1601,18 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
> > > >         if (host->flags & SDHCI_DEVICE_DEAD)
> > > >                 return 0;
> > > > 
> > > > +       /*
> > > > +               * Try slot gpio detect, if defined it take precedence
> > > > +               * over build in controller functionality
> > > > +               */
> > > > +       if (!IS_ERR_VALUE(gpio_cd))
> > > > +               return !!gpio_cd;
> > > > +
> > > 
> > > You've also put it above the MMC_CAP_NONREMOVABLE check which doesn't seem
> > > right.
> > > 
> > 
> > Probably, but what are the chances that this is valid GIO for non-removable cards.
> > I could rework it if you insist.
> 
> It is nicer not to have to think "what are the chances", and nicer that the
> logic is strictly correct, so yes please.
> 

Sure, will do.

Thanks,
Ivan
