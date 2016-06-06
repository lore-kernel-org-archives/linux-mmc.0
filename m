From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/4] mmc: sh_mobile_sdhi: Add tuning support
Date: Mon, 6 Jun 2016 10:02:39 +0900
Message-ID: <20160606010238.GC4859@verge.net.au>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
 <1464057797-29951-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWs2cFgy8PtAUaYdfqnm+LU5cB9sn5WNnKsqRqza=nW6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52294 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcFFBCn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2016 21:02:43 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWs2cFgy8PtAUaYdfqnm+LU5cB9sn5WNnKsqRqza=nW6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Tue, May 31, 2016 at 12:39:58PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, May 24, 2016 at 4:43 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> 
> > @@ -403,6 +580,30 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
> >         if (ret < 0)
> >                 goto efree;
> >
> > +       if (host->mmc->caps & MMC_CAP_UHS_SDR104)
> > +               host->mmc->caps |= MMC_CAP_HW_RESET;
> > +
> > +       if (of_id && of_id->data) {
> > +               const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
> > +               const struct sh_mobile_sdhi_scc *taps = of_data->taps;
> > +               bool hit = false;
> > +
> > +               for (i = 0; i < of_data->taps_num; i++) {
> > +                       if (taps[i].clk_rate == 0 ||
> > +                           taps[i].clk_rate == host->mmc->f_max) {
> > +                               host->scc_tappos = taps->tap;
> > +                               hit = true;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (!hit)
> > +                       dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104 and HS200\n");
> 
> This warning triggers on sh7a0/kzm9g, r8a73a4/ape6evm, and
> r8a7740/armadillo.
> 
> Perhaps the tap code should check if MMC_CAP_UHS_SDR104 is
> enabled?

Thanks. Yes, I think that would be sensible.
