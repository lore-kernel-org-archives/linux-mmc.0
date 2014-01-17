From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/7] mmc: mmci: clarify DDR timing mode between SD-UHS and
 eMMC
Date: Fri, 17 Jan 2014 23:05:04 +0900
Message-ID: <000301cf138d$1ec3f930$5c4beb90$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <002001cf11fb$b7217380$25645a80$%jun@samsung.com>
 <CAPDyKFouGffRSikRbynES+euCuwCKbQXjspdq8oYq3Bg__pKEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33605 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbaAQOFG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 09:05:06 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZJ00DYUTSGST20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Jan 2014 23:05:05 +0900 (KST)
In-reply-to: <CAPDyKFouGffRSikRbynES+euCuwCKbQXjspdq8oYq3Bg__pKEA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Chris Ball' <chris@printf.net>, 'Rickard Andersson' <rickard.andersson@stericsson.com>, 'Russell King' <linux@arm.linux.org.uk>, 'linux-mmc' <linux-mmc@vger.kernel.org>

On Thu, January 16, 2014, Ulf Hansson wrote:
> On 15 January 2014 15:11, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Replaced UHS_DDR50 with MMC_DDR52.
> >
> > CC: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/mmci.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index f320579..c348427 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -299,7 +299,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
> >         if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
> >                 clk |= MCI_ST_8BIT_BUS;
> >
> > -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> > +       if (host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> 
> This will break DDR mode for UHS SD-cards.
> 
> >                 clk |= MCI_ST_UX500_NEG_EDGE;
> >
> >         mmci_write_clkreg(host, clk);
> > @@ -784,7 +784,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
> >                         mmci_write_clkreg(host, clk);
> >                 }
> >
> > -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> > +       if (host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> >                 datactrl |= MCI_ST_DPSM_DDRMODE;
> 
> This will break DDR mode for UHS SD-cards.

Thank you for confirmation.
Will keep UHS mode and just add MMC's DDR52 mode.

Thanks,
Seungwon Jeon

