From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 2/7] mmc: mmci: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Tue, 18 Feb 2014 22:34:24 +0900
Message-ID: <001101cf2cae$23387d30$69a97790$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006101cf2a57$77859c00$6690d400$%jun@samsung.com>
 <CAPDyKFq6=ysG2sg8PWkt2C0iwCWL=yn4oZRxYXhJiSEruzO90g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21653 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbaBRNeZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 08:34:25 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N17001N11PCOG20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Feb 2014 22:34:24 +0900 (KST)
In-reply-to: <CAPDyKFq6=ysG2sg8PWkt2C0iwCWL=yn4oZRxYXhJiSEruzO90g@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Russell King' <linux@arm.linux.org.uk>, 'Chris Ball' <chris@printf.net>, 'Rickard Andersson' <rickard.andersson@stericsson.com>

On Mon, February 17, 2014, Ulf Hansson wrote:
> On 15 February 2014 15:08, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.
> >
> > CC: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Do note, normally Russell takes patches for mmci.
> 
> In this case I think it's important that the complete set gets merged
> together. Especially since patch 1, on it's own, actually breaks
> support for MMC DDR mode for some host drivers.

Thank you for your ack.
I also hope that.

Thanks,
Seungwon Jeon
> 
> Kind regards
> Ulf Hansson
> 
> > ---
> >  drivers/mmc/host/mmci.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index b931226..421d1fe 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -299,7 +299,8 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
> >         if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
> >                 clk |= MCI_ST_8BIT_BUS;
> >
> > -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> > +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> > +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> >                 clk |= MCI_ST_UX500_NEG_EDGE;
> >
> >         mmci_write_clkreg(host, clk);
> > @@ -784,7 +785,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
> >                         mmci_write_clkreg(host, clk);
> >                 }
> >
> > -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> > +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> > +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> >                 datactrl |= MCI_ST_DPSM_DDRMODE;
> >
> >         /*
> > --
> > 1.7.0.4
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

