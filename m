From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: mmc: dw_mmc: Add the function call for board-specific initialization.
Date: Fri, 8 Jul 2011 17:15:34 +0900
Message-ID: <CAH9JG2VHAAGS4ySxtVfXLS+ra7j1jrY6TcBhqhFYXHrQ8qb3dw@mail.gmail.com>
References: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
	<CAH9JG2UV2vwDF7p1MivJOa93woTRD3NYjnd++rQWv76K2NqJTg@mail.gmail.com>
	<003301cc3a25$9fd61470$df823d50$%jun@samsung.com>
	<000a01cc3d40$3cc02b50$b64081f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46545 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1GHIPf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 04:15:35 -0400
Received: by vxb39 with SMTP id 39so1221091vxb.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 01:15:34 -0700 (PDT)
In-Reply-To: <000a01cc3d40$3cc02b50$b64081f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>

On Fri, Jul 8, 2011 at 4:25 PM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> Hi Kyungmin Park
>
> I'd appreciate if you give me a opinion about my writing.
> If init call is not used, a checking routine is also not needed.
> How do you think?

Agree, If there are no one use the pdata->init. no required to check it=
=2E

Thank you,
Kyungmin Park

>
> Seungwon Jeon wrote:
>> Hi,
>> > -----Original Message-----
>> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> > owner@vger.kernel.org] On Behalf Of Kyungmin Park
>> > Sent: Monday, July 04, 2011 4:50 PM
>> > To: Seungwon Jeon
>> > Cc: linux-mmc@vger.kernel.org; Chris Ball; Will Newton; Jaehoon Ch=
ung;
>> > James Hogan
>> > Subject: Re: mmc: dw_mmc: Add the function call for board-specific
>> > initialization.
>> >
>> > Hi,
>> >
>> > Yes it's defined and checked, but not used.
>> > Can you describe the reason why init call is required?
>> > and If required, what's the meaning?
>>
>>
>> I think some "board specific" init-routine may be needed, e.g. exter=
nal
>> IRQ for card detection.
>> But there is no call for this in dw_mmc.c currently.
>> If init function is just checked registration of definition and real=
 call
>> is performed outside,
>> we don't need to call this function explicitly.
>>
>> Thank you for comment
>>
>> Best regards,
>> Seungwon.
>>
>>
>> > Thank you,
>> > Kyungmin Park
>> >
>> > On Mon, Jul 4, 2011 at 4:07 PM, Seungwon Jeon <tgih.jun@samsung.co=
m>
>> wrote:
>> > > Need to call init() function of dw_mci_board.
>> > > It seems to be omitted to call this function.
>> > >
>> > > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > > ---
>> > > =A0drivers/mmc/host/dw_mmc.c | =A0 11 +++++++++++
>> > > =A01 files changed, 11 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc=
=2Ec
>> > > index a524416..688d58a 100644
>> > > --- a/drivers/mmc/host/dw_mmc.c
>> > > +++ b/drivers/mmc/host/dw_mmc.c
>> > > @@ -1585,6 +1585,15 @@ static void dw_mci_work_routine_card(stru=
ct
>> > work_struct *work)
>> > > =A0 =A0 =A0 =A0}
>> > > =A0}
>> > >
>> > > +static irqreturn_t dw_mci_detect_interrupt(int irq, void *dev_i=
d)
>> > > +{
>> > > + =A0 =A0 =A0 struct dw_mci_slot *slot =3D dev_id;
>> > > +
>> > > + =A0 =A0 =A0 queue_work(dw_mci_card_workqueue, &slot->host->car=
d_work);
>> > > +
>> > > + =A0 =A0 =A0 return IRQ_HANDLED;
>> > > +}
>> > > +
>> > > =A0static int __init dw_mci_init_slot(struct dw_mci *host, unsig=
ned int
>> id)
>> > > =A0{
>> > > =A0 =A0 =A0 =A0struct mmc_host *mmc;
>> > > @@ -1657,6 +1666,8 @@ static int __init dw_mci_init_slot(struct =
dw_mci
>> > *host, unsigned int id)
>> > > =A0 =A0 =A0 =A0} else
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
>> > >
>> > > + =A0 =A0 =A0 host->pdata->init(id, dw_mci_detect_interrupt, hos=
t);
>> > > +
>> > > =A0 =A0 =A0 =A0if (dw_mci_get_cd(mmc))
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(DW_MMC_CARD_PRESENT, &slo=
t->flags);
>> > > =A0 =A0 =A0 =A0else
>> > > --
>> > > 1.7.0.4
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe linux-=
mmc"
>> in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>> > >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
