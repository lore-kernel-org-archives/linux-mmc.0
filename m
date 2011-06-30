From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add the function call for board-specific initialization.
Date: Thu, 30 Jun 2011 09:04:30 +0100
Message-ID: <BANLkTikhwh5M1XB9zRiLzMd7dL18kA_o0g@mail.gmail.com>
References: <1309402665-29228-1-git-send-email-tgih.jun@samsung.com>
	<4E0C18BD.8000608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54489 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab1F3ILo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 04:11:44 -0400
In-Reply-To: <4E0C18BD.8000608@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org

On 30 June 2011 07:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Mr.Jeon
>
> This patch is the compiler error.
>
> didn't find host->card_work..
>
> do you want this
> queue_work(dw_mci_card_workqueue, &slot->host->card_work); ?

I think the patch is based on mmc-next, which has the following commit:
35ba9d8 mmc: dw_mmc: convert card tasklet to workqueue

Cheers
James

>
>
> Regards,
> Jaehoon Chung
>
>
> Seungwon Jeon wrote:
>> Need to call init() function of dw_mci_board.
>> It seems to be omitted to call this function.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 11 +++++++++++
>> =A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index a524416..073c420 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1585,6 +1585,15 @@ static void dw_mci_work_routine_card(struct w=
ork_struct *work)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static irqreturn_t dw_mci_detect_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct dw_mci_slot *slot =3D dev_id;
>> +
>> + =A0 =A0 queue_work(dw_mci_card_workqueue, &host->card_work);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> =A0static int __init dw_mci_init_slot(struct dw_mci *host, unsigned =
int id)
>> =A0{
>> =A0 =A0 =A0 struct mmc_host *mmc;
>> @@ -1657,6 +1666,8 @@ static int __init dw_mci_init_slot(struct dw_m=
ci *host, unsigned int id)
>> =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(host->vmmc);
>>
>> + =A0 =A0 host->pdata->init(id, dw_mci_detect_interrupt, host);
>> +
>> =A0 =A0 =A0 if (dw_mci_get_cd(mmc))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(DW_MMC_CARD_PRESENT, &slot->flag=
s);
>> =A0 =A0 =A0 else
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
James Hogan
