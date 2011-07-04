From: =?utf-8?B?7KCE7Iq57JuQ?= <tgih.jun@samsung.com>
Subject: RE: mmc: dw_mmc: Add the function call for board-specific
 initialization.
Date: Mon, 04 Jul 2011 17:37:34 +0900
Message-ID: <003301cc3a25$9fd61470$df823d50$%jun@samsung.com>
References: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
 <CAH9JG2UV2vwDF7p1MivJOa93woTRD3NYjnd++rQWv76K2NqJTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11556 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1GDIhh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 04:37:37 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNS00JM8VYGBMN0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Jul 2011 17:37:36 +0900 (KST)
Received: from DOTGIHJUN01 (12-23-121-83.csky.net [12.23.121.83])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNS008L5VYN4Z@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Jul 2011 17:37:36 +0900 (KST)
In-reply-to: <CAH9JG2UV2vwDF7p1MivJOa93woTRD3NYjnd++rQWv76K2NqJTg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>

Hi,
> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Kyungmin Park
> Sent: Monday, July 04, 2011 4:50 PM
> To: Seungwon Jeon
> Cc: linux-mmc@vger.kernel.org; Chris Ball; Will Newton; Jaehoon Chung;
> James Hogan
> Subject: Re: mmc: dw_mmc: Add the function call for board-specific
> initialization.
> 
> Hi,
> 
> Yes it's defined and checked, but not used.
> Can you describe the reason why init call is required?
> and If required, what's the meaning?


I think some "board specific" init-routine may be needed, e.g. external IRQ for card detection.
But there is no call for this in dw_mmc.c currently.
If init function is just checked registration of definition and real call is performed outside,
we don't need to call this function explicitly.

Thank you for comment

Best regards,
Seungwon.


> Thank you,
> Kyungmin Park
> 
> On Mon, Jul 4, 2011 at 4:07 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Need to call init() function of dw_mci_board.
> > It seems to be omitted to call this function.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index a524416..688d58a 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1585,6 +1585,15 @@ static void dw_mci_work_routine_card(struct
> work_struct *work)
> >        }
> >  }
> >
> > +static irqreturn_t dw_mci_detect_interrupt(int irq, void *dev_id)
> > +{
> > +       struct dw_mci_slot *slot = dev_id;
> > +
> > +       queue_work(dw_mci_card_workqueue, &slot->host->card_work);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> >  static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> >  {
> >        struct mmc_host *mmc;
> > @@ -1657,6 +1666,8 @@ static int __init dw_mci_init_slot(struct dw_mci
> *host, unsigned int id)
> >        } else
> >                regulator_enable(host->vmmc);
> >
> > +       host->pdata->init(id, dw_mci_detect_interrupt, host);
> > +
> >        if (dw_mci_get_cd(mmc))
> >                set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> >        else
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

