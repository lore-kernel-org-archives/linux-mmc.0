From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
Date: Wed, 11 Dec 2013 13:55:27 +0800
Message-ID: <20131211055525.GK18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-2-git-send-email-b29396@freescale.com>
 <20131211015640.GA18380@S2101-09.ap.freescale.net>
 <CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
 <20131211031254.GF18380@S2101-09.ap.freescale.net>
 <CAA+hA=QrEiwg8+hmEONgP5u6C0_YwQhEeBfDoFQTv=aCaLhqkQ@mail.gmail.com>
 <20131211035654.GI18380@S2101-09.ap.freescale.net>
 <CAA+hA=TjhLKmLucm9R3fkiDQGCxTf_5WCMKbgyBXuuqC6Q0-RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:34806
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab3LKFzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:55:13 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=TjhLKmLucm9R3fkiDQGCxTf_5WCMKbgyBXuuqC6Q0-RQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 12:59:55PM +0800, Dong Aisheng wrote:
> On Wed, Dec 11, 2013 at 11:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Wed, Dec 11, 2013 at 11:20:59AM +0800, Dong Aisheng wrote:
> >> No, the max_to is the max timeout counter value, you need to divide it
> >> by the timeout clock
> >> to get the timeout time.
> >> The defined of this API is return the max timeout value in
> >> miliseconds, so you need to
> >> divide the clock by 1000.
> >> None of these handles the detail bout discard_to.
> >
> > Let me start it over again.  Here is basically what your patch does.
> >
> > -     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> > +     if (host->ops->get_max_timeout)
> > +             mmc->max_discard_to = host->ops->get_max_timeout(host);
> >
> > The only thing that does not work for you in the existing code is the
> > (1 << 27) part, right?
> >
> > If so, why not just create a platform hook to return the correct thing
> > for you platform, i.e. (1 << 28)?
> >
> >         if (host->ops->get_max_timeout)
> >                 mmc->max_discard_to = host->ops->hook_foo(host);
> >
> > unsigned int esdhc_hook_foo(struct sdhci_host *host)
> > {
> >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >         struct pltfm_imx_data *imx_data = pltfm_host->priv;
> >
> >         return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
> > }
> >
> > Such patch will be ease to be understood and less offensive to the
> > existing code, no?
> >
> 
> The example you give is not correct here.

Sorry.  Yes, there is a error in my example code.  What about this?

	mmc->max_discard_to = host->ops->hook_foo ? host->ops->hook_foo(host) : 1 << 27;
	mmc->max_discard_to /= host->timeout_clk;

Shawn

