From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 4/8] mmc: sdhci: do not enable card detect interrupt
 for gpio cd type
Date: Tue, 23 Sep 2014 15:10:48 +0800
Message-ID: <20140923071027.GA12146@shlinux1.ap.freescale.net>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
 <1411377131-19741-5-git-send-email-b29396@freescale.com>
 <CAPDyKFoD6G7w5gZEBGeqrmxDWyGHMy0_daikSmUfLCnZzZ-K_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:2688
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751989AbaIWHjF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 03:39:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoD6G7w5gZEBGeqrmxDWyGHMy0_daikSmUfLCnZzZ-K_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 23, 2014 at 09:27:49AM +0200, Ulf Hansson wrote:
> On 22 September 2014 11:12, Dong Aisheng <b29396@freescale.com> wrote:
> > Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
> > we also do not need to handle controller native card detect interrupt
> > for gpio as card detect case.
> > If we wrong enabled the card detect interrupt for gpio case,
> > it will cause a lot of unexpected card detect interrupts during data transfer
> > which should not happen.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 7481bd8..85cbf45 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -136,9 +136,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> >  static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
> >  {
> >         u32 present;
> > +       int gpio_cd = mmc_gpio_get_cd(host->mmc);
> >
> >         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> > -           (host->mmc->caps & MMC_CAP_NONREMOVABLE))
> > +           (host->mmc->caps & MMC_CAP_NONREMOVABLE) || !IS_ERR_VALUE(gpio_cd))
> 
> If you have a properly working gpio_cd, then why does you also have
> SDHCI_QUIRK_BROKEN_CARD_DETECTION set? Isn't that the actual problem?
> 

SDHCI_QUIRK_BROKEN_CARD_DETECTION seems only for controller CD function.
Thus even we're using gpio_cd, we still have this quirk set for controller
to avoid enable controller cd interrupts.
Does it make sense?

Regards
Dong Aisheng

> Kind regards
> Uffe
> 
> >                 return;
> >
> >         if (enable) {
> > --
> > 1.7.8
> >
