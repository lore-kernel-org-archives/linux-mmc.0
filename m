From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
Date: Wed, 11 Dec 2013 11:12:56 +0800
Message-ID: <20131211031254.GF18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-2-git-send-email-b29396@freescale.com>
 <20131211015640.GA18380@S2101-09.ap.freescale.net>
 <CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:46556
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab3LKDMf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 22:12:35 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 11:00:03AM +0800, Dong Aisheng wrote:
> >> @@ -2930,7 +2930,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >>       if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> >>               host->timeout_clk = mmc->f_max / 1000;
> >>
> >> -     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> >> +     if (host->ops->get_max_timeout)
> >> +             mmc->max_discard_to = host->ops->get_max_timeout(host);
> >
> > Does "timeout" conceptually equals to "discard_to"?  If not, we might
> > want to write it in the either form below to avoid messing these two
> > concepts.
> >
> 
> No, they're two concepts but the max_discard_to equals to the max timeout value
> the host supports.

Does it?  Shouldn't max_discard_to equals to max_timeout_value / timeout_clk?

> 
> >         mmc->max_discard_to = host->ops->get_max_timeout(host) / host->timeout_clk;
> >
> > or
> >
> >         mmc->max_discard_to = host->ops->get_max_discard_to(host);
> >
> > I guess you may want to go for the second one.
> >
> 
> The original way looks ok to me.
> Platform host driver does not need to know detail about discard,
> just tell the max timeout value it supports is ok.
> Common sdhci driver will handle it well.

Well, looking at the patch #2, esdhc_get_max_timeout() returns

  max_to / (esdhc_pltfm_get_max_clock(host) / 1000)

not just the max timeout value - max_to, so your platform host driver
is knowing and handling the details about discard_ro, i.e. the
discard_ro has to be max_timeout_value / timeout_clk.

Shawn

