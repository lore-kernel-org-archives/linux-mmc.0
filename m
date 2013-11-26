From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH] mmc/sdio: add a quirk for broken SDIO_CCCR_INTx polling
Date: Tue, 26 Nov 2013 11:50:38 -0800
Message-ID: <477F20668A386D41ADCC57781B1F70430F52C179F9@SC-VEXCH1.marvell.com>
References: <1385423638-24791-1-git-send-email-bzhao@marvell.com>
 <CAPDyKFr5G7DCxFjPcMRKZpAiUyky9L3KnTe4VT5NEepu6_n4oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45265 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753617Ab3KZTv1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 14:51:27 -0500
In-Reply-To: <CAPDyKFr5G7DCxFjPcMRKZpAiUyky9L3KnTe4VT5NEepu6_n4oQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Paul Stewart <pstew@chromium.org>, Doug Anderson <dianders@chromium.org>

Hi Ulf,

Thanks for your comments.

> > @@ -89,3 +99,14 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
> >         }
> >  }
> >  EXPORT_SYMBOL(mmc_fixup_device);
> > +
> > +void mmc_fixup_broken_irq_polling(struct mmc_card *card)
> > +{
> > +       unsigned char dummy;
> > +
> > +       /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> > +        * register with a Marvell SD8797 card. A dummy CMD52 read to
> > +        * function 0 register 0xff can aviod this.
> > +        */
> > +       mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> > +}
> 
> I would suggest you follow how the other quirks has been implemented,
> thus I don't think you need a separate function just for invoking an
> extra mmc_io_rw_direct, do directly in sdio_irq.c instead.

Will make this change in v2.

> > @@ -47,6 +47,11 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >         }
> >
> >         ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
> > +
> > +       if (pending && (card->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING) &&
> 
> Suggest you add an mmc_card_broken_irq_poll(), in card.h. Like the
> other quirks are handled.

Sure.

> 
> > +           !(host->caps & MMC_CAP_SDIO_IRQ))
> > +               mmc_fixup_broken_irq_polling(card);
> > +
> >         if (ret) {
> >                 pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> >                        mmc_card_id(card), ret);
> >                 return ret;
> >         }

I will also move the quirk handling down here (after the 'ret' validation).

Thanks,
Bing
