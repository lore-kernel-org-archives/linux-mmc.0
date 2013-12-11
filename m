From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 11 Dec 2013 11:18:55 +0800
Message-ID: <20131211031853.GG18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-4-git-send-email-b29396@freescale.com>
 <20131211021646.GC18380@S2101-09.ap.freescale.net>
 <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:13764 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427Ab3LKDSb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 22:18:31 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 11:03:31AM +0800, Dong Aisheng wrote:
> >> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> >> +{
> >>       u8 ctrl;
> >>       struct mmc_data *data = cmd->data;
> >>       int ret;
> >>
> >>       WARN_ON(host->data);
> >>
> >> -     if (data || (cmd->flags & MMC_RSP_BUSY)) {
> >> -             count = sdhci_calc_timeout(host, cmd);
> >
> > From what I read the commit log, I think it might be more appropriate to
> > patch sdhci_calc_timeout() like the following?
> >
> >         if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
> >                 if (host->ops->get_max_timeout)
> >                         return host->ops->get_max_timeout(host);
> >                 else
> >                         return 0xE;
> >
> 
> The return val of sdhci_calc_timeout is the register value to be
> written into timeout counter register.
> host->ops->get_max_timeout returns the max timeout in miliseconds directly.
> So we can not do like that here.
> They're two concepts.

I did not make my comment clear.  The .get_max_timeout() is not the one
you defined in patch #1 any more, but something like the following for
esdhc driver, which returns correct timeout value not milliseconds.

unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
{
	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
	struct pltfm_imx_data *imx_data = pltfm_host->priv;

	return esdhc_is_usdhc(imx_data) ? 0xF : 0xE;

}

Does that match the problem you described in the commit log better?

Shawn

